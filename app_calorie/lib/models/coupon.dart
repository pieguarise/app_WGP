import 'package:flutter/material.dart';

class Coupon{
  ListTile coup;
  //String title;
  //String description;
  Coupon({required this.coup});
}

Coupon generateCoupon(double val){
  String title="Nike";
  if (val==2){
    title="Lowa";
  } else if (val == 3){
    title = "Bottecchia";
  }
  String description = "fu";
  ListTile coup = ListTile (
          leading: Icon(Icons.card_giftcard),
          title: Text(title),
          subtitle: Text(description),     
  
          );

  return Coupon(coup: coup);

}
