import 'package:dio/dio.dart';

const String _apikey = 'f92417adebf74911ae6223847231204';
const String _baseUrl = 'https://api.weatherapi.com/v1/forecast.json?key=';

class ApiHelper {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ));

  Future<dynamic> getData({required String cityName}) async {
    final response = await _dio.get('$_baseUrl$_apikey&q=$cityName&days=7');

    return response;
  }
}
