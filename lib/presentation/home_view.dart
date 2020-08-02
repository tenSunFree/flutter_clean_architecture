import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'file:///C:/FlutterCleanArchitectureDemo/flutter_clean_architecture/lib/common/dependency_injection.dart';
import 'package:injector/injector.dart';
import 'home_photos_bean.dart';
import 'home_presenter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin
    implements HomeViewContract {
  HomePresenter _presenter;
  bool _loading = true;
  List<HomePhotosBean> list = List<HomePhotosBean>();

  HomeScreenState() {
    DependencyInjector().injectByView(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter = Injector.appInstance.getDependency<HomePresenter>();
    _presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF192E5B),
        title: Text("Flutter Clean Architecture Demo"),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (_loading) {
      return buildLoadingContainer();
    } else {
      return Container(
          color: Color(0xFF1D65A6),
          child: ListView.builder(
              itemCount: list.length,
              reverse: false,
              itemBuilder: (_, int index) {
                var bean = list[index];
                return buildListItemContainer(bean);
              }));
    }
  }

  Container buildLoadingContainer() {
    return Container(
        color: Color(0xFF1D65A6),
        child: Center(
            child: new Text("Loading…",
                style: TextStyle(color: Color(0xFFF2A104), fontSize: 32))));
  }

  Container buildListItemContainer(HomePhotosBean bean) {
    return Container(
      margin: const EdgeInsets.only(top: 32, left: 32),
      child: Row(children: <Widget>[
        ClayContainer(
            emboss: true,
            depth: 40,
            curveType: CurveType.convex,
            borderRadius: 50,
            surfaceColor: Color(0xFF72A2C0),
            child: new Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
                decoration: new BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    image: new DecorationImage(
                        image: new NetworkImage(bean.thumbnailUrl),
                        fit: BoxFit.cover),
                    color: Color(0xFF72A2C0)))),
        Expanded(
            child: Container(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Text(bean.title,
                    style: TextStyle(color: Color(0xFFF2A104)))))
      ]),
    );
  }

  @override
  void dispose() {
    Injector.appInstance.removeByKey<HomeViewContract>();
    super.dispose();
  }

  @override
  onSuccess(List<HomePhotosBean> list) {
    this.list = list;
    setState(() => _loading = false);
  }

  @override
  onFailure(String msg) {
    setState(() => _loading = false);
  }
}
