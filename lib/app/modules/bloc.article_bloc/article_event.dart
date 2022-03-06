import 'package:equatable/equatable.dart';

//abstract class ArticleEvent extends Equatable{

//}
abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}
class FetchArticlesEvent extends ArticleEvent {
  @override
  List<Object> get props => [];

}