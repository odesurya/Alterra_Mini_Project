import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alterra_mini_project/model/cart_provider.dart';
import 'package:alterra_mini_project/model/checkout_payment_provider.dart';
import 'package:alterra_mini_project/model/search_provider.dart';
import 'main_wrapper.dart';
import '../utils/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutPaymentProvider()),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        title: 'My App',
        home: const MainWrapper(),
      ),
    );
  }
}
