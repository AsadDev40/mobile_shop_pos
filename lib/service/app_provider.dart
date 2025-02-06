import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/provider/date_picker_provider.dart';
import 'package:mobile_shop_pos/provider/image_picker_provider.dart';
import 'package:provider/provider.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
          ChangeNotifierProvider(create: (context) => DatePickerProvider()),
        ],
        child: child,
      );
}
