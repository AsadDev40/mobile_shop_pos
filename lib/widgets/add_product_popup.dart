import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/utils/app_list.dart';

import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/custom_drop_dpwn.dart';
import 'package:mobile_shop_pos/widgets/custom_textfield.dart';

class AddProductPopup extends StatefulWidget {
  const AddProductPopup({super.key});

  @override
  State<AddProductPopup> createState() => _AddProductPopupState();
}

class _AddProductPopupState extends State<AddProductPopup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController invoiceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController ramController = TextEditingController();
  final TextEditingController romController = TextEditingController();
  final TextEditingController vendorController = TextEditingController();
  final TextEditingController imei1Controller = TextEditingController();
  final TextEditingController imei2Controller = TextEditingController();
  String selectedCompany = 'Select Company';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Product",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: nameController,
                hintText: "Product Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: invoiceController,
                hintText: "Invoice ",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: priceController,
                hintText: "Sale Price",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: ramController,
                hintText: "RAM",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: romController,
                hintText: "ROM",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: vendorController,
                hintText: "Vendor Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: imei1Controller,
                hintText: "IMEI 1",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: imei2Controller,
                hintText: "IMEI2",
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomDropDown(
                  backGroundColor: Colors.white,
                  borderColor: AppColors.BodyTextColor,
                  onChanged: (value) {
                    setState(() {
                      selectedCompany = value!;
                    });
                  },
                  value: selectedCompany,
                  list: companiesList,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  child: Text("Add Product",
                      style: AppTextStyles.body1.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
