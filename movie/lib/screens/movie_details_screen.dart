import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/services/movie_service.dart';
import 'package:movie/widgets/trailer_dialog.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/data/services/movie_service.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;
  final MovieService _movieService = MovieService();

  MovieDetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _movieService.getMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading movie details.'));
          } else {
            final movie = Movie(
              id: snapshot.data['id'],
              title: snapshot.data['title'],
              overview: snapshot.data['overview'],
              posterPath: snapshot.data['poster_path'],
              backdropPath: snapshot.data['backdrop_path'],
              voteAverage: snapshot.data['vote_average'].toDouble(),
              releaseDate: snapshot.data['release_date'],
            );

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      'https://image.tmdb.org/t/p/w780/${movie.backdropPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie
title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          movie.releaseDate,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(width: 4),
                                Text('${movie.voteAverage}'),
                              ],
                            ),
                            TextButton(
                              child: Text('Play Trailer'),
                              onPressed: () {
                                _playTrailer(context, movie);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(movie.overview),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    },
  ),
);
