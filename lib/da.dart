import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../mo.dart';

class Re{
  static final Re instance = Re._init();
  static Database? _database;
  Re._init();


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('resume.db');
    return _database!;
  }


  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createre);

  }

  Future _createre(Database mo, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await mo.execute("""
    CREATE TABLE $tableNotes(
   ${NotesFields.id} $idType, 
  ${NotesFields.number} $textType,
  ${NotesFields.name} $textType,
  ${NotesFields.description} $textType,
  ${NotesFields.Address} $textType,
  ${NotesFields.skill} $textType,
  ${NotesFields.education} $textType    
    )
     """);
  }

  Future<Notes> create(Notes note) async {
    final mo = await instance.database;
    final id = await mo.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Notes> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NotesFields.values,
      where: '${NotesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Notes.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Notes>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '15/07/23';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Notes.fromJson(json)).toList();
  }

  Future<int> update(Notes note) async {
    final mo = await instance.database;

    return mo.update(
      tableNotes,
      note.toJson(),
      where: '${NotesFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final mo = await instance.database;

    return await mo.delete(
      tableNotes,
      where: '${NotesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final mo = await instance.database;

    mo.close();
  }
}
