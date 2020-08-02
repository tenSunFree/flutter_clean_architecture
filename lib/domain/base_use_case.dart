import 'package:flutter_clean_architecture/data/result/data_result.dart';
import 'package:flutter_clean_architecture/domain/use_case_callback.dart';

abstract class BaseUseCase<T> {
  UseCaseCallback callback;

  BaseUseCase() {
    callback = UseCaseCallback();
  }

  void invoke();

  void addTask(Future<DataResult<T>> task) {
    callback.addTask(task);
  }
}
