import 'package:favoritos_youtube_bloc/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {

  final VideoModel videoModel;

  VideoTile(this.videoModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0/9.0,
            child: Image.network(videoModel.thumb, fit: BoxFit.cover,),
          )
        ],
      ),
    );
  }
}
