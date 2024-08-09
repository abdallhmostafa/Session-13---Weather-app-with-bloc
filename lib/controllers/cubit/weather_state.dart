part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitialState extends WeatherState {}
final class WeatherNotExpandedContainareState extends WeatherState {}
final class WeatherExpandedContainareState extends WeatherState {}

final class WeatherSuccessState extends WeatherState {
  final WeatherModel weatherModel;
  WeatherSuccessState({required this.weatherModel});
}

final class WeatherLoadingState extends WeatherState {}

final class WeatherErrorState extends WeatherState {
  final String error;
  WeatherErrorState({required this.error});
}
