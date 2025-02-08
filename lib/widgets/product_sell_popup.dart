import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/custom_textfield.dart';

class SellProductPopUp extends StatefulWidget {
  final ProductModel productModel;
  const SellProductPopUp({super.key, required this.productModel});

  @override
  State<SellProductPopUp> createState() => _SellProductPopUpState();
}

class _SellProductPopUpState extends State<SellProductPopUp> {
  final TextEditingController customerName = TextEditingController();
  final TextEditingController customerAddress = TextEditingController();
  final TextEditingController customerCnic = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                "Sell Product",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: customerName,
                hintText: "Customer Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: customerCnic,
                hintText: "Customer Cnic",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: customerAddress,
                hintText: "Customer Address",
                keyboardType: TextInputType.number,
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
                  child: Text("Sell",
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
