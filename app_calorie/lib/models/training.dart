import 'dart:math';
import 'package:intl/intl.dart';

class Training {
  final DateTime date;
  final int calories;
  final String technique;

  Training(
      {required this.date, required this.calories, required this.technique});

  Training.fromJson(String day, Map<String, dynamic> json)
      : date = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$day ${json["time"]}'),
        calories = json["calories"],
        technique = json["activityName"];

  @override
  String toString() {
    return 'Training(time: $date, calories: $calories, activity: $technique)';
  } //toString
} //Training

// Creo lista di 5 con ultimo come migliore
List<Training> sessions1 = List.generate(
    5,
    (index) => Training(
        date: DateTime.now().subtract(Duration(days: index)),
        technique: "Run",
        calories: 150 - 4 * index));

// Creo lista di 5 allenamenti casuali
List<Training> sessions2 = List.generate(
    5,
    (index) => Training(
        date: DateTime.now().subtract(Duration(days: index + 10)),
        technique: "Run",
        calories: Random().nextInt(180)));

bool compareTrainings(List<Training> recentTrainings) {
  // confronto gli allenamenti e restituisce se il più
  // recente è il migliore tra gli ultimi cinque
  bool _controllo = true;
  for (var i = 1; i < recentTrainings.length; i++) {
    if (recentTrainings[0].calories < recentTrainings[i].calories) {
      _controllo = false;
      break;
    }
  }
  return _controllo;
}

double sumCalLast5trainings({required List sessions}) {
  double somma = 0;
  for (var i = 0; i <= 4; i++) {
    somma += sessions[i].calories;
  } //for
  return somma;
} //sumCalLast5trainings*/