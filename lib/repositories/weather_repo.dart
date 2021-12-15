import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:weather_app/models/weather_model.dart';

class WeatherRepo {
  Future<WeatherModel> getWeather(String city) async {
    var endpoint = "api.openweathermap.org";
    var api = "/data/2.5/weather";
    var params = { "q" : city, "APPID" : "24e5518adced091b9c6413f750c7bec7" };
    var uri = Uri.https(endpoint, api, params);
    var response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception();
    } else {
      var jsonResponse = convert.json.decode(response.body) as Map<String, dynamic>;

      return WeatherModel.fromJson(jsonResponse["main"]);
    }
  }
}