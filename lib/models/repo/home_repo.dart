import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/api_helper.dart';

class HomeRepo {
  final ApiHelper _apiHelper;

  HomeRepo(this._apiHelper);
  Future<WeatherModel?> getData({required String cityName}) async {
    try {
      final response = await _apiHelper.getData(cityName: cityName);
      if (response != null) {
        return WeatherModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("------------------ The Error Is: $e");
    }
    return null;
  }
}
