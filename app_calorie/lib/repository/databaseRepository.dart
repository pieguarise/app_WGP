import 'package:app_calorie/database/database.dart';
import 'package:app_calorie/database/entities/entities.dart';
import 'package:flutter/material.dart';

class DatabaseRepository extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllCoupons() method of the DAO
  Future<List<Coupons>> findAllCoupons() async {
    final results = await database.couponsDao.findAllCoupons();
    return results;
  } //findAllCoupons

  //This method wraps the insertCoupons() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertCoupons(Coupons coupon) async {
    await database.couponsDao.insertCoupons(coupon);
    notifyListeners();
  } //insertCoupons

  //This method wraps the deleteCoupon() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteCoupons(Coupons coupon) async {
    await database.couponsDao.deleteCoupons(coupon);
    notifyListeners();
  } //deleteCoupons

  //This method wraps the findAllTrainings() method of the DAO
  Future<List<Trainings>> findAllTrainings() async {
    final results = await database.trainingsDao.findAllTrainings();
    return results;
  } //findAllTrainings

  //This method wraps the insertTrainings() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertTraining(Trainings training) async {
    await database.trainingsDao.insertTrainings(training);
    notifyListeners();
  } //insertTrainings

  //This method wraps the deleteTrainings() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> deleteTraining(Trainings training) async {
    await database.trainingsDao.deleteTrainings(training);
    notifyListeners();
  } //deleteTrainings

  Future<List<Totalcal>> findAllTotalCal() async {
    final results = await database.totalcalDao.findAllTotalCal();
    return results;
  }

  Future<void> insertCal(Totalcal cal) async {
    await database.totalcalDao.insertCal(cal);
    notifyListeners();
  }
} //DatabaseRepository
