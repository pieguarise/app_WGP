import 'package:app_calorie/database/entities/entities.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class CouponsDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Coupons table
  @Query('SELECT * FROM Coupons')
  Future<List<Coupons>> findAllCoupons();

  //Query #2: INSERT -> this allows to add a Coupons in the table
  @insert
  Future<void> insertCoupons(Coupons coupon);

  //Query #3: DELETE -> this allows to delete a Coupons from the table
  @delete
  Future<void> deleteCoupons(Coupons coupon);
} //CouponsDao

@dao
abstract class TrainingsDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the Trainings table
  @Query('SELECT * FROM Trainings')
  Future<List<Trainings>> findAllTrainings();

  //Query #2: INSERT -> this allows to add a Training in the table
  @insert
  Future<void> insertTrainings(Trainings training);

  //Query #3: DELETE -> this allows to delete a Training from the table
  @delete
  Future<void> deleteTrainings(Trainings training);
}

@dao
abstract class TotalcalDao {
  //Query #1: SELECT -> this allows to obtain all the entries of the TotalCal table
  @Query('SELECT * FROM TotalCal')
  Future<List<Totalcal>> findAllTotalCal();

  //Query #2: INSERT -> this allows to update the value of totalCal
  @insert
  Future<void> insertCal(Totalcal totalcal);
}
