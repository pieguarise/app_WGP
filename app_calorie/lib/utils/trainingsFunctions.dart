import 'package:app_calorie/database/entities/entities.dart';

bool compareTrainings(List<Trainings> recentTrainings) {
  // confronto gli allenamenti e restituisce se il più
  // recente è il migliore tra gli ultimi cinque
  bool _controllo = true;
  for (var i = 0; i < recentTrainings.length-1; i++) {
    if (recentTrainings.last.calories < recentTrainings[i].calories) {
      _controllo = false;
      break;
    }
  }
  return _controllo;
}

List<Trainings> last5trainings (List<Trainings> allTrainings, int n) {
  List<Trainings> last5 = [allTrainings[n - 5], allTrainings[n - 4], allTrainings[n - 3],
    allTrainings[n - 2], allTrainings[n - 1]];
  return last5;
}
