import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rupesh_notes/theme_provider.dart';

class SettingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Setting'),
     ),
     body: Consumer<ThemeProvider>(
       builder: (_, provider, __){
         return SwitchListTile.adaptive(//adaptive k use means jb android  phone m use krenge to uske jaise work krega and jb iphone m use krenge appp to uske jaise dikhega
           title: Text("Dark Mode"),
           subtitle: Text("Change them mode here"),
           onChanged: (value){   // switch krne p jo value chamge hoga
             provider.updateTheme(value: value);
           },
           value: provider.getThemeValue(),
         );
       },
     )

   );
  }
}