import 'package:app_calorie/models/coupon.dart';
import 'package:flutter/material.dart';

//THis class extends ChangeNotifier. It will act as data repository to be shared thorugh the application.
class CouponsList extends ChangeNotifier{

  //For simplicity, a product is just a String
  List<Coupon> myCoupons = [];

  void addCoupon(Coupon newCoupon){
  myCoupons.add(newCoupon); 
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  }

  void deleteCoupon(int index){
    myCoupons.removeAt(index);
    notifyListeners();
  }
}//CouponsList