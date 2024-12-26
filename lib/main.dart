import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/app_routes/route_config.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/viewModels/weather_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  serviceLocator();

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
    final appRouter = AppRouter();
    return Sizer(
      builder: (context, _, orientation) {
        return MaterialApp.router(
          routerDelegate: appRouter.router.routerDelegate,
          routeInformationParser: appRouter.router.routeInformationParser,
          routeInformationProvider: appRouter.router.routeInformationProvider,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
