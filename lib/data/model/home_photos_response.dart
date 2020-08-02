class HomePhotosResponse {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  static HomePhotosResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    HomePhotosResponse user4Bean = HomePhotosResponse();
    user4Bean.albumId = map['albumId'];
    user4Bean.id = map['id'];
    user4Bean.title = map['title'];
    user4Bean.url = map['url'];
    user4Bean.thumbnailUrl = map['thumbnailUrl'];
    return user4Bean;
  }

  Map toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}