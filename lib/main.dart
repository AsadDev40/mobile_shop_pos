import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/screens/dashboard_screen.dart';
import 'package:mobile_shop_pos/service/app_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppProvider(
      child: MaterialApp(
        home: POSDashboard(),
      ),
    );
  }
}
