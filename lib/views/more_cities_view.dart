import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/components/spacing.dart';
import 'package:weather_app/viewModels/weather_view_model.dart';

class MoreCitiesView extends StatelessWidget {
  const MoreCitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.grey,
                ),
              )),
        ),
        body: Consumer<WeatherViewModel>(builder: (context, viewModel, child) {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get weather of your favorite city",
                  style: GoogleFonts.manrope(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                verticalSpaceMaxLarge,
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: viewModel.searchCityController,
                  onChanged: (value) async {
                    Future.delayed(const Duration(milliseconds: 500))
                        .then((_) async {
                      await viewModel.fetchSpecificCityWeather();
                    });
                  },
                  cursorColor: Colors.grey,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        borderSide: BorderSide(width: 0.5, color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        borderSide: BorderSide(width: 0.5, color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        borderSide: BorderSide(width: 0.5, color: Colors.grey)),
                  ),
                ),
                verticalSpaceLarge,
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Current Weather in ",
                        style: GoogleFonts.manrope(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        viewModel.specificCityWeather?.cityName ??
                            'loading ......',
                        style: GoogleFonts.manrope(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Lottie.asset(viewModel.getWeatherImage(
                          mainCondition:
                              viewModel.specificCityWeather?.mainCondition ??
                                  '')),
                      Text(
                        "Temp:  ${viewModel.specificCityWeather?.temperature.round().toString() ?? ''}°C ",
                        style: GoogleFonts.figtree(fontSize: 16),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Humidity:  ${viewModel.specificCityWeather?.humidity.toString() ?? ''} %",
                        style: GoogleFonts.figtree(fontSize: 16),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        viewModel.specificCityWeather?.description.toString() ??
                            '',
                        style: GoogleFonts.figtree(fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
        }));
  }
}
