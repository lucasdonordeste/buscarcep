import 'package:cep_app/models/cep_model.dart';

abstract class CepRepository {
  Future<CepModel> getCep(String cep);
}
