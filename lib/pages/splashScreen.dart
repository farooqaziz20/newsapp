import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as dbLib;
import 'package:newsapp/pages/dashboard.dart';
import 'package:newsapp/utils/colors.dart';
import 'package:newsapp/utils/globalValues.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    coneectDb();
    super.initState();
  }

  coneectDb() async {
    var db = await dbLib.Db.create(
        "mongodb+srv://farooqaziz20:Aspire20@cluster0.xbz1t.mongodb.net/newsApp?retryWrites=true&w=majority");
    await db.open();
    globaldb = db;
    print(globaldb!.isConnected);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DashBoard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/newsplaceholder.png',
              height: 100,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "News App",
              style: TextStyle(
                  color: mainColorPrimaryLight,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
