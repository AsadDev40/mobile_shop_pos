import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.height,
    this.width,
    this.onSaved,
    this.hintText,
    this.focusNode,
    this.onChanged,
    this.controller,
    this.validator,
    this.initialValue,
    this.onTap,
    this.keyboardType,
    this.textAndIconColor,
    this.prefixIconData,
    this.suffixWidget,
    this.isPassword = false,
    this.enabled = true,
    this.readOnly = false,
    this.textAlign = TextAlign.left,
    this.hintTextColor = AppColors.BodyTextColor,
    this.contentPadding,
    this.enableBorder = true,
    this.hintStyle,
    this.textStyle,
    this.maxLines,
    this.borderRadius,
    this.borderColor,
  });

  final double? height;
  final double? width;
  final String? hintText;
  final bool isPassword;
  final bool enabled;
  final bool readOnly;
  final TextAlign textAlign;
  final String? Function(String?)? validator;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Color? textAndIconColor;
  final Color? borderColor;
  final IconData? prefixIconData;
  final Widget? suffixWidget;
  final Color hintTextColor;
  final EdgeInsetsGeometry? contentPadding;
  final bool enableBorder;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final int? maxLines;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 7),
      height: height ?? 60,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 30),
        border: enableBorder
            ? Border.all(color: borderColor ?? AppColors.BodyTextColor)
            : null,
        color: Colors.white,
      ),
      child: TextFormField(
        onTap: onTap,
        onSaved: onSaved,
        enabled: enabled,
        readOnly: readOnly,
        textAlign: textAlign,
        initialValue: initialValue,
        maxLines: maxLines ?? 1, // Default to single line if maxLines is null
        onChanged: onChanged,
        obscureText: isPassword,
        cursorColor: AppColors.MainTextColor,
        style: textStyle ?? const TextStyle(color: AppColors.MainTextColor),
        focusNode: focusNode,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          hintStyle: hintStyle ??
              Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: hintTextColor,
                    fontWeight: FontWeight.bold,
                  ),
          prefixIcon: prefixIconData != null
              ? Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 2, bottom: 2, right: 7),
                  decoration: const BoxDecoration(
                      color: AppColors.SecondaryColor, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      prefixIconData,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              : null,
          suffixIcon: suffixWidget,
        ),
      ),
    );
  }
}
