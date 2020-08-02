import 'package:flutter_clean_architecture/data/result/data_result.dart';
import 'base_use_case.dart';

class Invoker {
  Stream<DataResult> execute(BaseUseCase useCase) async* {
    useCase.invoke();
    for (var task in useCase.callback.getTasks()) {
      var result = await task;
      yield result;
    }
    useCase.callback.clearTasks();
  }
}
