import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/blocs/movie_details_bloc.dart';
import 'package:the_movie_db/blocs/movie_list_bloc.dart';
import 'package:the_movie_db/models/movie.dart';
import 'package:the_movie_db/pages/home_page.dart';
import 'package:the_movie_db/pages/movie_details_page.dart';
import 'package:the_movie_db/providers/movie_provider.dart';
import 'package:the_movie_db/providers/push_notification_provider.dart';
import 'package:the_movie_db/providers/remote_config_provider.dart';

void main() async {
  // Ensure that the app is always in portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize the app and providers
  runApp(MyApp());
  await PushNotificationProvider.initialize();
  await RemoteConfigProvider.initialize();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieProvider>(
          create: (_) => MovieProvider(),
        ),
        ChangeNotifierProvider<MovieListBloc>(
          create: (_) => MovieListBloc(),
        ),
        ChangeNotifierProvider<MovieDetailsBloc>(
          create: (_) => MovieDetailsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'The Movie DB',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => HomePage(),
          '/details': (_) => MovieDetailsPage(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieBloc = Provider.of<MovieListBloc>(context, listen: false);
    final remoteConfig = Provider.of<RemoteConfigProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('The Movie DB'),
        actions: [
          PopupMenuButton(
            onSelected: (String value) {
              movieBloc.setCategory(value);
            },
            itemBuilder: (BuildContext context) {
              return remoteConfig.categories.map((String category) {
                return PopupMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<MovieProvider>(
              builder: (_, provider, __) {
                if (provider.movies == null) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: provider.movies.length,
                    itemBuilder: (_, int index) {
                      final Movie movie = provider.movies[index];

                      return ListTile(
                        title: Text(movie.title),
                        subtitle: Text(movie.overview),
                        leading: Image.network(movie.posterUrl),
                        onTap: () {
                          Provider.of<MovieDetailsBloc>(context, listen: false).fetchMovieDetails(movie.id);
                          Navigator.pushNamed(context, '/details');
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            child: Text('Load More'),
            onPressed: () {
              movieBloc.loadMoreMovies();
            },
          ),
        ],
      ),
    );
  }
}

class MovieDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MovieDetailsBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
children: [
              StreamBuilder<Movie>(
                stream: bloc.movie,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final Movie movie = snapshot.data!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(movie.backdropUrl),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                movie.releaseDate,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                movie.overview,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                child: Text('Play Trailer'),
                                onPressed: () {
                                  // Open the movie trailer using the Dio package
                                  // Code for this is not included as it is beyond the scope of the task
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
        ),
      ),
    );
  }
}
