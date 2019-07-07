import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/video.dart';

const API_KEY = "AIzaSyDwbRG5Un92uns--RolIrJg_sbaK5RZQ8E";

class Api {

  String _search;
  String _nextToken;

  Future<List<VideoModel>> search(String search) async {

    _search = search;

    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");

    return decode(response);
  }

  Future<List<VideoModel>> nextPage() async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    return decode(response);
  }

  List<VideoModel> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded["nextPageToken"];

      List<VideoModel> videos = decoded["items"]
          .map<VideoModel>((map) => VideoModel.fromJson(map))
          .toList();

      return videos;
    } else {
      throw Exception("Failed to load videos");
    }
  }
}

/*
*/
