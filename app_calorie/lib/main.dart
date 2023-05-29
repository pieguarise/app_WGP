import 'package:app_calorie/models/couponsList.dart';
import 'package:app_calorie/models/totalCal.dart';
import 'package:app_calorie/pages/impactAuth.dart';
import 'package:app_calorie/pages/loginPage.dart';
import 'package:app_calorie/pages/splash.dart';
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
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<CouponsList>(create: (context) => CouponsList()),
        ChangeNotifierProvider<TotalCal>(create: (context) => TotalCal())
        ],
      child: MaterialApp(
        title: 'APP WGP',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const Splash(),
      ),
    );    
  }
}
