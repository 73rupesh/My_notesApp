import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rupesh_notes/data/local/dp_helper.dart';
import 'package:rupesh_notes/db_provider.dart';

class AddNotePage extends StatelessWidget {
  bool isUpdate;
  String title;
  String desc;
  int sno;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DBHelper? dbRef = DBHelper.getinstance;

  AddNotePage({this.isUpdate = false, this.sno = 0, this.title = "", this.desc = "" });
  @override
  Widget build(BuildContext context) {
  if(isUpdate) {
    titleController.text = title;
    descController.text = desc;
  }

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Update Note' : 'Add Notes'),
      ),
      body: Container(
        padding: EdgeInsets.all(11),
        width: double.infinity,
        child: Column(
          children: [
            /*Text(isUpdate ? 'Upfate Note' : 'Add Notes', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),),
            SizedBox(
              height: 21,
            ), */

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Enter title here",
                  label: Text('Title'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  )
              ),
            ),
            SizedBox(
              height: 21,
            ),
            TextField(
              controller: descController,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: "Enter desc here",
                  label: Text('Desc'),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11)
                  )
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width:1,
                        ),
                      )),
                      onPressed: () async{
                        String title = titleController.text;
                        String desc = descController.text;
                        // condition
                        if(title.isNotEmpty && desc.isNotEmpty){
                          if(isUpdate){
                            context.read<DBProvider>().updateNote(title, desc, sno);
                          } else {
                            context.read<DBProvider>().addNote(title, desc);
                          }
                          Navigator.pop(context);
                         /* bool check = isUpdate ? await dbRef!.updateNotes(mTitle: title, mDesc: desc, sno: sno) : await dbRef!.addNote(mTitle: title, mDesc: desc);



                          if(check) {
                            Navigator.pop(context);
                          } */
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please fill all the required field " )));

                        }

                        titleController.clear();
                        descController.clear();

                      }, child: Text(isUpdate ? 'Update Note' : 'Add Notes')),
                ),
                SizedBox(
                  width: 19,
                ),

                Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                          )
                      )),
                      onPressed: (){
                        Navigator.pop(context);

                      }, child: Text('cancel')),

                ),



              ],
            ),


          ],
        ),

      ),
    );
  }

}