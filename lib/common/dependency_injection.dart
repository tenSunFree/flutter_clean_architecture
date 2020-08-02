import 'package:flutter_clean_architecture/data/datasource/home_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/http/client.dart';
import 'package:flutter_clean_architecture/data/repository/home_repository.dart';
import 'package:flutter_clean_architecture/domain/home_use_case.dart';
import 'package:flutter_clean_architecture/domain/invoker.dart';
import 'package:flutter_clean_architecture/presentation/home_presenter.dart';
import 'package:flutter_clean_architecture/presentation/home_view.dart';
import 'package:injector/injector.dart';

class DependencyInjector {
  get injector {
    return Injector.appInstance;
  }

  loadModules() {
    loadPresentationModules();
    loadDomainModules();
    loadDataModules();
  }

  loadPresentationModules() {
    injector.registerDependency<HomePresenter>((Injector injector) {
      return new HomePresenter(
          invoker: injector.getDependency<Invoker>(),
          view: injector.getDependency<HomeViewContract>(),
          fetchUsersUseCase: injector.getDependency<HomeUseCase>());
    });
  }

  loadDomainModules() {
    injector.registerSingleton<Invoker>((Injector injector) {
      return Invoker();
    });
    injector.registerDependency<HomeUseCase>((Injector injector) {
      var userRepository = injector.getDependency<HomeRepository>();
      return HomeUseCase(userRepository: userRepository);
    });
  }

  loadDataModules() {
    injector.registerDependency<Client>(
        (_) => Client(baseUrl: "https://jsonplaceholder.typicode.com/"),
        override: true);
    injector
        .registerDependency<HomeRemoteDataSourceContract>((Injector injector) {
      var client = injector.getDependency<Client>();
      return new UserRemoteDataSource(client: client);
    });
    injector.registerDependency<HomeRepository>((Injector injector) {
      var remoteDataSource =
          injector.getDependency<HomeRemoteDataSourceContract>();
      return HomeRepositoryImpl(userRemoteDataSource: remoteDataSource);
    });
  }

  injectByView(dynamic view) {
    if (view is HomeScreenState) {
      injector.registerDependency<HomeViewContract>((_) => view);
    }
  }
}
