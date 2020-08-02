import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/model/home_photos_response.dart';
import 'package:flutter_clean_architecture/data/result/data_result.dart';
import 'package:flutter_clean_architecture/domain/home_use_case.dart';
import 'package:flutter_clean_architecture/domain/invoker.dart';
import 'home_photos_bean.dart';

abstract class HomeViewContract {
  onSuccess(List<HomePhotosBean> list);

  onFailure(String message);
}

class HomePresenter {
  HomeViewContract view;
  HomeUseCase fetchUsersUseCase;

  Invoker invoker;

  HomePresenter(
      {@required this.invoker,
      @required this.view,
      @required this.fetchUsersUseCase});

  init() {
    fetchUsers();
  }

  fetchUsers() {
    invoker.execute(fetchUsersUseCase).listen((result) {
      if (result is Success) {
        view.onSuccess(_asUIContent(result as DataResult).data);
      } else {
        view.onFailure(result.status.toString());
      }
    });
  }

  DataResult<List<HomePhotosBean>> _asUIContent(
      DataResult<List<HomePhotosResponse>> list) {
    List<HomePhotosBean> resultList = new List<HomePhotosBean>();
    if (list.getData() != null) {
      list
          .getData()
          .forEach((response) => resultList.add(new HomePhotosBean(response)));
    }
    return new DataResult(list.status, resultList);
  }
}
