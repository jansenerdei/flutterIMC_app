class RegistroModel {
  int _id = 0;
  String _nome = "";
  double _altura = 0;
  int _peso = 0;

  RegistroModel(this._id, this._nome, this._altura, this._peso);

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  int get peso => _peso;

  set peso(int peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }
}
