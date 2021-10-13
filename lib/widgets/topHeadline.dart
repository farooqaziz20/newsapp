import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'package:newsapp/pages/newDetail.dart';
import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/newsAppApis/src/model/article.dart';

class TopHeadline extends StatefulWidget {
  const TopHeadline({Key? key, this.article}) : super(key: key);
  final Article? article;
  @override
  _TopHeadlineState createState() => _TopHeadlineState();
}

class _TopHeadlineState extends State<TopHeadline> {
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
                child: Column(
                  children: [
                    if (article!.urlToImage == null)
                      Image.asset(
                        'assets/images/newsplaceholder.png',
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                    if (article!.urlToImage != null)
                      FadeInImage(
                        height: 200,
                        image: NetworkImage(article!.urlToImage.toString()),
                        placeholder:
                            AssetImage("assets/images/newsplaceholder.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      article!.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
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
                                fontSize: 14,
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
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: mainColorPrimary.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ],
                )),
          )
        : Container();
  }
}
