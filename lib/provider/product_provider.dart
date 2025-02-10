// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  static const String _accessoriesKey = 'accessories_list';
  static const String _productsKey = 'products_list';
  static const String _salesKey = 'sales_list';

  List<AccessoriesModel> _accessories = [];
  List<ProductModel> _products = [];
  List<AccessoriesModel> _sales = [];

  List<AccessoriesModel> get accessories => _accessories;
  List<ProductModel> get products => _products;
  List<AccessoriesModel> get sales => _sales;

  ProductProvider() {
    _loadAllData();
  }

  /// Load all data (Products, Accessories, Sales)
  Future<void> _loadAllData() async {
    await Future.wait([loadProducts(), loadAccessories(), loadSales()]);
  }

  /// Load products from SharedPreferences
  Future<void> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsString = prefs.getString(_productsKey);

    if (productsString != null) {
      List<dynamic> decodedList = jsonDecode(productsString);
      _products =
          decodedList.map((json) => ProductModel.fromJson(json)).toList();
    }
    notifyListeners();
  }

  /// Save products to SharedPreferences
  Future<void> _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _productsKey, jsonEncode(_products.map((p) => p.toJson()).toList()));
    await loadProducts();
  }

  /// Add a new product
  Future<void> addProduct(ProductModel product) async {
    _products.add(product);
    await _saveProducts();
  }

  /// Edit an existing product
  Future<void> editProduct(ProductModel updatedProduct) async {
    _products = _products.map((product) {
      return product.productId == updatedProduct.productId
          ? updatedProduct
          : product;
    }).toList();
    await _saveProducts();
  }

  /// Delete a product by ID
  Future<void> deleteProduct(String productId) async {
    _products.removeWhere((product) => product.productId == productId);
    await _saveProducts();
  }

  /// Update specific fields of a product
  Future<void> updateProductFields({
    required DateTime dateTime,
    required String productId,
    required String stock,
    String? customerName,
    int? customerCnic,
    String? customerAddress,
  }) async {
    for (var product in _products) {
      if (product.productId == productId) {
        product.dateTime = dateTime;
        product.stock = stock;
        product.customerName = customerName ?? product.customerName;
        product.customerCnic = customerCnic ?? product.customerCnic;
        product.customerAddress = customerAddress ?? product.customerAddress;
        break;
      }
    }
    await _saveProducts();
  }

  /// Get products filtered by stock
  List<ProductModel> getProductsByStock(String stockValue) {
    return _products.where((product) => product.stock == stockValue).toList();
  }

  /// Load accessories from SharedPreferences
  Future<void> loadAccessories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? accessoriesString = prefs.getString(_accessoriesKey);

    if (accessoriesString != null) {
      List<dynamic> decodedList = jsonDecode(accessoriesString);
      _accessories =
          decodedList.map((json) => AccessoriesModel.fromJson(json)).toList();
    }
    notifyListeners();
  }

  /// Save accessories to SharedPreferences
  Future<void> _saveAccessories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _accessoriesKey,
      jsonEncode(_accessories.map((a) => a.toJson()).toList()),
    );
    await loadAccessories();
  }

  /// Add a new accessory
  Future<void> addAccessory(AccessoriesModel accessory) async {
    _accessories.add(accessory);
    await _saveAccessories();
  }

  /// Edit an existing accessory
  Future<void> editAccessory(AccessoriesModel updatedAccessory) async {
    _accessories = _accessories.map((accessory) {
      return accessory.id == updatedAccessory.id ? updatedAccessory : accessory;
    }).toList();
    await _saveAccessories();
  }

  /// Delete an accessory by ID
  Future<void> deleteAccessory(String id) async {
    _accessories.removeWhere((accessory) => accessory.id == id);
    await _saveAccessories();
  }

  /// Update accessory stock
  Future<void> updateStock(String id, int newStock) async {
    final index = _accessories.indexWhere((accessory) => accessory.id == id);
    if (index != -1) {
      _accessories[index].quantity += newStock;
      await _saveAccessories();
    }
  }

  /// Load sales from SharedPreferences
  Future<void> loadSales() async {
    final prefs = await SharedPreferences.getInstance();
    final String? salesString = prefs.getString(_salesKey);

    if (salesString != null) {
      List<dynamic> decodedList = jsonDecode(salesString);
      _sales =
          decodedList.map((json) => AccessoriesModel.fromJson(json)).toList();
    }
    notifyListeners();
  }

  /// Save sales to SharedPreferences
  Future<void> _saveSales() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _salesKey, jsonEncode(_sales.map((s) => s.toJson()).toList()));
    await loadSales();
  }

  /// Sell an accessory and update stock
  Future<void> sellAccessory(String id, int quantitySold, String customerName,
      DateTime dateTime) async {
    final index = _accessories.indexWhere((accessory) => accessory.id == id);

    if (index != -1) {
      if (_accessories[index].quantity >= quantitySold) {
        _accessories[index].quantity -= quantitySold;

        _sales.add(AccessoriesModel(
          dateTime: dateTime,
          id: _accessories[index].id,
          name: _accessories[index].name,
          quantity: quantitySold,
          customerName: customerName,
          invoice: _accessories[index].invoice,
          price: _accessories[index].price * quantitySold,
        ));

        await _saveAccessories();
        await _saveSales();
      } else {
        print(
            "Error: Not enough stock to sell! Available: ${_accessories[index].quantity}");
      }
    } else {
      print("Error: Accessory with ID $id not found!");
    }
  }
}
