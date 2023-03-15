class MovieProvider with ChangeNotifier {
  final MovieService _movieService = MovieService();
  final ConfigService _configService = ConfigService();
  int _currentPage = 1;
  bool _isLoading = false;
  List<Movie> _movies = [];

  bool get isLoading => _
Future<void> loadMovies() async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;

    final limit = _configService.moviePaginationLimit;

    final movies = await _movieService.getPopularMovies(
      page: _currentPage,
      limit: limit,
    );

    _movies.addAll(movies);
    _currentPage++;
    _isLoading = false;
    notifyListeners();
  }
