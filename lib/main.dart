import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controllers/cubit/weather_cubit.dart';
import 'package:weather_app/models/repo/home_repo.dart';
import 'package:weather_app/utils/api_helper.dart';
import 'package:weather_app/views/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(HomeRepo(ApiHelper())),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SearchScreen(),
      ),
    );
  }
}
