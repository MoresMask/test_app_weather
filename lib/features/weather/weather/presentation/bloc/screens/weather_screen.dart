import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:test_app_weather/core/constants/api_keys.dart';
import 'package:test_app_weather/core/dependencies/injection_container.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../../_common/data/models/city_model.dart';
import '../get_weather_cubit/get_weather_cubit.dart';
import '../get_weather_cubit/get_weather_state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<String> cities = [];
  final FocusNode focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  @override
  initState(){
    readJson();
    super.initState();
  }


  Future<void> readJson() async {
    final jsonString = await rootBundle.loadString('assets/cities.json');
    final jsonResult = json.decode(jsonString) as Map<String, dynamic>;
    final CityModel model = CityModel.fromJson(jsonResult);
    final List<City> cityList = model.city ?? <City>[];
    for (var i in cityList) {
      cities.add(i.name ?? "");
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetWeatherCubit>()..getWeather("Омск"),
      child: BlocBuilder<GetWeatherCubit, GetWeatherState>(
        builder: (context, state) {
          return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: switch (state) {
                GetWeatherStateSuccess() => SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: MediaQuery.of(context).size.height / 2.2,
                        child: Stack (
                          children: [
                            SizedBox(child: Image.asset("assets/images/background_image.png", fit: BoxFit.cover, width: double.infinity)),

                            Align(alignment: Alignment.bottomRight, child: Image.asset("assets/images/weather.png")),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppConstants.kBoxH32,
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TypeAheadField(
                                        focusNode: focusNode,
                                        controller: searchController,
                                        builder: (context, controller, focusNode){
                                          return TextField(
                                            style: const TextStyle(color: Colors.white),
                                            controller: controller,
                                            focusNode: focusNode,
                                            autofocus: false,
                                            decoration: InputDecoration(
                                                focusColor: Colors.white,
                                                filled: true,
                                                fillColor: Colors.blue.withOpacity(0.3),
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:  Colors.white,
                                                      width: 2.0
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide:  BorderSide(color: Colors.white.withOpacity(0.3)),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.3), width: 2.0),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                hintText: "Поиск по городу",
                                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3))
                                            ),
                                          );
                                        },
                                        itemBuilder: (context, String sugg) {
                                          return ListTile(
                                            title: Text(sugg, style: const TextStyle(color: Colors.white),),
                                            tileColor: const Color(0xFF3C3074),
                                          );
                                        },

                                        onSelected: (value) {
                                          searchController.text = value;
                                          // getIt<GetWeatherCubit>();
                                          context.read<GetWeatherCubit>().getWeather(value);
                                        },
                                        emptyBuilder: (context) => const Text('Не нашёл такого города :C', style: TextStyle(color: Colors.black),),
                                        suggestionsCallback: (search) {
                                          return CitiesService.getSuggestions(search, cities);
                                        }
                                    )
                                ),

                                AppConstants.kBoxH32,
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(state.weather?.location?.name ?? "", style: const TextStyle(color: Colors.white,fontSize: 22)),
                                      Text(state.weather?.location?.country ?? "", style: const TextStyle(color: Colors.white,fontSize: 22)),

                                      AppConstants.kBoxH32,

                                      Text(state.weather?.current?.tempC?.toString() == null ? "" : "${state.weather!.current!.tempC}\u2103" , style: TextStyle(color: Colors.white, fontSize: 32)),
                                      Text(state.weather?.current?.tempF?.toString() == null ? "" : "${state.weather!.current!.tempF}\u2109" , style: TextStyle(color: Colors.white, fontSize: 16)),
                                      Text(state.weather?.current?.condition?.text ?? "", style: const TextStyle(color: Colors.white, fontSize: 20),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: MediaQuery.of(context).size.height / 1.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xFF16161F),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              itemTable("assets/icons/ic_temp.svg", "Температура воздуха", " \u2103", state.weather?.current?.heatindexC.toString() ?? ""),
                              itemTable("assets/icons/ic_wind.svg", "Скорость ветра", " км/ч", state.weather?.current?.windMph.toString() ?? ""),
                              itemTable("assets/icons/ic_air_humidity.svg", "Влажность", "%", state.weather?.current?.humidity.toString() ?? "",),
                              itemTable("assets/icons/ic_uf_index.svg", "Индикация ультрафиолета","", state.weather?.current?.uv.toString() ?? ""),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GetWeatherStateError() => const Center(),
                _ => Container(child: const Center(child: CircularProgressIndicator())),
              },
            ),

        );
        },
      ),
    );
  }
}

itemTable(String assets, String name, String symbol, String value){
  return Column(
    children: [
      Container(
        height: 56,
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(assets, color: Colors.grey),
                AppConstants.kBoxW12,
                Text(name, style: TextStyle(color: Colors.grey.shade200))
              ],
            ),

            Text("$value${symbol}", style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
      Divider(height: 1 ,color: Colors.grey.withOpacity(0.2),)
    ],
  );
}





class CitiesService {
  static List<String> getSuggestions(String query, List<String> cities) {
    List<String> matches = [];
    matches.addAll(cities);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
