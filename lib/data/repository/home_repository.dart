import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/data/datasource/home_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/model/home_photos_response.dart';
import 'package:flutter_clean_architecture/data/result/data_result.dart';

abstract class HomeRepository {
  Future<DataResult<List<HomePhotosResponse>>> getResponse();
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRemoteDataSourceContract userRemoteDataSource;

  HomeRepositoryImpl({@required this.userRemoteDataSource});

  Future<DataResult<List<HomePhotosResponse>>> getResponse() async {
    List<HomePhotosResponse> users = await userRemoteDataSource.getResponse();
    if (users.length > 0) {
      return Success(Status.success, users);
    } else {
      return Failure(Status.failure, [], "Error fetching users");
    }
  }
}
