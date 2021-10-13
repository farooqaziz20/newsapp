import 'package:flutter/material.dart';
import 'package:newsapp/pages/fav.dart';
import 'package:newsapp/pages/login.dart';
import 'package:newsapp/pages/userInfo.dart';

import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/globalValues.dart';

class CustomDrawer extends StatefulWidget {
  // CustomDrawer(this._scaffoldKey);
  // final GlobalKey<ScaffoldState> _scaffoldKey;
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget iconWidget(IconData link, Color icon, Color background,
      {bool flag = false}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: mainColorPrimaryLight.withOpacity(1),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(4),
        child: Icon(
          link,
          color: icon,
          size: 16,
        ),
      ),
    );
  }

  Widget iconheading(String name, IconData icon,
      {Function? onbuttonPress, bool flag = false}) {
    return InkWell(
      onTap: onbuttonPress as void Function()?,
      child: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              iconWidget(icon, mainColorPrimary, mainColorPrimaryLight),
              SizedBox(
                width: 5,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: mainColorPrimary),
              )
            ],
          ),
          Divider(
              height: flag ? 10 : 5,
              color: flag
                  ? mainColorPrimaryLight.withOpacity(0.8)
                  : mainColorSecondry.withOpacity(0.2),
              thickness: flag ? 2 : 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Expanded(
          flex: 9,
          child: Column(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: mainColorPrimary),
                  child: Container(
                      child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.supervised_user_circle,
                                    size: 85,
                                    color: mainColorPrimaryLight,
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 25,
                                        color: mainColorPrimaryLight,
                                      )),
                                ),
                              ],
                            ),
                            ((userId != ""))
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(userName,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        mainColorPrimaryLight)),
                                          ),
                                        ],
                                      ),
                                      Text(userEmail,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: mainColorSecondry)),
                                    ],
                                  )
                                : InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 45, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: mainColorPrimaryLight,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: mainColorSecondry,
                                              fontSize: 18),
                                        )),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ))),
              iconheading("My Favourites", Icons.favorite, onbuttonPress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Fav()));
              }),
              iconheading("My Profile", Icons.person, onbuttonPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfo()));
              }),
              iconheading("Logout", Icons.logout, onbuttonPress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              }),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New App By: ",
                      style: TextStyle(fontSize: 15, color: mainColorPrimary),
                    ),
                    Text(
                      "Farooq Aziz",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: mainColorPrimaryLight),
                    )
                  ],
                )
              ],
            ))
      ],
    ));
  }
}
