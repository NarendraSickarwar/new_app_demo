import 'dart:async';
import 'dart:io';

import 'package:new_app_demo/app/modules/model/newsdatamodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class SQLiteDbProvider {
  static const _databaseName = "new_article.db";
  static const _databaseVersion = 1;

  static const table = 'news_table';

  static const columnUserId = 'userId';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnName = 'name';
  static const columnDescription = 'description';
  static const columnAuthor = 'author';
  static const columnUrl = 'url';
  static const columnUrlToImage = 'urlToImage';
  static const columnPublishedAt = 'publishedAt';
  static const columnContent = 'content';



  SQLiteDbProvider._();

  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnUserId INTEGER,
            $columnId INTEGER ,
            $columnTitle TEXT NOT NULL UNIQUE ,
            $columnName TEXT NOT NULL ,
            $columnDescription TEXT ,
            $columnAuthor TEXT ,
            $columnUrl TEXT ,
            $columnUrlToImage TEXT ,
            $columnPublishedAt TEXT ,
            $columnContent TEXT 
          )
          ''');
  }



  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Articles>> getAllArticles() async {
    final db = await database;
    var results = await db?.query(table, orderBy: "$columnPublishedAt DESC");
    List<Articles> products = [];
    for (var result in results!) {
      Articles model = Articles.fromJson(result);
      products.add(model);
    }
    return products;
  }





  Future<int?> insert(Articles model) async {
    final db = await database;
    var result = await db?.rawInsert(
        "INSERT Into $table ($columnUserId, $columnId, $columnTitle, $columnName, $columnDescription,$columnAuthor,$columnUrl,$columnUrlToImage,$columnPublishedAt,$columnContent)"
            " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        [
          model.source!.id,
          model.source!.id,
          model.title,
          model.source!.name,
          model.description,
          model.author,
          model.url,
          model.urlToImage,
          model.publishedAt.toString(),
          model.content,
        ]);
    return result;
  }



}
