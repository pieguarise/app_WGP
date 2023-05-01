import 'dart:math';

class Training {
  // Instance variables
  DateTime date;
  String technique;
  int calories;
  // Constructor
  Training({required this.date,required this.technique, required this.calories});
}

// Creo lista di 5 con ultimo come migliore
List<Training> sessions1 = List.generate(
  5, (index) => Training(
    date: DateTime.now().subtract(Duration(days: index)),
    technique: "Run",
    calories: 150-4*index));

// Creo lista di 5 allenamenti casuali
List<Training> sessions2 = List.generate(
  5, (index) => Training(
    date: DateTime.now().subtract(Duration(days: index+10)),
    technique: "Run",
    calories: Random().nextInt(180)));

bool compareTrainings(List<Training> recentTrainings){
  // confronto gli allenamenti e restituisce se il più
  // recente è il migliore tra gli ultimi cinque
  bool _controllo = true;
  for (var i=1; i < recentTrainings.length; i++){
    if (recentTrainings[0].calories<recentTrainings[i].calories){
      _controllo = false;
      break;
    }
  }  
  return _controllo;
}