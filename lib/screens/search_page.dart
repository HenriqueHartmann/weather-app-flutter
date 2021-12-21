import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/components/show_weather_component.dart';

class SearchPage extends StatelessWidget{
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return SingleChildScrollView(
      //padding: EdgeInsets.only(bottom: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        if (!isKeyboard) const Center(
            child: SizedBox(
              child: FlareActor("assets/WorldSpin.flr", fit: BoxFit.contain, animation: "roll",),
              height: 300,
              width: 300,
            )
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
            if (state is WeatherIsNotSearched) {
              return Container(
                padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
                child: Column(
                  children: <Widget>[
                    const Text("Search Weather", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),),
                    const Text("Instanly", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white70),),
                    const SizedBox(height: 24,),
                    TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white70,),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.white70,
                            style: BorderStyle.solid
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            style: BorderStyle.solid
                          )
                        ),
                        hintText: "City Name",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () {
                          weatherBloc.add(FetchWeather(cityController.text));
                        },
                        child: const Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),
                      ),
                    )
                  ],
                ),
              );
            }
            else if (state is WeatherIsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is WeatherIsLoaded) {
              return ShowWeather(state.getWeather, cityController.text);
            }
            else {
              return const Text("Error", style: TextStyle(color: Colors.white));
            }
          })
        ],
      ),
    );
  }
}