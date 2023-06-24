import 'dart:io';
import 'dart:convert';
import 'package:app_calorie/database/entities/entities.dart';
import 'package:app_calorie/pages/splash.dart';
import 'package:app_calorie/repository/databaseRepository.dart';
import 'package:app_calorie/utils/impact.dart';
import 'package:app_calorie/utils/trainingsFunctions.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// Function returning [result, last5trainings]
// result will be 200 if the request is succesfull
// last5training is a list containing last 5 trainings
Future<int?> requestData(context) async {
  //Initialize the result
  int? result;

  //Get the stored access token (Note that this code does not work if the tokens are null)
  final sp = await SharedPreferences.getInstance();
  var access = sp.getString('access');
  var refresh = sp.getString('refresh');

  //If access token is expired, refresh it
  if (JwtDecoder.isExpired(access!)) {
    await refreshTokens(refresh);
    access = sp.getString('access');
  } //if

  //Create the (representative) request
  List<Trainings> lista =
      await Provider.of<DatabaseRepository>(context, listen: false)
          .findAllTrainings();

  DateTime start_date_dateTime = DateTime(2023, 06, 01);
  String start_date_string = '2023-06-01';

  if (lista.isNotEmpty) {
    start_date_dateTime = lista.last.date.add(Duration(days: 1));
    start_date_string = DateFormat('yyyy-MM-dd').format(start_date_dateTime);
    print('Giorno inizio prendere dati (primo NO in DB): $start_date_string');
  }

  DateTime yesterday_dateTime =
      DateTime.now().subtract(const Duration(days: 1));
  String yesterday_string = DateFormat('yyyy-MM-dd').format(yesterday_dateTime);
  print('Giorno finale (ieri): $yesterday_string');

  final int duration =
      yesterday_dateTime.difference(start_date_dateTime).inDays + 1;
  // duration è l'intero che ci dice quanti giorno dobbiamo scaricare
  print('Durata intervallo di richiesta dati: ${duration}');

  // Yesterday already downloaded
  if (duration == 0) {
    result = 200;
  }

  // Download only 1 day
  if (duration == 1) {
    result = await _callingUrlSingle(context, start_date_string, access);
  }

  // scarico i dati se l'intervallo è compreso tra 2 e 7 compresi
  if ((duration) <= 7 && duration >= 2) {
    // se s
    result = await _callingUrlRange(
        context, start_date_string, yesterday_string, access);
  }
  // scarico i dati per intervalli di tempo maggiori di 7:
  else {
    List<int?> results = [];
    // in questo caso divido in blocchi di 7 giorni per eccesso
    // 9/7=1,... --> 2 quindi farò 2 chiamate, una per i primi 7 giorni e una per gli ultimi 2
    int callsNumber = ((duration) / 7).ceil();
    // per le chiamate da 7 giorni
    for (var i = 0; i < callsNumber - 1; i++) {
      print('Giorno iniziale: $start_date_string');
      DateTime end_date_dateTime =
          start_date_dateTime.add(const Duration(days: 6));
      String end_date_string =
          DateFormat('yyyy-MM-dd').format(end_date_dateTime);
      print('Giorno finale: $end_date_string');
      result = await _callingUrlRange(
          context, start_date_string, end_date_string, access);
      results.add(result);
      start_date_dateTime = end_date_dateTime.add(const Duration(days: 1));
      start_date_string = DateFormat('yyyy-MM-dd').format(start_date_dateTime);
    }

    int duration2 =
        yesterday_dateTime.difference(start_date_dateTime).inDays + 1;
    // già presi tutti i giorni (duration era un multiplo di 7)
    if (duration2 == 0) {
      result = 200;
      results.add(result);
    }
    // se avanza solo un giorno --> chiamata singola
    if (duration2 == 1) {
      result = await _callingUrlSingle(context, start_date_string, access);
      results.add(result);
    }
    // avanza più di un giorno
    else {
      result = await _callingUrlRange(
          context, start_date_string, yesterday_string, access);
      results.add(result);
    }

    for (var i = 0; i < results.length; i++) {
      if (results[i] != 200) {
        result = null;
        break;
      }
      result = 200;
    }
  }

  return result;

} //_requestData





