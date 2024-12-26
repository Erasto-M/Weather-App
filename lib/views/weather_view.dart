import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/app_routes/app_route_constants.dart';
import 'package:weather_app/components/enums.dart';
import 'package:weather_app/components/spacing.dart';
import 'package:weather_app/viewModels/weather_view_model.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
          onTap: () {
            GoRouter.of(context).pushNamed(
              AppRoutesConstants.moreCitiesView,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
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
          title: Text(
            'Weather App',
            style: GoogleFonts.figtree(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: viewModel.status == Status.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : viewModel.weather?.cityName.isEmpty
                ? Center(
                    child: Text(
                      "No City Found ",
                      style: GoogleFonts.manrope(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  )
                : Column(
                    children: [
                      verticalSpaceLarge,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                viewModel.routesList[index].routeTitle,
                              );
                            },
                            child: Container(
                              margin: index == 0
                                  ? EdgeInsets.only(left: 3.h)
                                  : index == 4
                                      ? EdgeInsets.all(3.h)
                                      : EdgeInsets.all(1.h),
                              height: 6.h,
                              width: 13.h,
                              decoration: BoxDecoration(
                                color:
                                    index.isEven ? Colors.green : Colors.purple,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                viewModel.routesList[index].tabTitle,
                                style: GoogleFonts.manrope(
                                    fontSize: 14, color: Colors.white),
                              )),
                            ),
                          );
                        })),
                      ),
                      verticalSpaceLarge,
                      Text(
                        "Current Weather in ",
                        style: GoogleFonts.figtree(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        viewModel.weather?.cityName ?? 'loading ......',
                        style: GoogleFonts.figtree(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Lottie.asset(viewModel.getWeatherImage(
                          mainCondition:
                              viewModel.weather?.mainCondition ?? '')),
                      Text(
                        "Temp:  ${viewModel.weather?.temperature.round().toString() ?? ''}°C ",
                        style: GoogleFonts.figtree(fontSize: 16),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Humidity:  ${viewModel.weather?.humidity.toString() ?? ''} %",
                        style: GoogleFonts.figtree(fontSize: 16),
                      ),
                    ],
                  ),
      );
    });
  }
}
