import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:mobile_shop_pos/service/utils.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddProductQuantityPopup extends StatefulWidget {
  final ProductModel productModel;
  const AddProductQuantityPopup({super.key, required this.productModel});

  @override
  State<AddProductQuantityPopup> createState() =>
      _AddProductQuantityPopupState();
}

class _AddProductQuantityPopupState extends State<AddProductQuantityPopup> {
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController imei1Controller = TextEditingController();
  final TextEditingController imei2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<ProductProvider>(context);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Quantity",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: serialNumberController,
                hintText: "Serial Number",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: imei1Controller,
                hintText: "Imei1",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: imei2Controller,
                hintText: "Imei2",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (imei1Controller.text.isEmpty) {
                    Utils.showToast('Please enter imei');
                  } else if (serialNumberController.text.isEmpty) {
                    Utils.showToast('please enter serail number');
                  }
                  final String productId = const Uuid().v4();
                  final ProductModel newProduct = ProductModel(
                      productId: productId,
                      productName: widget.productModel.productName,
                      productInvoice: widget.productModel.productInvoice,
                      salePrice: widget.productModel.salePrice,
                      ram: widget.productModel.ram,
                      rom: widget.productModel.rom,
                      stock: 'availiable',
                      imeiNumbers: [imei1Controller.text, imei2Controller.text],
                      serialNumbers: [serialNumberController.text],
                      company: widget.productModel.company);
                  imei1Controller.clear();
                  imei2Controller.clear();
                  serialNumberController.clear();
                  await productprovider.addProduct(newProduct);
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
                  child: Text("Add",
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
