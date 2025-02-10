import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class EditAccessoryPopup extends StatefulWidget {
  final AccessoriesModel accessory;

  const EditAccessoryPopup({super.key, required this.accessory});

  @override
  State<EditAccessoryPopup> createState() => _EditAccessoryPopupState();
}

class _EditAccessoryPopupState extends State<EditAccessoryPopup> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController invoiceController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.accessory.name);
    quantityController =
        TextEditingController(text: widget.accessory.quantity.toString());
    invoiceController =
        TextEditingController(text: widget.accessory.invoice.toString());
    priceController =
        TextEditingController(text: widget.accessory.price.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    invoiceController.dispose();
    priceController.dispose();
    super.dispose();
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
                "Edit Accessory",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: nameController,
                hintText: "Accessory Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: quantityController,
                hintText: "Quantity",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: invoiceController,
                hintText: "Invoice Price",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: priceController,
                hintText: "Price",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final AccessoriesModel updatedAccessory = AccessoriesModel(
                    id: widget.accessory.id,
                    name: nameController.text,
                    quantity: int.parse(quantityController.text),
                    invoice: int.parse(invoiceController.text),
                    price: int.parse(priceController.text),
                  );
                  productProvider.editAccessory(updatedAccessory);
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
                  child: Text("Update Accessory",
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
