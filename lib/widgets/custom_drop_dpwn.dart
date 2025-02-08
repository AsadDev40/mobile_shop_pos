import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    required this.onChanged,
    required this.value,
    required this.list,
    this.hintText,
    this.expanded = false,
    this.hintTextColor = Colors.grey,
    this.textColor,
    this.borderRadius = 30,
    this.borderColor,
    this.borderWidth = 1.0,
    this.padding,
    this.enableBorder = true,
    this.backGroundColor,
    super.key,
  });

  final String? hintText;
  final String? value;
  final List<String> list;
  final bool expanded;
  final void Function(String?)? onChanged;
  final Color? textColor;
  final double borderRadius;
  final Color? borderColor;
  final Color hintTextColor;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final bool enableBorder;
  final Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: enableBorder
            ? Border.all(color: borderColor ?? Colors.black, width: borderWidth)
            : null,
        color: backGroundColor ?? theme.scaffoldBackgroundColor,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          isExpanded: expanded,
          value: value,
          hint: hintText != null
              ? Text(
                  hintText!,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: hintTextColor,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
          underline: Container(color: Colors.transparent),
          onChanged: onChanged,
          iconStyleData: const IconStyleData(
              icon: Icon(
            Icons.expand_more,
            weight: 10,
          )),
          items: list
              .map<DropdownMenuItem<String>>(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: textColor ?? theme.colorScheme.onSurface,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
