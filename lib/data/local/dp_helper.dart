import 'dart:io';

import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper{

  DBHelper._();
  static final DBHelper getinstance = DBHelper._();
  //table note
  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE= "title";
  static final String COLUMN_NOTE_DESC = "desc";


  Database? myDB;



  Future<Database>getDB() async{

    myDB??= await openDB();
    return myDB!;


  }
  Future<Database> openDB() async {

    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, "noteDB.db");

   /* if (await databaseExists(dbPath)) {
      await deleteDatabase(dbPath);
    } */

    return await openDatabase(dbPath, onCreate:(db, version) async {

      await db.execute(
          "CREATE TABLE $TABLE_NOTE ("
              "$COLUMN_NOTE_SNO INTEGER PRIMARY KEY AUTOINCREMENT, "
              "$COLUMN_NOTE_TITLE TEXT, "
              "$COLUMN_NOTE_DESC TEXT)"
      );


    }, version: 1);
  }

  Future<bool> addNote({required String mTitle, required String mDesc}) async{

    var db = await getDB();

    int rowsEffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE : mTitle,
      COLUMN_NOTE_DESC : mDesc,
    });
    return rowsEffected>0;


  }

  Future<List<Map<String, dynamic>>> getAllNotes() async{
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE);

    return mData;

  }

  Future<bool> updateNotes({required String mTitle, required String mDesc, required int sno}) async{
    var db = await getDB();


    int rowsEffected = await db.update(TABLE_NOTE, {
      COLUMN_NOTE_TITLE : mTitle,
      COLUMN_NOTE_DESC : mDesc
    }, where : "$COLUMN_NOTE_SNO = $sno");  // condition diye h

    return rowsEffected>0;

  }


  Future<bool> deleteNote({required int sno}) async{
    var db = await getDB();

    int rowsEffected = await db.delete(TABLE_NOTE, where:"$COLUMN_NOTE_SNO = ?", whereArgs: ['$sno']);
    return rowsEffected>0;

  }
}
