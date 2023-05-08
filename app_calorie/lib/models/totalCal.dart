import 'package:flutter/material.dart';

//THis class extends ChangeNotifier. It will act as data repository to be shared thorugh the application.
class TotalCal extends ChangeNotifier{

  //For simplicity, a product is just a String.
  double totalCalories = 0;

  void addCal(double toAdd){
    totalCalories += toAdd;
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  }//addProduct

  void clearTotalCal(){
    totalCalories=0;
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  }//clearCtotalCal
  
}//TotalCal