import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/customer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerProvider extends ChangeNotifier {
  static const String _customersKey = 'customers_list';
  List<CustomerModel> _customers = [];

  List<CustomerModel> get customers => _customers;

  CustomerProvider() {
    loadCustomers(); // Load data on startup
  }

  /// Load customers from SharedPreferences
  Future<void> loadCustomers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? customersString = prefs.getString(_customersKey);

    if (customersString != null) {
      List<dynamic> decodedList = jsonDecode(customersString);
      _customers =
          decodedList.map((json) => CustomerModel.fromJson(json)).toList();
    }
    notifyListeners();
  }

  /// Save customers to SharedPreferences
  Future<void> _saveCustomers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _customersKey,
      jsonEncode(_customers.map((c) => c.toJson()).toList()),
    );
  }

  /// Add a new customer
  Future<void> addCustomer(CustomerModel customer) async {
    _customers.add(customer);
    await _saveCustomers();
    notifyListeners();
  }

  /// Edit an existing customer
  Future<void> editCustomer(CustomerModel updatedCustomer) async {
    _customers = _customers.map((customer) {
      return customer.customerCnic == updatedCustomer.customerCnic
          ? updatedCustomer
          : customer;
    }).toList();
    await _saveCustomers();
    notifyListeners();
  }

  /// Delete a customer by CNIC
  Future<void> deleteCustomer(String customerCnic) async {
    _customers.removeWhere((customer) => customer.customerCnic == customerCnic);
    await _saveCustomers();
    notifyListeners();
  }
}
