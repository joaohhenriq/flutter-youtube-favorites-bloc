class VideoModel {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  VideoModel({this.id, this.title, this.thumb, this.channel});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    //verifica se as informações vem da api da google ou do padrão que criamos aqui no projeto
    if (json.containsKey("id")) {
      return VideoModel(
          id: json["id"]["videoId"],
          title: json["snippet"]["title"],
          thumb: json["snippet"]["thumbnails"]["high"]["url"],
          channel: json["snippet"]["channelTitle"]);
    } else {
      return VideoModel(
          id: json["id"],
          title: json["title"],
          thumb: json["thumb"],
          channel: json["channel"]);
    }
  }

  Map<String, dynamic> toJson() {
    return {"videoId": id, "title": title, "thumb": thumb, "channel": channel};
  }
}
