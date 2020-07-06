import 'package:cubit/cubit.dart';
import 'package:flutter_weather/service/service.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherService) : super(WeatherInitial());

  final WeatherService _weatherService;

  Future<void> getWeather({@required String city}) async {
    if (city == null || city.isEmpty) return;
    emit(WeatherLoadInProgress());
    try {
      final weather = await _weatherService.getWeather(city);
      emit(WeatherLoadSuccess(weather));
    } catch (_) {
      emit(WeatherLoadFailure());
    }
  }
}
