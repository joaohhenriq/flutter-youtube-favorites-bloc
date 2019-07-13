import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube_bloc/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../api.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favotiteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, VideoModel>>(
        stream: favotiteBloc.outFav,
        initialData: {},
        builder: (context, snapshot){
          return ListView(
            children: snapshot.data.values.map((video){
              return InkWell(
                onTap: (){
                  FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY,
                      videoId: video.id
                  );
                },
                onLongPress: (){
                  favotiteBloc.toggleFavorite(video);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(video.thumb),
                    ),
                    Expanded(
                      child: Text(
                        video.title,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ) ;
            }).toList(),
          );
        },
      ),
    );
  }
}
