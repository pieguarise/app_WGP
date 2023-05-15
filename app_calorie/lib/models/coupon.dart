import 'package:flutter/material.dart';

class Coupon{
  ListTile coup;
  //String title;
  //String description;
  Coupon({required this.coup});
}

Coupon generateCoupon(int val){
  String title="Nike";
  if (val==1){
    title="Lowa";
  } else if (val == 2){
    title = "Bottecchia";
  }
  String description = "fu";
  ListTile coup = ListTile (
          leading: Icon(Icons.card_giftcard),
          title: Text(title),
          subtitle: Text(description));
  return Coupon(coup: coup);

}
