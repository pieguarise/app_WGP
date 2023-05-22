
import 'package:app_calorie/models/couponsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Coupon{
  String title;
  String description;
  Image? immagine;
  //String description;
  Coupon({required this.title, required this.description, this.immagine});
}

Coupon generateCoupon(double val){
  String title="Nike";
  if (val==2){
    title="Lowa";
  } else if (val == 3){
    title = "Bottecchia";
  }
  String description = "fu";
  Image immagine = Image.asset("assets/${title.toLowerCase()}.png",width: 50, height: 50);
 
  return Coupon(title: title, description: description, immagine: immagine);

}


