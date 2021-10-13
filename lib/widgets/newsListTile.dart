import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'package:newsapp/pages/newDetail.dart';
import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/newsAppApis/src/model/article.dart';

class NewsListTile extends StatefulWidget {
  const NewsListTile({Key? key, this.article}) : super(key: key);
  final Article? article;
  @override
  _NewsListTileState createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile> {
  Article? article;
  @override
  void initState() {
    article = widget.article;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (article != null)
        ? InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsDetails(
                            article: article,
                          )));
            },
            child: Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    if (article!.urlToImage == null)
                      Image.asset(
                        'assets/images/newsplaceholder.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    if (article!.urlToImage != null)
                      FadeInImage(
                        height: 100,
                        width: 100,
                        image: NetworkImage(article!.urlToImage.toString()),
                        placeholder:
                            AssetImage("assets/images/newsplaceholder.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            article!.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: mainColorPrimary),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  (article!.author == null)
                                      ? (article!.source.name == null)
                                          ? ""
                                          : article!.source.name
                                      : article!.author.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: mainColorPrimaryLight),
                                ),
                              ),
                              Text(
                                (article!.publishedAt == null)
                                    ? ""
                                    : Jiffy(article!.publishedAt.toString())
                                        .fromNow(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: mainColorPrimary.withOpacity(0.6)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          )
        : Container();
  }
}
