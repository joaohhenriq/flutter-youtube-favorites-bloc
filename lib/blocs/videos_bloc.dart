import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_bloc/models/video.dart';

import '../api.dart';

class VideosBloc extends BlocBase {

  Api api;
  List<VideoModel> videos;

  final _videosController = StreamController<List<VideoModel>>();
  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc(){
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    videos = await api.search(search);

    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
    super.dispose();
  }
}