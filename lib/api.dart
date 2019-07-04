import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/video.dart';

const API_KEY = "AIzaSyDwbRG5Un92uns--RolIrJg_sbaK5RZQ8E";


class Api {
  search(String search) async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");

    decode(response);
  }

  List<VideoModel> decode(http.Response response){
    if(response.statusCode == 200){
      var decoded = json.decode(response.body);

      List<VideoModel> videos = decoded["items"].map<VideoModel>(
          (map) => VideoModel.fromJson(map)
      ).toList();

      print(videos);
    } else {
      throw Exception("Failed to load videos");
    }
  }
}


/*"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
*/