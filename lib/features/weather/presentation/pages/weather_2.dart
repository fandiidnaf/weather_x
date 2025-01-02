import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_x/features/search/domain/entities/search_region_code.dart';
import 'package:weather_x/features/search/presentation/bloc/search_bloc.dart';
import 'package:weather_x/features/weather/presentation/bloc/weather_bloc.dart';

class Weather2 extends StatefulWidget {
  const Weather2({super.key});

  @override
  State<Weather2> createState() => _Weather2State();
}

class _Weather2State extends State<Weather2> {
  TextEditingController textInputC = TextEditingController();
  List<SearchRegionCode> searchs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: textInputC,
            onEditingComplete: () {
              context
                  .read<SearchBloc>()
                  .add(GetRegionCodeByNameEvent(regionName: textInputC.text));
            },
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return const CircularProgressIndicator();
              } else if (state is SearchLoaded) {
                final searchs = state.searchRegionCodes;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        context.read<WeatherBloc>().add(
                            GetWeatherEvent(regionCode: searchs[index].code));
                      },
                      title: Text(searchs[index].name),
                      subtitle: Text(searchs[index].code),
                    );
                  },
                );
              }

              return Container();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const CircularProgressIndicator();
              } else if (state is WeatherLoaded) {
                return Text("${state.weather}");
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
