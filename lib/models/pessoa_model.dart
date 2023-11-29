// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

class Pessoa {
  final String _id = UniqueKey().toString();
  String _nome = "";
  double _altura = 0.0;
  double _peso = 0.0;

  Pessoa(this._nome, this._altura, this._peso);

  String get id => _id;

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }
}
