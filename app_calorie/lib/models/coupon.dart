
import 'package:app_calorie/models/couponsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

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
  String description = _generateRandomDescription(val);
  Image immagine = Image.asset("assets/${title.toLowerCase()}.png",width: 50, height: 50);
 
  return Coupon(title: title, description: description, immagine: immagine);

}

String _generateRandomDescription(double val) {
  int codice = Random().nextInt(2);
  String description = ''; 
  if (val == 1){ 
    // Nike
    if (codice==0){
    description = 'Get a 10% discount on shoes department'; 
  } else if (codice == 1){
    description = 'Get a 15% discount on running department'; 
  } else if (codice == 2){
    description = 'Ticket for the next limited edition shoes raffle'; 
  }} 
  else if (val == 2){ 
    // Lowa
    if (codice==0){
    description = 'Get a 25% discount on trekking department';
  } else if (codice == 1){
    description = 'Get a 15% discount on children department';
  } else if (codice == 2){
    description = 'Free pair of socks on your next purchase'; 
  }}
  else if (val == 3){ 
    // Bottecchia
    if (codice==0){
    description = 'Get a 30% discount on your next e-bike purchase'; 
  } else if (codice == 1){
    description = 'Get a 15% discount on technical clothing';  
  } else if (codice == 2){
    description = 'Ticket for limited edition bike lottery'; 
  }};


  return description;
}



