import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigService {
  final RemoteConfig _remoteConfig = RemoteConfig.instance;

  Future<void> initialize() async {
    await _remoteConfig.setDefaults(<String, dynamic>{
      'movie_pagination_limit': 20,
    });
    await _remoteConfig.fetchAndActivate();
  }

  int get moviePaginationLimit =>
      _remoteConfig.getInt('movie_pagination_limit');
}
