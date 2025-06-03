import 'package:flutter/cupertino.dart';
import 'package:rupesh_notes/data/local/dp_helper.dart';

class DBProvider extends ChangeNotifier{
  DBHelper dbHelper;
  DBProvider({required this.dbHelper});

  List<Map<String, dynamic>> _mData = [];

  // events
void addNote(String title, String desc) async{
  bool check = await dbHelper.addNote(mTitle: title, mDesc: desc);
  if(check){
    _mData = await dbHelper.getAllNotes();
    notifyListeners();
  }

}

  void updateNote (String title, String desc, int sno) async{
    bool check = await dbHelper.updateNotes(mTitle: title, mDesc: desc,sno: sno);
    if(check){
      _mData = await dbHelper.getAllNotes();
      notifyListeners();
    }

  }

List<Map<String, dynamic>> getNotes() => _mData;

void getInitialNotes() async{
  _mData = await dbHelper.getAllNotes();
  notifyListeners();
}
}