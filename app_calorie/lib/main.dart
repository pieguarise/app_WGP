import 'package:app_calorie/models/couponsList.dart';
import 'package:flutter/material.dart';
import 'package:app_calorie/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CouponsList>(
      create: (context) => CouponsList(),
      child: MaterialApp(
        title: 'APP WGP',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Home(),
      ),
    );
  }
}
