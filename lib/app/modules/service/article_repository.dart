import 'package:dio/dio.dart';
import 'package:new_app_demo/app/modules/model/newsdatamodel.dart';
import 'package:new_app_demo/app/modules/service/constant.dart';

import 'db/database_helper.dart';

abstract class ArticleRepository {
  Future<List<Articles>?> getArticles();
}
class ArticleRepositoryImplement implements ArticleRepository {
  @override
  Future<List<Articles>?> getArticles() async {

    var response = await Dio().get(Constant.apiUrl);
    if (response.statusCode == 200) {
      var data = response.data;
      // store json data into list

        List<Articles>? listOfArticles = NewsDataModel.fromJson(data).articles;
        listOfArticles!.forEach((element) {
          SQLiteDbProvider.db.insert(element);
        });
        print("database value "+SQLiteDbProvider.db.getAllArticles().toString());
        listOfArticles.clear();
        listOfArticles= await SQLiteDbProvider.db.getAllArticles();

        return listOfArticles;
      } else {
        throw Exception();

    }
  }
}
