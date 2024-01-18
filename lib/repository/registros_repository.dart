import 'package:imc_app2/models/registro_model.dart';
import 'package:imc_app2/repository/sqlite_database.dart';

class RegistrosRepository {
  Future<List<RegistroModel>> obterDados() async {
    List<RegistroModel> registros = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery('SELECT id, nome, altura, peso FROM pessoa');
    for (var i in result) {
      registros.add(RegistroModel(
          int.parse(i["id"].toString()),
          i["nome"].toString(),
          double.parse(i["altura"].toString()),
          int.parse(i["peso"].toString())));
    }
    return registros;
  }

  Future<void> salvar(RegistroModel pessoa) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('INSERT INTO pessoa (nome, altura, peso) values (?,?,?)',
        [pessoa.nome, pessoa.altura, pessoa.peso]);
  }

  Future<void> alterar(RegistroModel pessoa) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawUpdate(
        'UPDATE pessoa nome = ?, altura = ?, peso =? WHERE id = ?',
        [pessoa.nome, pessoa.altura, pessoa.peso, pessoa.id]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawDelete('DELETE FROM pessoa WHERE id = ?', [id]);
  }

  Future<void> resetTotal() async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawDelete('DELETE FROM pessoa');
  }
}
