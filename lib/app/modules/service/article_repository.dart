import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_app_demo/app/modules/model/newsdatamodel.dart';
import 'package:new_app_demo/app/modules/service/constant.dart';
import 'package:new_app_demo/app/modules/uitilites/internet_checker.dart';

import 'db/database_helper.dart';

abstract class ArticleRepository {
  Future<List<Articles>?> getArticles();
}
class ArticleRepositoryImplement implements ArticleRepository {
  @override
  Future<List<Articles>?> getArticles() async {
    bool isNetConnected = await isConnected();

    List<Articles>? listOfArticles;
    if (!isNetConnected) {
      listOfArticles= await SQLiteDbProvider.db.getAllArticles();
      return listOfArticles;
    }
    var response = await Dio().get(Constant.apiUrl);
    if (response.statusCode == 200) {
      var data = response.data;


         listOfArticles = NewsDataModel.fromJson(data).articles;
        for (var element in listOfArticles!) {
          SQLiteDbProvider.db.insert(element);
        }
        if (kDebugMode) {
          print("database value "+SQLiteDbProvider.db.getAllArticles().toString());
        }


        return listOfArticles;
      } else {
        throw Exception();

    }
  }
}
