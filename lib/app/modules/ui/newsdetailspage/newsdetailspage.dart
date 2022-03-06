import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_app_demo/app/modules/model/newsdatamodel.dart';
import 'package:new_app_demo/app/res/theme/app_text_theme.dart';

class NewsDetailsPage extends StatelessWidget {
  final Articles articles;
  const NewsDetailsPage({Key? key, required this.articles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: articles.urlToImage.toString(),
            child: articles.urlToImage != null?CachedNetworkImage(
                imageUrl: articles.urlToImage.toString(),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ):Container(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Container
                Text(articles.title.toString(), style: tittleText),
                const SizedBox(
                  height: 64,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(articles.author ?? "", style: authorTextStyle),
                    Text(articles.getDateOnly(articles.publishedAt),
                        style: publishedAtStyle),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(articles.content?? "", style: contentTextStyle),
              ],
            ),
          ),

          InkWell(
            child: Container(
                height: 45,
                width: 45,
                margin: EdgeInsets.only(
                    left: 15.0, top: MediaQuery.of(context).padding.top + 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],

      ),
    );
  }
}
