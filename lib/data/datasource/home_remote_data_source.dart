import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/data/http/client.dart';
import 'package:flutter_clean_architecture/data/model/home_photos_response.dart';

abstract class HomeRemoteDataSourceContract {
  Future<List<HomePhotosResponse>> getResponse();
}

class UserRemoteDataSource implements HomeRemoteDataSourceContract {
  Client client;
  String endpoint = "photos";

  UserRemoteDataSource({@required this.client});

  Future<List<HomePhotosResponse>> getResponse() async {
    try {
      Uri url = Uri.parse(client.baseUrl + endpoint);
      var res = await this.client.get(url);
      List<dynamic> items = res;
      List<HomePhotosResponse> users =
          items.map((r) => HomePhotosResponse.fromMap(r)).toList();
      return users;
    } on HttpException {
      return [];
    } catch (err) {
      return [];
    }
  }
}
