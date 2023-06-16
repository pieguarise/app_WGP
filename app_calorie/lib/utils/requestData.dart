import 'dart:io';
import 'dart:convert';
import 'package:app_calorie/database/entities/entities.dart';
import 'package:app_calorie/pages/splash.dart';
import 'package:app_calorie/repository/databaseRepository.dart';
import 'package:app_calorie/utils/impact.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
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
    start_date_dateTime = lista.last.date;
    start_date_string =
        DateFormat('yyyy-MM-dd').format(start_date_dateTime);
        print('Giorno iniziale database già popolato: $start_date_string');
  }
  print('Giorno iniziale definitivo: $start_date_string');

  DateTime yesterday_dateTime =
      DateTime.now().subtract(const Duration(days: 1));
  String yesterday_string = DateFormat('yyyy-MM-dd').format(yesterday_dateTime);
  //print('Giorno finale: $yesterday_string');

  final Duration duration = yesterday_dateTime.difference(start_date_dateTime);
  print('Durata intervallo di richiesta dati: ${duration.inDays + 1}');
  
  //..........................................
  // TODO: qui forse va fatta una cosa così, sia qui che poi dopo il for
  //if (duration.inDays==1){
    // chiamata di un singolo giorno
  //}
  //..........................................

  if ((duration.inDays + 1) <= 7 && duration.inDays!=1) {
    // se s
    result =
        await _callingUrl(context, start_date_string, yesterday_string, access);
  } else {
    List<int?> results = [];
    int callsNumber = ((duration.inDays) / 7).ceil();

    for (var i = 0; i <= callsNumber - 1; i++) {
      print('Giorno iniziale: $start_date_string');
      DateTime end_date_dateTime =
          start_date_dateTime.add(const Duration(days: 6));
      String end_date_string =
          DateFormat('yyyy-MM-dd').format(end_date_dateTime);
      print('Giorno finale: $end_date_string');
      result = await _callingUrl(
          context, start_date_string, end_date_string, access);
      results.add(result);
      start_date_dateTime = end_date_dateTime.add(const Duration(days: 1));
      start_date_string = DateFormat('yyyy-MM-dd').format(start_date_dateTime);
    }

    // Ora devo controllare se ci sono giorni fuori dai range fatti nel for
    // in pratica controllo se l'ultimo giorno salvato nel for è successivo o 
    // precedente a ieri e in caso entro nell'if 

    // TODO: qui va aggiunto il controllo se resta fuori un giorno (chiamata singola)
    // o più giorni (e allora resta così)

    if (start_date_dateTime.compareTo(yesterday_dateTime)<0) {
      result = await _callingUrl(
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

// Funzione che scarica dati e riempie man mano il database e ritorna statusCodes
Future<int?> _callingUrl(
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
        print('bauuuu');
      }
    } //for
    print('miao');
  } //if
  else {
    result = null;
  } //else

  //Return the result
  return result;
}
