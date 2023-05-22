
import 'package:app_calorie/models/couponsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Coupon{
  String title;
  String description;
  //String description;
  Coupon({required this.title, required this.description});
}

Coupon generateCoupon(double val){
  String title="Nike";
  if (val==2){
    title="Lowa";
  } else if (val == 3){
    title = "Bottecchia";
  }
  String description = "fu";
  /*
  ListTile coup = ListTile (
          leading: Icon(Icons.card_giftcard),
          title: Text(title),
          subtitle: Text(description),     
          onTap: deleteCoupon(int index),
          );
  */
  return Coupon(title: title, description: description);

}


