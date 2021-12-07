import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

Database? database;
List<Map> newTasks = [];
List<Map> doneTasks = [];
List<Map> archivedTasks = [];

void createDatabase() {
  openDatabase(
    'todo.db',
    version: 1,
    onCreate: (database, version) {
      print('database created');
      database
          .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error When Creating Table ${error.toString()}');
      });
    },
    onOpen: (database)
    {
      getDataFromDatabase(database);
      print('database opened');
    },
  ).then((value) {
    database = value;

  });
}

void insertToDatabase({
  required String title,
  required String time,
  required String date,
}) async {
   await database!.transaction((txn)async{
    txn
        .rawInsert(
      'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
    )
        .then((value) {
      print('$value inserted successfully');


      getDataFromDatabase(database);
    }).catchError((error) {
      print('Error When Inserting New Record ${error.toString()}');
    });

  });
}

void getDataFromDatabase(database) {
  newTasks = [];
  doneTasks = [];
  archivedTasks = [];



  database.rawQuery('SELECT * FROM tasks').then((value) {

    value.forEach((element)
    {
      if(element['status'] == 'new')
        newTasks.add(element);
      else if(element['status'] == 'done')
        doneTasks.add(element);
      else archivedTasks.add(element);
    });

  });
}

void updateData({
  required String status,
  required int id,
}) async
{
  database!.rawUpdate(
    'UPDATE tasks SET status = ? WHERE id = ?',
    ['$status', id],
  ).then((value)
  {
    getDataFromDatabase(database);

  });
}

void deleteData({
  required int id,
}) async
{
  database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
      .then((value)
  {
    getDataFromDatabase(database);

  });
}