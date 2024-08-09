import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controllers/cubit/weather_cubit.dart';
import 'package:weather_app/views/home_page.dart';

class SearchBlocListner extends StatelessWidget {
  const SearchBlocListner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherCubit, WeatherState>(
      listenWhen: (previous, current) =>
          current is WeatherSuccessState ||
          current is WeatherLoadingState ||
          current is WeatherErrorState,
      child: const SizedBox.shrink(),
      listener: (context, state) {
        if (state is WeatherSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                weatherModel: state.weatherModel,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Success"),
            ),
          );
        } else if (state is WeatherLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.amber,
              content: Text("Loading..."),
            ),
          );
        } else if (state is WeatherErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error'),
            ),
          );
        }
      },
    );
  }
}
