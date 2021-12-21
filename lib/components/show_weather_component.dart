import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/models/weather_model.dart';

class ShowWeather extends StatelessWidget {
  final WeatherModel weather;
  final String city;

  const ShowWeather(this.weather, this.city, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 32, left: 32, top: 10),
      child: Column(
        children: <Widget>[
          Text(city, style: const TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          Text(weather.getTemp.round().toString()+"C", style: const TextStyle(color: Colors.white70, fontSize: 50),),
          const Text("Temperature", style: TextStyle(color: Colors.white70, fontSize: 14),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(weather.getMinTemp.round().toString()+"C", style: const TextStyle(color: Colors.white70, fontSize: 30),),
                  const Text("Min Temperature", style: TextStyle(color: Colors.white70, fontSize: 14),),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(weather.getMaxTemp.round().toString()+"C", style: const TextStyle(color: Colors.white70, fontSize: 30),),
                  const Text("Max Temperature", style: TextStyle(color: Colors.white70, fontSize: 14),),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: () {
                BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
              },
              child: const Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),
            )
          )
        ],
      )
    );
  }
}