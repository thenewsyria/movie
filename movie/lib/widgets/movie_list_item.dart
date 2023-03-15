class MovieListItem extends StatelessWidget {
  final Movie movie;

  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        'https://image.tmdb.org/t/p/w92/${movie.posterPath}',
      ),
      title: Text(movie.title),
      subtitle: Text(movie.releaseDate),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/movie-details',
          arguments: movie.id,
        );
      },
    );
  }
}
