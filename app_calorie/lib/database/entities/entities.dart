import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

//Here, we are saying to floor that this is a class that defines an entity
@entity
class Coupons {
  //id will be the primary key of the table. Moreover, it will be autogenerated.
  //id is nullable since it is autogenerated.
  @PrimaryKey(autoGenerate: true)
  final int? id;

  //For the sake of simplicity, a Todo has only a name.
  String title;
  String description;

  //Default constructor
  Coupons(this.id, this.title, this.description);
} //Todo

//Here, we are saying to floor that this is a class that defines an entity
@entity
class Trainings {
  //id will be the primary key of the table. Moreover, it will be autogenerated.
  //id is nullable since it is autogenerated.
  @PrimaryKey(autoGenerate: true)
  final int? id;

  //For the sake of simplicity, a Todo has only a name.
  final DateTime date;
  final int calories;
  final String technique;

  //Default constructor
  Trainings(this.id, this.date, this.calories, this.technique);
}//Trainings 

      