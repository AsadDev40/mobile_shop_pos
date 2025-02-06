import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/utils/constants.dart';

class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.PrimaryGradient : null,
          color: isSelected ? null : Colors.transparent,
          border: isSelected
              ? const Border(
                  left: BorderSide(width: 4, color: AppColors.PrimaryColor))
              : null,
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color:
                isSelected ? AppColors.PrimaryColor : AppColors.BodyTextColor,
          ),
          title: Text(
            title,
            style: AppTextStyles.body1.copyWith(
              color:
                  isSelected ? AppColors.PrimaryColor : AppColors.BodyTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
