import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_bloc/blocs/videos_bloc.dart';
import 'package:favoritos_youtube_bloc/delegates/data_search.dart';
import 'package:favoritos_youtube_bloc/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final VideosBloc videosBloc = BlocProvider.getBloc<VideosBloc>();

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
            child: Text("0"),
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
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemBuilder: (context, index){
                return VideoTile(snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            );
          } else {
            return Container();
          }
        },
      )
    );
  }
}
