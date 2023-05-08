import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../models/Usermodel.dart';

class DBHelper {
  static Database _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserId = 'User_id';
  static const String C_UserName = 'User_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        "$C_UserId TEXT,"
        " $C_UserName TEXT,"
        "$C_Email TEXT,"
        "$C_Password TEXT,"
        "PRIMARY KEY ($C_UserId)"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel> getLoginUser(String userid, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * from $Table_User where"
        "$C_UserId ='$userid'AND"
        "$C_Password ='$password'");
    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }
    return null;
  }
}
