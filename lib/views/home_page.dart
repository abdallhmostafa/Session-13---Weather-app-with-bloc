import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_app/controllers/cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';

class HomePage extends StatelessWidget {
  final WeatherModel weatherModel;

  const HomePage({super.key, required this.weatherModel});

  @override
  build(BuildContext context) {
    var list = weatherModel.forecastDay[0].hour;
    bool isClicked = context.read<WeatherCubit>().isClicked;
    return Scaffold(
      backgroundColor: HexColor('#96b0c1'),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor('#738491')),
                child: const Text(
                  'Today\'s Weather',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              AnimatedContainer(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: isClicked == true ? 500 : 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: HexColor('#56636a'),
                ),
                duration: const Duration(milliseconds: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weatherModel.name,
                      style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${weatherModel.tempC}°C',
                      style: const TextStyle(
                          fontSize: 65,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Image(
                          image: NetworkImage('https:${weatherModel.mainIcon}'),
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          weatherModel.text,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            context.read<WeatherCubit>().changeClicked();
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                'See More',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    isClicked
                        ? BlocBuilder<WeatherCubit, WeatherState>(
                            builder: (context, state) {
                              if (state is WeatherExpandedContainareState) {
                                return Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              index > 11
                                                  ? Text(
                                                      '${list[index].time.split(' ')[1].split(':')[0]} PM',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    )
                                                  : Text(
                                                      '${list[index].time.split(' ')[1].split(':')[0]} AM',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                              Text(
                                                '${list[index].temp}°C',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              Image(
                                                image: NetworkImage(
                                                    'https:${list[index].icon}'),
                                                width: 40,
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                      separatorBuilder: (context, index) =>
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 50,
                                              vertical: 10,
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 1,
                                              color: Colors.grey,
                                            ),
                                          ),
                                      itemCount: list.length),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor('#738491')),
                child: const Text(
                  'Weather This Week',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(8),
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: HexColor('#56636a'),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Thursday',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          weatherModel.forecastDay[index].date,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Image(
                          image: NetworkImage(
                              'https:${weatherModel.forecastDay[index].listIcon}'),
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          '${weatherModel.forecastDay[index].avgT}°C',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                  itemCount: weatherModel.forecastDay.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// "time": "2024-05-07 06:00" [2024-05-07 ,06:00] [06,00] 06