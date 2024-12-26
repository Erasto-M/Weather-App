import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/viewModels/weather_view_model.dart';
import 'package:weather_app/views/more_cities_view.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MoreCitiesView())),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: Text(
              "Get More Cities Weather",
              style: GoogleFonts.figtree(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title:  Text(
            'Weather App',
            style: GoogleFonts.figtree(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: viewModel.weather == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Current Weather in ",
                      style: GoogleFonts.figtree(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 3.h,),
                    Text(
                      viewModel.weather?.cityName ?? 'loading ......',
                      style: GoogleFonts.figtree(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Lottie.asset(viewModel.getWeatherImage(
                        mainCondition: viewModel.weather?.mainCondition ?? '')),
                    Text(
                      "Temp:  ${viewModel.weather?.temperature.round().toString() ?? ''}°C ",
                      style: GoogleFonts.figtree(fontSize: 16),
                    ),
                    SizedBox(height: 2.h,),
                    Text(
                      "Humidity:  ${viewModel.weather?.humidity.toString() ?? ''} %",
                      style: GoogleFonts.figtree(fontSize: 16),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
