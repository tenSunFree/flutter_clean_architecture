import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/data/http/base_client.dart';

class Client extends BaseClient {
  String baseUrl;

  Client({@required String baseUrl}) : this.baseUrl = baseUrl;
}
