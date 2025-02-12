// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:path_provider/path_provider.dart';
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
  List<double> salesDataThisWeek = [];
  List<double> lossDataThisWeek = [];
  List<double> salesDataThisYear = [];
  List<double> lossDataThisYear = [];

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
    DateTime? dateTime,
    required String salePrice,
    required String productId,
    required String stock,
    String? customerName,
    int? customerCnic,
    String? customerAddress,
  }) async {
    for (var product in _products) {
      if (product.productId == productId) {
        product.dateTime = dateTime ?? null;
        product.stock = stock;
        product.salePrice = salePrice;
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
      DateTime dateTime, int price) async {
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
          price: price * quantitySold,
          vendorName: '',
        ));

        await _saveAccessories();
        await _saveSales();
      } else {}
    }
  }

  /// Return an accessory and update stock
  Future<void> returnAccessory(String id, int quantityReturned) async {
    // Find the accessory in the sales list
    final saleIndex = _sales.indexWhere((sale) => sale.id == id);

    if (saleIndex != -1) {
      // Find the accessory in the main accessories list
      final accessoryIndex =
          _accessories.indexWhere((accessory) => accessory.id == id);

      if (accessoryIndex != -1) {
        // Increase the stock of the accessory
        _accessories[accessoryIndex].quantity += quantityReturned;
      }

      // Remove the returned accessory from sales
      _sales.removeAt(saleIndex);

      await _saveAccessories();
      await _saveSales();
    }
  }

  /// Get total sales for accessories
  double getTotalAccessoriesSales() {
    return _sales.fold(0.0, (sum, sale) => sum + (sale.price ?? 0).toDouble());
  }

  /// Get total profit for accessories
  double getTotalAccessoriesProfit() {
    double totalProfit = 0.0;

    for (var sale in _sales) {
      final originalAccessory = _accessories.firstWhere(
        (a) => a.id == sale.id,
        orElse: () => AccessoriesModel(
          id: '',
          name: '',
          vendorName: '',
          quantity: 0,
          invoice: 0,
          price: 0,
        ),
      );

      // Cost per unit (Invoice price)
      double costPerUnit = originalAccessory.invoice.toDouble();
      // Sale revenue per unit
      double salePricePerUnit = (sale.price ?? 0) / sale.quantity;

      // Profit calculation
      if (salePricePerUnit > costPerUnit) {
        totalProfit += (salePricePerUnit - costPerUnit) * sale.quantity;
      }
    }

    return totalProfit;
  }

  /// Get total loss for accessories
  double getTotalAccessoriesLoss() {
    double totalLoss = 0.0;

    for (var sale in _sales) {
      final originalAccessory = _accessories.firstWhere(
        (a) => a.id == sale.id,
        orElse: () => AccessoriesModel(
          id: '',
          name: '',
          quantity: 0,
          invoice: 0,
          price: 0,
          vendorName: '',
        ),
      );

      // Cost per unit (Invoice price)
      double costPerUnit = originalAccessory.invoice.toDouble();
      // Sale revenue per unit
      double salePricePerUnit = (sale.price ?? 0) / sale.quantity;

      // Loss calculation
      if (costPerUnit > salePricePerUnit) {
        totalLoss += (costPerUnit - salePricePerUnit) * sale.quantity;
      }
    }

    return totalLoss;
  }

  /// Get products where stock is sold
  List<ProductModel> getSoldProducts() {
    return _products.where((product) => product.stock == 'sold').toList();
  }

  /// Calculate total sales for products
  double getTotalProductSales() {
    return getSoldProducts().fold(0.0, (sum, product) {
      // Parse salePrice to double safely
      double price = double.tryParse(product.salePrice.toString()) ?? 0.0;
      return sum + price;
    });
  }

  /// Calculate total profit for products
  double getTotalProductProfit() {
    double totalProfit = 0.0;

    for (var product in getSoldProducts()) {
      double salePrice = double.tryParse(product.salePrice.toString()) ?? 0.0;
      double invoicePrice = double.tryParse(product.productInvoice) ?? 0.0;

      if (salePrice > invoicePrice) {
        totalProfit += salePrice - invoicePrice;
      }
    }

    return totalProfit;
  }

  /// Calculate total loss for products
  double getTotalProductLoss() {
    double totalLoss = 0.0;

    for (var product in getSoldProducts()) {
      double salePrice = double.tryParse(product.salePrice.toString()) ?? 0.0;
      double invoicePrice = double.tryParse(product.productInvoice) ?? 0.0;

      if (invoicePrice > salePrice) {
        totalLoss += invoicePrice - salePrice;
      }
    }

    return totalLoss;
  }

  double getTotalSalesForDay(DateTime date) {
    return _sales
        .where((sale) =>
            sale.dateTime != null &&
            sale.dateTime!.year == date.year &&
            sale.dateTime!.month == date.month &&
            sale.dateTime!.day == date.day)
        .fold(0.0, (sum, sale) => sum + (sale.price ?? 0).toDouble());
  }

  double getTotalLossForDay(DateTime date) {
    return _sales
        .where((sale) =>
            sale.dateTime != null &&
            sale.dateTime!.year == date.year &&
            sale.dateTime!.month == date.month &&
            sale.dateTime!.day == date.day)
        .fold(0.0, (sum, sale) {
      final accessory = _accessories.firstWhere((a) => a.id == sale.id,
          orElse: () => AccessoriesModel(
              id: '',
              name: '',
              quantity: 0,
              invoice: 0,
              price: 0,
              vendorName: ''));
      double cost = (accessory.invoice * sale.quantity).toDouble();
      double revenue = (accessory.price ?? 0 * sale.quantity).toDouble();
      return cost > revenue ? sum + (cost - revenue) : sum;
    });
  }

  double getTotalSalesForMonth(DateTime monthStart) {
    return _sales
        .where((sale) =>
            sale.dateTime != null &&
            sale.dateTime!.year == monthStart.year &&
            sale.dateTime!.month == monthStart.month)
        .fold(0.0, (sum, sale) => sum + (sale.price ?? 0).toDouble());
  }

  double getTotalLossForMonth(DateTime monthStart) {
    return _sales
        .where((sale) =>
            sale.dateTime != null &&
            sale.dateTime!.year == monthStart.year &&
            sale.dateTime!.month == monthStart.month)
        .fold(0.0, (sum, sale) {
      final accessory = _accessories.firstWhere((a) => a.id == sale.id,
          orElse: () => AccessoriesModel(
              id: '',
              name: '',
              quantity: 0,
              invoice: 0,
              price: 0,
              vendorName: ''));
      double cost = (accessory.invoice * sale.quantity).toDouble();
      double revenue = (accessory.price ?? 0 * sale.quantity).toDouble();
      return cost > revenue ? sum + (cost - revenue) : sum;
    });
  }

  void updateSalesAndLossData() {
    salesDataThisWeek = List.generate(7, (index) {
      DateTime day = DateTime.now().subtract(Duration(days: index));
      return getTotalSalesForDay(day);
    }).reversed.toList(); // Reverse to keep chronological order

    lossDataThisWeek = List.generate(7, (index) {
      DateTime day = DateTime.now().subtract(Duration(days: index));
      return getTotalLossForDay(day);
    }).reversed.toList(); // Reverse to keep chronological order

    salesDataThisYear = List.generate(12, (index) {
      DateTime monthStart = DateTime(DateTime.now().year, index + 1, 1);
      return getTotalSalesForMonth(monthStart);
    });

    lossDataThisYear = List.generate(12, (index) {
      DateTime monthStart = DateTime(DateTime.now().year, index + 1, 1);
      return getTotalLossForMonth(monthStart);
    });

    notifyListeners();
  }

  /// Get sales data with percentage breakdown for each company
  List<Map<String, dynamic>> getSalesPercentage() {
    // Define the main companies
    final List<String> mainCompanies = ['Infinix', 'Techno', 'Realme', 'Redmi'];
    Map<String, double> salesMap = {}; // Store sales for each company
    double totalSales = 0.0; // Track total sales

    // Initialize map with 0 values for predefined companies
    for (var company in mainCompanies) {
      salesMap[company] = 0.0;
    }
    salesMap['Others'] = 0.0; // Initialize others category

    // Calculate total sales per company (only for sold products)
    for (var product in _products) {
      if (product.stock.toLowerCase() == "sold") {
        String company = mainCompanies.firstWhere(
          (c) => product.company.toLowerCase().contains(c.toLowerCase()),
          orElse: () => 'Others',
        );

        // Convert salePrice to double and add to salesMap
        double salePrice = double.tryParse(product.salePrice.toString()) ?? 0.0;
        salesMap[company] = (salesMap[company] ?? 0) + salePrice;
        totalSales += salePrice;
      }
    }

    // Convert to percentage and prepare chart data
    List<Map<String, dynamic>> salesData = salesMap.entries
        .map((entry) => {
              'company': entry.key,
              'sales': entry.value,
              'percentage':
                  totalSales > 0 ? (entry.value / totalSales) * 100 : 0.0,
            })
        .toList();

    return salesData;
  }

  /// Export data to a JSON file on the desktop or user-selected location
  Future<void> exportData() async {
    // Prepare the data to export
    final Map<String, dynamic> data = {
      'products': _products.map((p) => p.toJson()).toList(),
      'accessories': _accessories.map((a) => a.toJson()).toList(),
      'sales': _sales.map((s) => s.toJson()).toList(),
    };

    // Convert data to JSON string
    final String jsonString = jsonEncode(data);

    // Get the desktop directory
    final String? desktopPath = await _getDesktopPath();
    if (desktopPath == null) {
      throw Exception("Desktop directory not found");
    }

    // Let the user choose the file name and location
    String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Data File',
      fileName: 'mobile_shop_data_${DateTime.now().toIso8601String()}.json',
      initialDirectory: desktopPath, // Default to desktop
    );

    if (filePath != null) {
      // Write the JSON string to the selected file
      final File file = File(filePath);
      await file.writeAsString(jsonString);
    } else {
      throw Exception("File path not selected");
    }
  }

  /// Helper method to get the desktop directory
  Future<String?> _getDesktopPath() async {
    if (Platform.isWindows || Platform.isMacOS) {
      final directory =
          await getDownloadsDirectory(); // Fallback to Downloads if desktop is not available
      return directory?.path;
    }
    return null;
  }

  /// Import data from a JSON file on the desktop or user-selected location
  Future<void> importData() async {
    // Let the user pick a file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      dialogTitle: 'Select Data File',
    );

    if (result != null) {
      // Read the selected file
      final File file = File(result.files.single.path!);
      final String jsonString = await file.readAsString();
      final Map<String, dynamic> data = jsonDecode(jsonString);

      // Load the data into the provider
      _products = (data['products'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
      _accessories = (data['accessories'] as List)
          .map((json) => AccessoriesModel.fromJson(json))
          .toList();
      _sales = (data['sales'] as List)
          .map((json) => AccessoriesModel.fromJson(json))
          .toList();

      // Save the imported data to SharedPreferences
      await _saveProducts();
      await _saveAccessories();
      await _saveSales();

      // Notify listeners to update the UI
      notifyListeners();
    } else {
      throw Exception("File not selected");
    }
  }
}
