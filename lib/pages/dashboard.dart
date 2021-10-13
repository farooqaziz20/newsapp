import 'package:flutter/material.dart';

import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/globalValues.dart';
import 'package:newsapp/utils/newsAppApis/src/model/article.dart';
import 'package:newsapp/widgets/dashboardwidge.dart';
import 'package:newsapp/widgets/drawer.dart';
import 'package:newsapp/widgets/newsListTile.dart';
import 'package:newsapp/widgets/topHeadline.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    loadHeadLines();
    super.initState();
  }

  // List<String> listCatagoris = ["","","","","","","TASTE","WORLD NEWS","SCIENCE","STYLE","RELIGION","CRIME","MEDIA","POLITICS","WELLNESS","ENTERTAINMENT","TRAVEL","STYLE & BEAUTY","PARENTING","HEALTHY LIVING","QUEER VOICES","FOOD & DRINK","BUSINESS","COMEDY",];
  List<String> listCatagoris = [
    "All",
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];
  Article? topHeadline;
  List<Article>? listNews = [];
  bool isLoading = false;
  loadHeadLines() async {
    setState(() {
      isLoading = true;
    });
    print("waiting");
    var everything = await newsApi.topHeadlines(
      language: 'en',
    );

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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: listCatagoris.length,
        child: Scaffold(
            key: _scaffoldKey,
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('NEWS APP'),
              centerTitle: true,
              bottom: TabBar(
                  isScrollable: true,
                  tabs: listCatagoris
                      .map((e) => Tab(
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: mainColorPrimaryLight,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ))
                      .toList()),
              leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu_sharp, color: mainColorSecondry)),
              backgroundColor: mainColorPrimary,
            ),
            body: TabBarView(
                children: listCatagoris
                    .map((e) => DashBoardWidget(catagory: e))
                    .toList())),
      ),
    );
  }
}
