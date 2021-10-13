import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';

import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/globalValues.dart';
import 'package:newsapp/utils/newsAppApis/src/model/article.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({Key? key, this.article}) : super(key: key);
  final Article? article;
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  Article? article;
  @override
  void initState() {
    article = widget.article;
    super.initState();
  }

  bool flag = false;

  addtofav() async {
    await globaldb!.collection("userfavourite").insert({
      "userId": userId,
      "news": jsonEncode(article!.toJson()),
    });
    Fluttertoast.showToast(msg: "News added to favourites");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back, color: mainColorSecondry)),
        backgroundColor: mainColorPrimary,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
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
                  height: 200,
                  image: NetworkImage(article!.urlToImage.toString()),
                  placeholder: AssetImage("assets/images/newsplaceholder.png"),
                  fit: BoxFit.fitHeight,
                ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      article!.title,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: mainColorPrimary),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
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
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (!flag) {
                                setState(() {
                                  flag = true;
                                });
                                addtofav();
                              }
                            },
                            icon: Icon(
                              (flag) ? Icons.favorite : Icons.favorite_border,
                              color: mainColorPrimaryLight,
                              size: 40,
                            )),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      article!.description,
                      style: TextStyle(fontSize: 18, color: mainColorPrimary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
