import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rupesh_notes/data/local/dp_helper.dart';



class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {


  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();


  List<Map<String, dynamic>> allNotes = [];
  DBHelper? dbRef;
  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    dbRef = DBHelper.getinstance;
    getNotes();

  }

  void getNotes() async{
    allNotes = await dbRef!.getAllNotes();
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // all notes visible here
        title: Text('Notes'),
      ),

      body: allNotes.isNotEmpty ? ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (_, index){
            return ListTile(

              leading: Text('${index+1}'),
              title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
              subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
              trailing: SizedBox(
                width: 50,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context, builder: (context) {
                            titleController.text = allNotes[index][DBHelper.COLUMN_NOTE_TITLE];
                            titleController.text = allNotes[index][DBHelper.COLUMN_NOTE_TITLE];
                            return getBottomSheetWidget(isUpdate: true,
                                sno :allNotes[index][DBHelper.COLUMN_NOTE_SNO] );
                          });
                        },
                        child: Icon(Icons.edit)),

                    InkWell(
                      onTap :() async {
                        bool check = await dbRef!.deleteNote(sno: allNotes[index][DBHelper.COLUMN_NOTE_SNO]);
                        if(check){
                          getNotes();
                        }
                      },
                      child: Icon(Icons.delete),),
                  ],
                ),
              ),
            );

          }) : Center(
        child: Text('No Notes yet!!'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          String errorMsg = "";

          showModalBottomSheet(
              context: context, builder: (context){
            titleController.clear();
            descController.clear();
            return getBottomSheetWidget();

          });


        },
        child: Icon(Icons.add),
      ),
    );
  }
//
  Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}){
    return Container(
      padding: EdgeInsets.all(11),
      width: double.infinity,
      child: Column(
        children: [
          Text(isUpdate ? 'Upfate Note' : 'Add Notes', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),),
          SizedBox(
            height: 21,
          ),

          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: "Enter title here",
                label: Text('Title *'),
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
                label: Text('Desc *'),
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
                      var title = titleController.text;
                      var desc = descController.text;
                      // condition
                      if(title.isNotEmpty && desc.isNotEmpty){
                        bool check = isUpdate ? await dbRef!.updateNotes(mTitle: title, mDesc: desc, sno: sno) : await dbRef!.addNote(mTitle: title, mDesc: desc);


                        if(check){
                          getNotes();
                        }
                        Navigator.pop(context);
                      } else {
                        errorMsg = "*Please fill all the required field ";
                        setState(() {

                        });
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
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(errorMsg),
          ),
          )

        ],
      ),

    );
  }
}