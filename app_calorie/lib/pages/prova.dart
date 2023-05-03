void main() {
  List<double> elenco = [1, 2, 3, 4, 5, 6, 4, 8, 1, 2, 3];
  print(_sumLast5trainings(elenco));
}

double _sumLast5trainings(elenco) {
  double somma = 0;
  for (var i = 0; i < 5; i++) {
    somma += elenco[elenco.length - i];
  } //for
  return somma;
}
