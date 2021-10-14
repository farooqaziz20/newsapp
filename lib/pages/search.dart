import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/globalValues.dart';
import 'package:newsapp/utils/newsAppApis/src/model/article.dart';
import 'package:newsapp/widgets/newsListTile.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingControllerSearch = TextEditingController();
  List<Article>? listNews = [];
  bool isLoading = false;
  search() async {
    setState(() {
      isLoading = true;
    });
    print("waiting");

    var everything = await newsApi.everything(
      q: textEditingControllerSearch.text,
      language: 'en',
    );

    setState(() {
      listNews = everything.articles;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: mainColorPrimary,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: mainColorSecondry)),
                  Expanded(
                    child: Container(
                      height: 35,
                      child: TextField(
                        controller: textEditingControllerSearch,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          if (textEditingControllerSearch.text.trim().isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Please enter some keyword to search");
                          } else {
                            search();
                          }
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          hintText: "Search",
                          fillColor: Color(0xfff3f3f4),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (textEditingControllerSearch.text.trim().isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Please enter some keyword to search");
                        } else {
                          search();
                        }
                      },
                      icon: Icon(Icons.search, color: mainColorSecondry)),
                ],
              ),
            ),
            
            Expanded(
              child: (!isLoading)
                  ? ListView.builder(
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: (listNews == null) ? 0 : listNews!.length,
                      itemBuilder: (context, index) {
                        return NewsListTile(
                          article: listNews![index],
                        );
                      })
                  : spinkitglobal,
            )
          ],
        ),
      ),
    );
  }
}
