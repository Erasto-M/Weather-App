import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/viewModels/weather_view_model.dart';
import 'package:weather_app/views/weather_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) {
      WeatherViewModel weatherViewModel = WeatherViewModel();
      weatherViewModel.initView();
      return weatherViewModel;
    },
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, _, orientation) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const WeatherView(),
        );
      },
    );
  }
}
