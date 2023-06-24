import 'package:flutter/material.dart';

//THis class extends ChangeNotifier. It will act as data repository to be shared thorugh the application.
class TotalCal extends ChangeNotifier{

  int totalCalories = 0;

  void addCal(int toAdd){
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