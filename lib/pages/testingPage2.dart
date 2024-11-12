
import 'dart:convert';

import 'package:food_ordering_app/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseService{
  static Database? _db;
  
  static final DatabaseService instance = DatabaseService._constructor();

  final String _TableName = "Food_Sessions";
  final String _TableId= "id";
  final String _StartDuration= "StartTime";
  final String _EndDuration= "EndTime";
  final String _TableAddons="Addons";
  final String _TappedCount="No_of_Times_Tapped";
  final String _TimeSpent="Food_Duration";
  final String _Address="Address";
  final String _OrderValue="order_value";
  final String _ItemQuantity="Total_Items_quantity";


  DatabaseService._constructor();


  Future<Database> get database async{
    if(_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }


  Future<Database> getDatabase() async{

    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath,"master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db,version){
        db.execute(
          '''
          CREATE TABLE $_TableName (
          $_TableId INTEGER PRIMARY KEY,
          $_StartDuration TEXT ,
          $_EndDuration TEXT,
          $_TableAddons TEXT,
          $_TappedCount TEXT,
          $_TimeSpent TEXT,
          $_Address TEXT,
          $_OrderValue TEXT,
          $_ItemQuantity TEXT 
          )
          '''
        );
      }
    );
    return database;
  }

  

//   void addDuration(String Duration, bool Start) async{
//     Database? db = await database;
//     if(Start==true){
//       await db.insert(_TableName,{
//       _StartDuration:Duration,
//     });
//     }else{
//         await db.insert(_TableName,{
//       _EndDuration:Duration,
//     });
//     }
    
    
//   }
//   void addFoodDuration(String duration)async{
//     final db = await database;
//     await db.insert(_TableName,
//      {_TimeSpent:duration});
//   }

//   void addNoOfTaps(Map<String, dynamic> tapMap) async{
//      final db = await database;
//        final jsonMap = jsonEncode(tapMap);
//      await db.insert(_TableName,
//      {
//       _TappedCount:jsonMap,
      
//      },
//      conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//   void addOrderValue(String value) async{
//     final db = await database;
//     await db.insert(_TableName, {
//       _OrderValue:value
//     });
//   }
//   void addAddress(String address)async{
//       final db = await database;
//     await db.insert(_TableName, {
//       _Address: address
//     });
//   }
//   void addTotalItemsBought(List TotalItem)async{
//      final db = await database;
//      final jsonList = jsonEncode(TotalItem);
//     await db.insert(_TableName, {
//      _ItemQuantity: jsonList,
     
//     },
//     conflictAlgorithm: ConflictAlgorithm.replace,
// );
//   }
//   void addAddons(List AddonList)async {
//      final db = await database;
//      final jsonList = jsonEncode(AddonList);
//     await db.insert(_TableName, {
//      _TableAddons: jsonList,
     
//     },
//     conflictAlgorithm: ConflictAlgorithm.replace,
// );
//   }
  void addFinalSession(String DurationStart,String DurationEnd,List FoodDuration , Map<String, dynamic> tapMap , String OrderValue,String address,List TotalItem,List AddonList )async{
    final db = await database;
    final jsonTapMap = jsonEncode(tapMap);
    final jsonTotalItem = jsonEncode(TotalItem);
    final jsonAddon = jsonEncode(AddonList);
    final jsonFoodDuration = jsonEncode(FoodDuration);

    await db.insert(_TableName,
    {
      _StartDuration:DurationStart ,
         _EndDuration:DurationEnd, 
         _TableAddons: jsonAddon,
          _TappedCount: jsonTapMap,
         _TimeSpent: jsonFoodDuration,
          _Address: address,
        _OrderValue: OrderValue,
         _ItemQuantity: jsonTotalItem 
    },
     conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  getLastId() async{
    int count=0;
      final db = await database;
      final result = db.query(
        _TableName,
        orderBy: 'id DESC',
        limit: 10,
      );
      result.then((data){
        for(var row in data){
          print('${row}');
        }
      }); 
      
  }

   getTask(String DurationStart) async{
    final db = await database;
    // await db.insert(_TableName,
    // {
    //   _StartDuration:DurationStart 
    // },
    //  conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  
    final data = await db.query(_TableName);
    print(data);
  }
   deleteAllRows() async{
    final db = await instance.database;
    await db.delete('Food_Sessions');
    print('deleted everything');
  }
}