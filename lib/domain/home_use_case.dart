import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/data/model/home_photos_response.dart';
import 'package:flutter_clean_architecture/data/repository/home_repository.dart';
import 'base_use_case.dart';

class HomeUseCase extends BaseUseCase<List<HomePhotosResponse>> {
  HomeRepository userRepository;

  HomeUseCase({@required HomeRepository userRepository}) {
    this.userRepository = userRepository;
  }

  @override
  void invoke() {
    addTask(userRepository.getResponse());
  }
}
