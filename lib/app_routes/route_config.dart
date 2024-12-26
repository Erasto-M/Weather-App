import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/app_routes/app_route_constants.dart';
import 'package:weather_app/views/error_view.dart';
import 'package:weather_app/views/favorites_view.dart';
import 'package:weather_app/views/more_cities_view.dart';
import 'package:weather_app/views/profile%20_view.dart';
import 'package:weather_app/views/weather_view.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: AppRoutesConstants.weatherView,
    routes: [
      GoRoute(
        path: AppRoutesConstants.weatherView,
        name: AppRoutesConstants.weatherView,
        pageBuilder: (context, state) {
          return const MaterialPage(child: WeatherView());
        },
      ),
      GoRoute(
          path: AppRoutesConstants.moreCitiesView,
          name: AppRoutesConstants.moreCitiesView,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: MoreCitiesView(),
            );
          }),
      GoRoute(
          path: AppRoutesConstants.profileView,
          name: AppRoutesConstants.profileView,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: ProfileView(),
            );
          }),
      GoRoute(
          path: AppRoutesConstants.favoritesView,
          name: AppRoutesConstants.favoritesView,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: FavoritesView(),
            );
          }),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorView());
    },
  );
}
