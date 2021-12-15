import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:weather_app/models/weather_model.dart';

class WeatherRepo {
  Future<WeatherModel> getWeather(String city) async {
    var url = Uri.https('https://api.openweathermap.org/',
                        'data/2.5/weather',
                        {
                          'q': city,
                          'APPID': '24e5518adced091b9c6413f750c7bec7'
                        });
    var response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception();
    }

    return parsedJson(response.body);
  }

  WeatherModel parsedJson(final response) {
    final jsonResponse = convert.json.decode(response);

    return WeatherModel.fromJson(jsonResponse["main"]);
  }
}