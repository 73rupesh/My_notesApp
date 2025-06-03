
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rupesh_notes/data/local/dp_helper.dart';
import 'package:rupesh_notes/db_provider.dart';
import 'package:rupesh_notes/home_page.dart';
import 'package:rupesh_notes/theme_provider.dart';


void main() { // sb page m use krna ta esliye yha use kiye h changenotifierprovier
  runApp(MultiProvider(   // dark theme bahut page p use krna h esliye multiprovide use kiye h
    providers: [
      ChangeNotifierProvider<DBProvider>(create: (context) => DBProvider(dbHelper: DBHelper.getinstance),),
      ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider(),
  ),

    ],

  child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: context.watch<ThemeProvider>().getThemeValue()
        ? ThemeMode.dark
        : ThemeMode.light,

        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,

        ),


        home: HomePage()
    );
  }
}



