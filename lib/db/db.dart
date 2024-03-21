import 'package:desafio_wswork/model/compra_carro.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'wswork_desafio.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE compra_cliente (
        idCarro TEXT,
        nome Text,
        telefone TEXT
      )
    ''');
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    Database db = await instance.database;
    return await db.insert('compra_cliente', data);
  }

  Future<List<CompraCarro>> getAllData({String? orderBy}) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
        await db.query('compra_cliente', orderBy: orderBy);
    return List.generate(maps.length, (index) {
      return CompraCarro.fromMap(maps[index]);
    });
  }
}
