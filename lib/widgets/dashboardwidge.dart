import 'package:flutter/material.dart';
import 'package:newsapp/utils/globalValues.dart';
import 'package:newsapp/utils/newsAppApis/src/model/article.dart';
import 'package:newsapp/widgets/topHeadline.dart';

import 'newsListTile.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({Key? key, this.catagory}) : super(key: key);
  final String? catagory;
  @override
  _DashBoardWidgetState createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  @override
  void initState() {
    loadHeadLines();
    super.initState();
  }

  // List<String> listCatagoris = ["","","","","","","TASTE","WORLD NEWS","SCIENCE","STYLE","RELIGION","CRIME","MEDIA","POLITICS","WELLNESS","ENTERTAINMENT","TRAVEL","STYLE & BEAUTY","PARENTING","HEALTHY LIVING","QUEER VOICES","FOOD & DRINK","BUSINESS","COMEDY",];

  Article? topHeadline;
  List<Article>? listNews = [];
  bool isLoading = false;
  loadHeadLines() async {
    setState(() {
      isLoading = true;
    });
    print("waiting");
    if (widget.catagory == "All") {}
    var everything = await (widget.catagory == "All"
        ? newsApi.topHeadlines(
            language: 'en',
          )
        : newsApi.topHeadlines(language: 'en', category: widget.catagory));

    var sources = await newsApi.sources(
      language: 'en',
    );

    print(sources);
//     var everything = await newsApi.everything(
//       q: 'flutter',
// //    qInTitle: qInTitle,
// //    sources: sources,
// //    domains: domains,
// //    excludeDomains: excludeDomains,
// //    from: from, // support DateTime or String
// //    to: to, // support DateTime or String
// //    language: language,
// //    sortBy: sortBy,
// //    pageSize: pageSize,
// //    page: page,
//     );
    setState(() {
      listNews = everything.articles;
      isLoading = false;
      topHeadline = listNews!.removeAt(0);
    });
    print(topHeadline);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        if (!isLoading)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopHeadline(
                    article: topHeadline,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (listNews == null) ? 0 : listNews!.length,
                      itemBuilder: (context, index) {
                        return NewsListTile(
                          article: listNews![index],
                        );
                      })
                ],
              ),
            ),
          ),
      ],
    ));
  }
}
