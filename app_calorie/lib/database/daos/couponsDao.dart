import 'package:app_calorie/database/entities/coupons.dart';
import 'package:floor/floor.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class CouponsDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Coupons table
  @Query('SELECT * FROM Coupons')
  Future<List<Coupons>> findAllCoupons();

  //Query #2: INSERT -> this allows to add a Coupons in the table
  @insert
  Future<void> insertCoupons(Coupons coupons);

  //Query #3: DELETE -> this allows to delete a Coupons from the table
  @delete
  Future<void> deleteCoupons(Coupons task);

}//CouponsDao