Trainings _generateTraining(String day, Map<String, dynamic> json) {
  DateTime date =
      DateFormat('yyyy-MM-dd HH:mm:ss').parse('$day ${json["time"]}');
  int calories = json["calories"];
  String technique = json["activityName"];

  Trainings result = Trainings(null, date, calories, technique);
  return result;
}


Future<Totalcal> _generateTotalcal(Map<String, dynamic> json, context) async {
  
  int calories = json["calories"];
  late int caloriesAmountNow;

  List<Trainings> listaTrainings =
      await Provider.of<DatabaseRepository>(context, listen: false)
          .findAllTrainings();
  int n = listaTrainings.length;
  
  List<Totalcal> listaTotalCal =
    await Provider.of<DatabaseRepository>(context, listen: false)
        .findAllTotalCal();

  if (listaTotalCal.isNotEmpty){      
    caloriesAmountNow = listaTotalCal.last.amount; // Calorie ora      
  } else {
    caloriesAmountNow = 0;
  }
  // RADDOPPIO CALORIE
  if (n>5){
    List<Trainings> lastFive = last5trainings(listaTrainings, n);
    if (compareTrainings(lastFive)){
      calories = calories * 2;
  }}

  Totalcal result = Totalcal(null, caloriesAmountNow + calories);
  return result;
}



// Funzione che scarica dati e riempie man mano il database e ritorna statusCodes
Future<int?> _callingUrlRange(
    context, String start_date, String end_date, String? access) async {
  late int? result;
  final url = Impact.baseUrl +
      Impact.exerciseEndpoint +
      Impact.patientUsername +
      '/daterange/start_date/$start_date/end_date/$end_date/';

  final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

  //Get the response
  //print('Calling: $url per richiesta dati');
  final response = await http.get(Uri.parse(url), headers: headers);
  print('body: ${response.body}');
  print('La risposta è: ${response.statusCode}');

  //if OK parse the response, otherwise return null
  if (response.statusCode == 200) {
    result = response.statusCode;
    final decodedResponse = jsonDecode(response.body);
    print('decoded response: ${decodedResponse}');

    print("data decoded response: ${decodedResponse['data'][0]['date']}");

    for (var j = 0; j < decodedResponse['data'].length; j++) {
      //per ogni giorno

      for (var i = 0; i < decodedResponse['data'][j]['data'].length; i++) {
        //lista giornaliera

        Trainings training = _generateTraining(
            decodedResponse['data'][j]
                ['date'], //data e ora dell i esimo allenamento del j giorno
            decodedResponse['data'][j]['data'][i]);
        print(training.date);
        await Provider.of<DatabaseRepository>(context, listen: false)
            .insertTraining(training);

        Totalcal totalcal = await _generateTotalcal(decodedResponse['data'][j]['data'][i], context);
        await Provider.of<DatabaseRepository>(context, listen: false).insertCal(totalcal);
        
      }
    } //for
    
  } //if
  else {
    result = null;
  } //else

  //Return the result
  return result;
}




Future<int?> _callingUrlSingle(context, String date, String? access) async {
  late int? result;
  final url = Impact.baseUrl +
      Impact.exerciseEndpoint +
      Impact.patientUsername +
      '/day/$date/';

  final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

  //Get the response
  //print('Calling: $url per richiesta dati');
  final response = await http.get(Uri.parse(url), headers: headers);
  print('body: ${response.body}');
  print('La risposta è: ${response.statusCode}');

  //if OK parse the response, otherwise return null
  if (response.statusCode == 200) {
    result = response.statusCode;
    final decodedResponse = jsonDecode(response.body);
    print('decoded response: ${decodedResponse}');

    if (decodedResponse['data'].isNotEmpty){

      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        //lista giornaliera

        Trainings training = _generateTraining(
            decodedResponse['data']
                ['date'], //data e ora dell i esimo allenamento del j giorno
            decodedResponse['data']['data'][i]);
        print(training.date);
        await Provider.of<DatabaseRepository>(context, listen: false)
            .insertTraining(training);

        Totalcal totalcal = await _generateTotalcal(decodedResponse['data']['data'][i], context);
          await Provider.of<DatabaseRepository>(context).insertCal(totalcal);
          
      }
    }
  } //for//if
  else {
    result = null;
  } //else
  //Return the result
  return result;
}
