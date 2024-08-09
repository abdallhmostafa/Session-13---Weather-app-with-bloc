import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/controllers/cubit/weather_cubit.dart';
import 'package:weather_app/views/search_bloc_listner.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.read<WeatherCubit>();
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text(
            'ENTER CITY',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Form(
                  key: weatherCubit.formKey,
                  child: TextFormField(
                    controller: weatherCubit.searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                      hintText: 'Enter city name',
                      labelText: 'Search',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' Search must not be empty ';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  child: MaterialButton(
                    onPressed: () {
                      if (weatherCubit.formKey.currentState!.validate()) {
                        context.read<WeatherCubit>().getWeatherData(
                            cityName: weatherCubit.searchController.text);
                      }
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SearchBlocListner(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





//      base url=http://api.weatherapi.com/
//      v1/forecast.json?key=f92417adebf74911ae6223847231204&q=cairo