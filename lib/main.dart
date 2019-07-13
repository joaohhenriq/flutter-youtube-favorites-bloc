import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_bloc/pages/home.dart';
import 'package:flutter/material.dart';

import 'blocs/favorite_bloc.dart';
import 'blocs/videos_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: Home()),
    );
  }
}
