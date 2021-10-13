import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/globalValues.dart';
import 'package:mongo_dart/mongo_dart.dart' as dbLib;
import 'package:newsapp/utils/newsAppApis/newsapi.dart';
import 'package:newsapp/widgets/newsListTile.dart';

class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  void initState() {
    loadFav();
    super.initState();
  }

  List listarticles = [];
  List<Article> listFavNews = [];
  loadFav() async {
    var data = await globaldb!
        .collection("userfavourite")
        .find(dbLib.where.eq("userId", userId));
    List<Article> articlesTemp = [];
    // print(data);
    // data.map((event) {
    //   articlesTemp.add(Article.fromJson(event["news"]));
    //   print(articlesTemp);
    // });

    listarticles = await data.toList();
    for (var item in listarticles) {
      articlesTemp.add(Article.fromJson(jsonDecode(item["news"])));
    }
    setState(() {
      listFavNews = articlesTemp;
    });
    print(articlesTemp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Favorites",
          style: TextStyle(color: mainColorSecondry),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (listFavNews == null) ? 0 : listFavNews.length,
                itemBuilder: (context, index) {
                  return NewsListTile(
                    article: listFavNews[index],
                  );
                })
          ],
        ),
      ),
    );
  }
}
