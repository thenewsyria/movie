// //In this code, we create a MoviesScreen widget that displays a grid of movie cards using the GridView.
// //builder widget. We also use the Consumer widget from the provider package to listen to changes in the MovieService state.
// // The MovieCard widget is defined in the widgets folder.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/presentation/widgets/movie_list_item.dart';
import 'package:movie_app/data/providers/movie_provider.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).getMovies();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      Provider.of<MovieProvider>(context, listen: false).getMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
      ),
      body: movieProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.movies[index];
                return MovieListItem(movie: movie);
              },
            ),
    );
  }
}
