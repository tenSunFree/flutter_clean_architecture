import 'package:flutter_clean_architecture/data/model/home_photos_response.dart';

class HomePhotosBean {
  String title;
  String url;
  String thumbnailUrl;

  HomePhotosBean(HomePhotosResponse response) {
    title = response.title;
    url = response.url;
    thumbnailUrl = response.thumbnailUrl;
  }
}
