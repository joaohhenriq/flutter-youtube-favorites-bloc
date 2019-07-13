import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube_bloc/blocs/videos_bloc.dart';
import 'package:favoritos_youtube_bloc/delegates/data_search.dart';
import 'package:favoritos_youtube_bloc/models/video.dart';
import 'package:favoritos_youtube_bloc/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final VideosBloc videosBloc = BlocProvider.getBloc<VideosBloc>();
    final FavoriteBloc favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 0.0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, VideoModel>>(
              stream: favoriteBloc.outFav,
              initialData: {},
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Text("${snapshot.data.length}");
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){

            },
          ),
          Consumer<VideosBloc>(
            builder: (context, videosBloc){
              return IconButton(
                icon: Icon(Icons.search),
                onPressed: () async{
                  String result = await showSearch(context: context, delegate: DataSearch());
                  if(result != null){
                    videosBloc.inSearch.add(result);
                  }
                },
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: videosBloc.outVideos,
        initialData: [],
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                } else if(index > 1) {
                  videosBloc.inSearch.add(null);
                  return Container(
                    height: 60,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
                  );
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      )
    );
  }
}
