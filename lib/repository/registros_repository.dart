import 'package:imc_app2/models/pessoa_model.dart';

class RegistrosRepository {
  final List<Pessoa> _registros = [];

  void adicionar(Pessoa pessoa) {
    _registros.add(pessoa);
  }

  void alterar(String id, double peso) {
    _registros.where((pessoa) => pessoa.id == id).first.peso = peso;
  }

  void remove(String id) {
    _registros.remove(_registros.where((pessoa) => pessoa.id == id).first);
  }

  List<Pessoa> listarRegistros() {
    return _registros;
  }
}
