import 'dart:math';

double sumCalLast5trainings({required List sessions}) {
  double somma = 0;
  for (var i = 0; i <= 4; i++) {
    somma += sessions[i].calories;
  } //for
  return somma;
} //sumCalLast5trainings