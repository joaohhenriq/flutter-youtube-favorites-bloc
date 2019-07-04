import 'package:favoritos_youtube_bloc/pages/home.dart';
import 'package:flutter/material.dart';

import 'api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Api api = Api();
    api.search("flutter");

    return MaterialApp(
      title: 'Flutter Demo',
      home: Home()
    );
  }
}
