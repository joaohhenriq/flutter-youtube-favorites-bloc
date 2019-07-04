class VideoModel {

  final String id;
  final String title;
  final String thumb;
  final String channel;

  VideoModel({this.id, this.title, this.thumb, this.channel});

  factory VideoModel.fromJson(Map<String, dynamic> json){
    return VideoModel(
      id: json["id"]["videoId"],
      title: json["snippet"]["title"],
      thumb: json["snippet"]["thumbnails"]["high"]["url"],
      channel: json["snippet"]["channelTitle"]
    );
  }
}