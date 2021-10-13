import 'package:mongo_dart/mongo_dart.dart';

import 'newsAppApis/src/newsapi.dart';

var newsApi = NewsApi(
  //  dioOptions: dioOptions,
  //  interceptors: interceptors,
  debugLog: true,
  apiKey: 'ce604ea892834558b0e3c9cde4f8075a',
);
Db? globaldb;

String userId = "";
String userName = "";
String userEmail = "";
String userPhoneNo = "";
