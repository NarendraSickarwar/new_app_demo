import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_app_demo/app/modules/bloc.article_bloc/article_bloc.dart';
import 'package:new_app_demo/app/modules/service/article_repository.dart';
import 'package:new_app_demo/app/modules/ui/newslist/newslistpage.dart';
import 'package:new_app_demo/app/res/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'NewsBlocApp',
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColor.colorPrimary,
          
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (BuildContext context) =>
              ArticleBloc(repository: ArticleRepositoryImplement()),
          child: const NewsListPage(),
        ),

        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },

    );

  }
}
