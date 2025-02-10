import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/vendor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorProvider extends ChangeNotifier {
  static const String _vendorsKey = 'vendors_list';
  List<VendorModel> _vendors = [];

  List<VendorModel> get vendors => _vendors;

  VendorProvider() {
    loadVendors(); // Load data on startup
  }

  /// Load vendors from SharedPreferences
  Future<void> loadVendors() async {
    final prefs = await SharedPreferences.getInstance();
    final String? vendorsString = prefs.getString(_vendorsKey);

    if (vendorsString != null) {
      List<dynamic> decodedList = jsonDecode(vendorsString);
      _vendors = decodedList.map((json) => VendorModel.fromJson(json)).toList();
    }
    notifyListeners();
  }

  /// Save vendors to SharedPreferences
  Future<void> _saveVendors() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _vendorsKey,
      jsonEncode(_vendors.map((v) => v.toJson()).toList()),
    );
  }

  /// Add a new vendor
  Future<void> addVendor(VendorModel vendor) async {
    _vendors.add(vendor);
    await _saveVendors();
    notifyListeners();
  }

  /// Edit an existing vendor
  Future<void> editVendor(VendorModel updatedVendor) async {
    _vendors = _vendors.map((vendor) {
      return vendor.id == updatedVendor.id ? updatedVendor : vendor;
    }).toList();
    await _saveVendors();
    notifyListeners();
  }

  /// Delete a vendor by ID
  Future<void> deleteVendor(String id) async {
    _vendors.removeWhere((vendor) => vendor.id == id);
    await _saveVendors();
    notifyListeners();
  }
}
