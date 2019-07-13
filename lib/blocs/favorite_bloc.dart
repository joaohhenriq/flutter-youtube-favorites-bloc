import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_bloc/models/video.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc extends BlocBase {

  Map<String, VideoModel> _favorites = {};

  final _favController = StreamController<Map<String, VideoModel>>.broadcast();

  Stream<Map<String, VideoModel>> get outFav => _favController.stream;

  //construtor
  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites =
            json.decode(prefs.getString("favorites")).map((key, value) {
              return MapEntry(key, VideoModel.fromJson(value));
            }).cast<String, VideoModel>();

        _favController.sink.add(_favorites);
      }
    });
  }

  // verifica se o video tá marcado como favorito e marca ou desmarca
  void toggleFavorite(VideoModel video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}
