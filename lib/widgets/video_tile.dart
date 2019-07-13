import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube_bloc/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final VideoModel videoModel;

  VideoTile(this.videoModel);

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              videoModel.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        videoModel.title,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Text(
                        videoModel.channel,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, VideoModel>>(
                  stream: favoriteBloc.outFav,
                  initialData: {},
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return IconButton(
                        icon: Icon(
                          snapshot.data.containsKey(videoModel.id)
                              ? Icons.star
                              : Icons.star_border,
                        ),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          favoriteBloc.toggleFavorite(videoModel);
                        },
                      );
                    else
                      return CircularProgressIndicator();
                  })
            ],
          )
        ],
      ),
    );
  }
}
