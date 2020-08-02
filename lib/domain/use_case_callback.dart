import 'package:flutter_clean_architecture/data/result/data_result.dart';

class UseCaseCallback<T> {
  List<Future<DataResult<T>>> tasks = [];

  void addTask(Future<DataResult<T>> task) {
    tasks.add(task);
  }

  List<Future<DataResult<T>>> getTasks() {
    return tasks;
  }

  void clearTasks() {
    tasks.clear();
  }
}
