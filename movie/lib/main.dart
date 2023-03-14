import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screens/display_page.dart';
import 'package:movie/screens/movie_details_page.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      initialRoute: DisplayPage.routeName,
      routes: {
        DisplayPage.routeName: (context) => MovieScreen(),
        MovieDetailsPage.routeName: (context) => MovieDetailsScreen(
              movie: ModalRoute.of(context)!.settings.arguments as Movie,
            ),
      },
    );
  }
}
