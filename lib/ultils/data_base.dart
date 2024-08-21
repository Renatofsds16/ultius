
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ultils/ultils/model_exemple.dart';

class AnotacoesHelper {
  Anotacao anotacao = Anotacao();
  static const nameTable = 'banco_meus_gasto';
  static const colunaId = 'id';
  static const titulo = 'titulo';
  static const categoria = 'categoria';
  static const descricao = 'descricao';
  static const data = 'datatime';
  static const valor = 'valor';
  Database?  _db;
  static final AnotacoesHelper _anotacoesHelper = AnotacoesHelper._internal();
  factory AnotacoesHelper() {
    return _anotacoesHelper;
  }
  AnotacoesHelper._internal();

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _inicializarDb();
      return _db;
    }
  }

  _inicializarDb() async {
    final caminhoBancoDeDados = await getDatabasesPath();
    final locaDB = join(caminhoBancoDeDados, 'banco_meus_gasto.db');
    print('**************** $locaDB **************');
    var db = await openDatabase(locaDB, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String sql = 'CREATE TABLE $nameTable ('
        '$colunaId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$titulo VARCHAR,'
        '$categoria VARCHAR,'
        '$descricao TEXT,'
        '$valor VARCHAR,'
        '$data DATETIME)';
    await db.execute(sql);
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {
    Database database = await db;
    int resultado = await database.insert(nameTable, anotacao.toMap());
    return resultado;
  }

  Future<List> recuperarDados() async {
    Database bancoDados = await db;
    String sql = 'SELECT * FROM $nameTable';
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }

  update(Anotacao anotacao) async {
    Database database = await db;
    int resultado = await database.update(nameTable, anotacao.toMap(),
        where: '$colunaId = ?', whereArgs: [anotacao.id]);
    return resultado;
  }

  delete(Anotacao anotacao) async {
    Database database = await db;
    int resultado = await database.delete(nameTable,
        where: '$colunaId = ?', whereArgs: [anotacao.id]);
    return resultado;
  }
}
