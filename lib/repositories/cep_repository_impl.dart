import 'dart:math';

import 'package:dio/dio.dart';

import '../models/cep_model.dart';
import 'cep_repository.dart';

class CepRepositoryImpl implements CepRepository {
  @override
  Future<CepModel> getCep(String cep) async {

   try {
     final result = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      return CepModel.fromMap(result.data);
   } on DioError catch (e) {
      throw Exception('Erro ao buscar o CEP');
   }

  }

}