import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/repositories/weather_repo.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  FetchWeather(this._city);

  final String _city;

  @override
  // TODO: implement props
  List<Object> get props => [_city];
}

class ResetWeather extends WeatherEvent {

}

class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState {

}

class WeatherIsLoading extends WeatherState {

}

class WeatherIsLoaded extends WeatherState {

  WeatherIsLoaded(this._weather);

  final _weather;

  WeatherModel get getWeather => _weather;

  @override
  // TODO: implement props
  List<Object> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState {

}
/*
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherIsNotSearched());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    // TODO: implement mapEventToState
    if (event is FetchWeather) {
      yield WeatherIsLoading();

      try {
        WeatherModel weather = await weatherRepo.getWeather(event._city);
        yield WeatherIsLoaded(weather);
      } catch(_) {
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
*/

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepo weatherRepo;

  WeatherBloc(this.weatherRepo) : super(WeatherIsNotSearched()) {
    on<FetchWeather>(
        (event, emit) async {
          emit(WeatherIsLoading());

          try {
            WeatherModel weather = await weatherRepo.getWeather(event._city);
            emit(WeatherIsLoaded(weather));
          } catch(_) {
            emit(WeatherIsNotLoaded());
          }
        }
    );
    on<ResetWeather>(
        (event, emit) async {
          emit(WeatherIsNotSearched());
        }
    );
  }
}