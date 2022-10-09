import 'package:cep_app/models/cep_model.dart';


import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  CepModel? enderecoModel;

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  bool get valid => formKey.currentState?.validate() ?? false;



  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar CEP'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //irpara outra pagina SearchEnderecoPage();
            // ElevatedButton(
            //   onPressed: () {
            //
            //   }, child: const Text('Ir para outra pagina'),
            // ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Digite o CEP',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: cepEC,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite um CEP válido';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CEP',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (value) async {
                          if (valid) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              final endereco =
                                  await cepRepository.getCep(cepEC.text);
                              setState(() {
                                isLoading = false;
                                enderecoModel = endereco;
                              });
                            } catch (e) {
                              setState(() {
                                //limpar campo de cep
                                cepEC.clear();
                                isLoading = false;
                                enderecoModel = null;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  content: Text('Erro ao buscar o CEP'),
                                ),
                              );
                            }
                          }
                        },
                        toolbarOptions: const ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: false,
                          selectAll: true,
                        ),
                        cursorColor: Colors.red),
                    ElevatedButton(
                      onPressed: () async {
                        final valid = formKey.currentState?.validate() ?? false;
                        if (valid) {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            final endereco =
                                await cepRepository.getCep(cepEC.text);
                            setState(() {
                              isLoading = false;
                              enderecoModel = endereco;
                            });
                          } catch (e) {
                            setState(() {
                              cepEC.clear();
                              isLoading = false;
                              enderecoModel = null;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                content: Text('Erro ao buscar o CEP'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Buscar'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
                visible: isLoading, child: const CircularProgressIndicator()),
            Visibility(
                visible: enderecoModel != null,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text('CEP: ',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 20)),
                          //     Text(enderecoModel?.cep ?? '',
                          //         style: const TextStyle(fontSize: 20)),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text('Logradouro: ',
                          //         style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 20,
                          //         )),
                          //     Expanded(
                          //       child: Text(enderecoModel?.logradouro ?? '',
                          //           overflow: TextOverflow.ellipsis,
                          //           softWrap: false,
                          //           maxLines: 2,
                          //           style: const TextStyle(fontSize: 20)),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text('Complemento: ',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 20)),
                          //     Text(enderecoModel?.complemento ?? '',
                          //         style: const TextStyle(fontSize: 20)),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text('Bairro: ',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 20)),
                          //     Text(enderecoModel?.bairro ?? '',
                          //         style: const TextStyle(fontSize: 20)),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text('Localidade: ',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 20)),
                          //     Text(enderecoModel?.localidade ?? '',
                          //         style: const TextStyle(fontSize: 20)),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text('UF: ',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 20)),
                          //     Text(enderecoModel?.uf ?? '',
                          //         style: const TextStyle(fontSize: 20)),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text('IBGE: ',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 20)),
                          //     Text(enderecoModel?.ibge ?? '',
                          //         style: const TextStyle(fontSize: 20)),
                          //   ],
                          // ),
                SizedBox(
                  height: 20,
                ),
                        ],
                      ),
                    ),

                    DataTable(

                      dataRowHeight: 50,
                      columns: const [
                        DataColumn(label: Text('DDD ')),

                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(
                            Text(enderecoModel?.ddd ?? ''),
                          ),

                        ]),
                      ],
                    ),

                    //table with data
                    DataTable(

                      dataRowHeight: 50,
                      columns: const [
                        DataColumn(label: Text('CEP')),
                        DataColumn(label: Text('Logradouro')),
                        DataColumn(label: Text('Bairro')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(enderecoModel?.cep ?? '')),
                          DataCell(Text(enderecoModel?.logradouro ?? '')),
                          DataCell(Text(enderecoModel?.bairro ?? '')),
                        ]),
                      ],
                    ),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Localidade')),
                        DataColumn(label: Text('UF')),
                        DataColumn(label: Text('COD CIDADE')),

                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text(enderecoModel?.localidade ?? '')),
                          DataCell(Text(enderecoModel?.uf ?? '')),
                          DataCell(Text(enderecoModel?.ibge ?? '')),

                        ]),
                      ],
                    ),


                  ],
                )),
          ],
        ),
      ),
    );
  }
}
