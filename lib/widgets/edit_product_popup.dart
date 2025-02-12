import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:mobile_shop_pos/service/utils.dart';
import 'package:mobile_shop_pos/utils/app_list.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/custom_drop_dpwn.dart';
import 'package:mobile_shop_pos/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class EditProductPopup extends StatefulWidget {
  final ProductModel product;

  const EditProductPopup({super.key, required this.product});

  @override
  State<EditProductPopup> createState() => _EditProductPopupState();
}

class _EditProductPopupState extends State<EditProductPopup> {
  late TextEditingController nameController;
  late TextEditingController invoiceController;
  late TextEditingController ramController;
  late TextEditingController romController;
  late TextEditingController vendorController;
  late TextEditingController imei1Controller;
  late TextEditingController imei2Controller;
  late TextEditingController serialNumberController;
  late String selectedCompany;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.productName);
    invoiceController =
        TextEditingController(text: widget.product.productInvoice);
    ramController = TextEditingController(text: widget.product.ram);
    romController = TextEditingController(text: widget.product.rom);
    vendorController = TextEditingController(text: widget.product.vendorName);
    serialNumberController = TextEditingController(
        text: widget.product.serialNumbers.isNotEmpty
            ? widget.product.serialNumbers.first
            : '');
    imei1Controller = TextEditingController(
        text: widget.product.imeiNumbers.isNotEmpty
            ? widget.product.imeiNumbers.first
            : '');
    imei2Controller = TextEditingController(
        text: widget.product.imeiNumbers.length > 1
            ? widget.product.imeiNumbers[1]
            : '');
    selectedCompany = widget.product.company;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
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
                "Edit Product",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                  controller: nameController, hintText: "Product Name"),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: invoiceController, hintText: "Invoice"),
              const SizedBox(height: 10),
              CustomTextField(controller: ramController, hintText: "RAM"),
              const SizedBox(height: 10),
              CustomTextField(controller: romController, hintText: "ROM"),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: vendorController, hintText: "Vendor Name"),
              const SizedBox(height: 10),
              CustomTextField(
                  controller: serialNumberController,
                  hintText: "Serial Number"),
              const SizedBox(height: 10),
              CustomTextField(controller: imei1Controller, hintText: "IMEI 1"),
              const SizedBox(height: 10),
              CustomTextField(controller: imei2Controller, hintText: "IMEI 2"),
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
                onPressed: () async {
                  if (nameController.text.isEmpty) {
                    Utils.showToast('Please Enter Product Name');
                    return;
                  }

                  final updatedProduct = ProductModel(
                    productId: widget.product.productId,
                    productName: nameController.text,
                    productInvoice: invoiceController.text,
                    ram: ramController.text,
                    rom: romController.text,
                    stock: widget.product.stock,
                    vendorName: vendorController.text,
                    imeiNumbers: [imei1Controller.text, imei2Controller.text],
                    serialNumbers: [serialNumberController.text],
                    company: selectedCompany,
                  );
                  await productProvider.editProduct(updatedProduct);
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
                  child: Text("Update Product",
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
