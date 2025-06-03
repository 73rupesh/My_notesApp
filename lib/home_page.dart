import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rupesh_notes/add_note_page.dart';
import 'package:rupesh_notes/data/local/dp_helper.dart';
import 'package:rupesh_notes/db_provider.dart';
import 'package:rupesh_notes/setting_page.dart';



class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {


  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();


 /* List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbRef; */


  @override
  void initState() {
    super.initState();

    context.read<DBProvider>().getInitialNotes();
   /* dbRef = DBHelper.getinstance;
    getNotes();  */

  }

  /* void getNotes() async{
    allNotes = await dbRef!.getAllNotes();
    setState(() {

    });
  } */

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // all notes visible here
        title: Text('Notes'),
       actions: [
         PopupMenuButton(itemBuilder: (_){
           return[
             PopupMenuItem(child: Row(
               children: [
                 Icon(Icons.settings),
                 Text("Settings")
               ],
             ), onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage(),));   // setting page p jane k liye
             },)
           ];
         }

         )
       ],
      ),

      body: Consumer<DBProvider>(
        builder: (ctx, provider, __){
          List<Map<String,dynamic>> allNotes = provider.getNotes();

          return allNotes.isNotEmpty ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (_, index){
                return ListTile(

                  leading: Text('${index+1}'),
                  title: Text("${allNotes[index][DBHelper.COLUMN_NOTE_TITLE]}"),
                  subtitle: Text("${allNotes[index][DBHelper.COLUMN_NOTE_DESC]}"),
                  trailing: SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(
                                  isUpdate: true, title: allNotes[index][DBHelper.COLUMN_NOTE_TITLE],
                                  desc:  allNotes[index][DBHelper.COLUMN_NOTE_DESC],
                                  sno: allNotes[index][DBHelper.COLUMN_NOTE_SNO]),
                              )
                              );
                              /* showModalBottomSheet(
                              context: context, builder: (context) {
                            titleController.text = allNotes[index][DBHelper.COLUMN_NOTE_TITLE];
                            titleController.text = allNotes[index][DBHelper.COLUMN_NOTE_DESC];
                            return getBottomSheetWidget(isUpdate: true,
                                sno :allNotes[index][DBHelper.COLUMN_NOTE_SNO] );
                          }); */
                            },
                            child: Icon(Icons.edit, color: Colors.green,)),

                        InkWell(
                          /* onTap :() async {
                            bool check = await dbRef!.deleteNote(sno: allNotes[index][DBHelper.COLUMN_NOTE_SNO]);
                            if(check){
                              getNotes();
                            } */
                          child: Icon(Icons.delete,color:Colors.red),),
                      ],
                    ),
                  ),
                );

              }) : Center(
            child: Text('No Notes yet!!'),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(),
          )
          );


          /* showModalBottomSheet(
              context: context, builder: (context){
            titleController.clear();
            descController.clear();
            return getBottomSheetWidget();

          }); */


        },
        child: Icon(Icons.add, color: Colors.blue,),
      ),
    );
  }
}
