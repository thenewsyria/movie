// //In this code, we create a MoviesScreen widget that displays a grid of movie cards using the GridView.
// //builder widget. We also use the Consumer widget from the provider package to listen to changes in the MovieService state.
// // The MovieCard widget is defined in the widgets folder.

class MovieListScreen extends StatelessWidget {
  final MovieCategory category;

  const MovieListScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Consumer<MovieProvider>(
        builder: (_, movieProvider, __) {
          if (movieProvider.isLoading && movieProvider.currentPage == 1) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: movieProvider.movies.length + 1,
              itemBuilder: (_, index) {
                if (index == movieProvider.movies.length) {
                  if (movieProvider.hasMorePages) {
                    movieProvider.loadMovies();
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox();
                  }
                } else {
                  final movie = movieProvider.movies[index];
                  return ListTile(
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                    ),
                    title: Text(movie.title),
                    subtitle: Text(movie.releaseDate),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailsScreen(movie: movie),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
