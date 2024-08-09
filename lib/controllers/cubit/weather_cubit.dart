import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/repo/home_repo.dart';
import 'package:weather_app/models/weather_model.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._homeRepo) : super(WeatherInitialState());

  final HomeRepo _homeRepo;
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isClicked = false;

  void changeClicked() {
    isClicked = !isClicked;
    if (isClicked) {
      emit(WeatherExpandedContainareState());
    } else {
      emit(WeatherNotExpandedContainareState());
    }
  }

  Future<void> getWeatherData({required String cityName}) async {
    emit(WeatherLoadingState());

    final response = await _homeRepo.getData(cityName: cityName);
    if (response != null) {
      emit(WeatherSuccessState(weatherModel: response));
    } else {
      emit(WeatherErrorState(error: 'Error'));
    }
  }
}
