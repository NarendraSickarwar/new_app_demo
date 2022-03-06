import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_app_demo/app/modules/model/newsdatamodel.dart';


class ArticleState extends Equatable {
  @override
  
  List<Object?> get props =>  [];
}

class ArticleInitialState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadedState extends ArticleState {
  final List<Articles>? articles;

  ArticleLoadedState({required this.articles});

  @override
  List<Object> get props => throw UnimplementedError();
}

class ArticleErrorState extends ArticleState {
  final String message;
  ArticleErrorState({required this.message});
  @override
  List<Object> get props => throw UnimplementedError();
}
