// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// final String tableName = "products";
// final String pId = "pid";
// final String pName = "pname";
// final String pPrice = "pprice";
// final String pRating = 'prating';

// class LocalDatabase {
//   Database db;

//   LocalDatabase(){
//     initDatabase();
//   }

//   Future<void> initDatabase() async {

//     var databasesPath = await getDatabasesPath();
//     String path = join(databasesPath, 'ecommerce.db');

//     db = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute(
//             "CREATE TABLE $tableName($pId INTEGER PRIMARY KEY AUTOINCREMENT, $pName TEXT,  $pPrice INTEGER, $pRating INTEGER)");
//       },
//     );
//   }

// }
