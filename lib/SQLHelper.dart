import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    database.execute("""CREATE TABLE notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    education TEXT,
    Address TEXT,
    number  TEXT,
    skill TEXT,
    desc TEXT,
    
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('notesBook.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createNote(String name,String education,String Address,String number,String skill, String desc) async {
    final db = await SQLHelper.db();

    final data = {'name': name,'Address':Address,'skill':skill,'number':number,'education':education, 'desc': desc};
    final id = await db.insert('notes', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await SQLHelper.db();
    return db.query("notes", orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getnote(int id) async {
    final db = await SQLHelper.db();
    return db.query('notes', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateNote(int id, String name,String number,String Address,String education,String skill, String desc) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'number':number,
      'Address':Address,
      'education':education,
      'skill':skill,
      'desc': desc,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('notes', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteNote(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('notes', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Some error occur");
    }
  }
}
