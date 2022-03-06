import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app_demo/app/modules/bloc.article_bloc/article_event.dart';
import 'package:new_app_demo/app/modules/bloc.article_bloc/article_state.dart';
import 'package:new_app_demo/app/modules/model/newsdatamodel.dart';
import 'package:new_app_demo/app/modules/service/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _repository;


  ArticleBloc({
    required ArticleRepository repository})
      : _repository = repository,
        super(ArticleState()) {
    on<FetchArticlesEvent>(_onEventChanged);
  }



  void _onEventChanged(ArticleEvent event, Emitter<ArticleState> emit) async {
    if (event is FetchArticlesEvent) {
      emit(ArticleLoadingState());
      try {
        List<Articles>? articles = await _repository.getArticles();
        emit(ArticleLoadedState(articles: articles));
      } catch (e) {
        emit(ArticleErrorState(message: e.toString()));
      }
    }
  }
}
