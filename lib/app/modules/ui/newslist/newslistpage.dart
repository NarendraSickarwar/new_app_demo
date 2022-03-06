import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app_demo/app/modules/bloc.article_bloc/article_bloc.dart';
import 'package:new_app_demo/app/modules/bloc.article_bloc/article_event.dart';
import 'package:new_app_demo/app/modules/bloc.article_bloc/article_state.dart';
import 'package:new_app_demo/app/modules/model/newsdatamodel.dart';
import 'package:new_app_demo/app/modules/ui/newsdetailspage/newsdetailspage.dart';
import 'package:new_app_demo/app/modules/uitilites/utils.dart';
import 'package:new_app_demo/app/res/theme/app_text_theme.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);

    articleBloc.add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.appBarColor,
          title: Text(Strings.appBarHeaderText),
          centerTitle: true,
          titleTextStyle: headerText),
      body: Container(
        color: AppColor.backGroundColor,
        child: BlocListener<ArticleBloc, ArticleState>(
          listener: (context, state) {
            if (state is ArticleErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ArticleBloc, ArticleState>(
            builder: (context, state) {
              if (state is ArticleInitialState) {
                return buildLoading();
              } else if (state is ArticleLoadingState) {
                return buildLoading();
              } else if (state is ArticleLoadedState) {
                return buildArticleList(state.articles);
              } else if (state is ArticleErrorState) {
                return buildErrorUi(state.message);
              } else {
                return buildLoading();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget buildArticleList(List<Articles>? articles) {
    return ListView.builder(
      itemCount: articles?.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 12),
          child: InkWell(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Hero(
                  tag: articles![index].urlToImage.toString(),
                  child: articles[index].urlToImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                              imageUrl: articles[index].urlToImage.toString(),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3.5,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black, Colors.white],
                              // stops: [.1, .9],
                            ),
                          ),
                        ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent],
                      // stops: [.1, .9],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(articles[index].title.toString(), style: tittleText),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(articles[index].author ?? "",
                                style: authorTextStyle),
                          ),
                          Text(
                              articles[index]
                                  .getDateOnly(articles[index].publishedAt),
                              style: publishedAtStyle),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            onTap: () {
              navigateToArticleDetailScreen(context, articles[index]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailScreen(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewsDetailsPage(
        articles: article,
      );
    }));
  }
}
