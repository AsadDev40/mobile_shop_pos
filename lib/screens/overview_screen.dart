import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/statcard_widget.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              StatCard(
                  title: 'Total Sales',
                  value: 'RS 12,345',
                  color: AppColors.PrimaryColor),
              SizedBox(width: 16),
              StatCard(
                  title: 'Total products',
                  value: '1,234',
                  color: AppColors.SecondaryColor),
              StatCard(
                  title: 'Profit',
                  value: 'RS 1,234',
                  color: AppColors.TertiaryColor),
              StatCard(
                  title: 'Losses',
                  value: 'RS 1,234',
                  color: AppColors.PrimaryColor),
              SizedBox(width: 16),
              StatCard(
                  title: 'Customers',
                  value: '567',
                  color: AppColors.SecondaryColor),
            ],
          ),
        ],
      ),
    );
  }
}
