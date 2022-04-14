import 'package:estetica_beleza/models/tables/professional.dart';
import 'package:estetica_beleza/shared/clients/hours_client.dart';
import 'package:estetica_beleza/shared/clients/professionals_client.dart';
import 'package:estetica_beleza/shared/clients/services_client.dart';
import 'package:estetica_beleza/shared/exceptions/app_exception.dart';
import 'package:estetica_beleza/views/components/card_base.dart';
import 'package:estetica_beleza/views/components/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_shapes/flutter_shapes.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../models/tables/services.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _formKey = GlobalKey<FormState>();
  List<String> items = ['Mão', 'Pé', 'Mão e Pé,'];
  String? selectedValue;
  List<dynamic>? servicos;
  List<Service>? services;
  List<DropdownMenuItem> listCombo = [];
  List<dynamic> professionalsList = [];
  @override
  void initState() {
    super.initState();
    _initVariables();
  }

  void _initVariables() async {
    services = await _buscarServicos();
    services?.forEach((p) {
      servicos?.add(Service(p.id, p.preco, p.servico));
      listCombo.add(DropdownMenuItem(
        key: Key("${p.servico}"),
        child: Text(p.servico!),
        value: p.servico,
      ));
    });
    print(services);
  }

  void _buscaProfissionais() async {
    var professionals = await _buscarProfessionals();
    print(professionals);
    setState(() {
      professionalsList.addAll(professionals);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _pageSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopAppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(187, 161, 79, 40),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text('Agendar Horário',
                  style: TextStyle(
                      fontFamily: 'DancingScript',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900])),
              Padding(
                padding: const EdgeInsets.only(top: 20),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Card(
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 5, bottom: 10, top: 10, left: 5),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(187, 161, 79, 40))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(187, 161, 79, 40))),
                              hintText: "Informe o Nome Completo",
                              prefixIcon: Icon(AntDesign.user,
                                  color: Color.fromRGBO(187, 161, 79, 40)),
                              hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(187, 161, 79, 40)),
                              hoverColor: Colors.white,
                              fillColor: Colors.white,
                              labelText: "Nome",
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(187, 161, 79, 40))),
                          style: TextStyle(
                              fontSize: 18, fontFamily: 'DancingScript'),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 5, bottom: 20, top: 10, left: 5),
                        child: DropdownButtonFormField2<dynamic>(
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(187, 161, 79, 40))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromRGBO(187, 161, 79, 40)))),
                          dropdownDecoration:
                              BoxDecoration(color: Colors.grey[900]),
                          style: TextStyle(
                            color: Color.fromRGBO(187, 161, 79, 40),
                          ),
                          iconDisabledColor: Color.fromRGBO(187, 161, 79, 40),
                          iconEnabledColor: Color.fromRGBO(187, 161, 79, 40),
                          dropdownElevation: 24,
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                Icon(MaterialCommunityIcons.hair_dryer,
                                    color: Color.fromRGBO(187, 161, 79, 40)),
                                SizedBox(
                                  width: 14,
                                ),
                                Text('Selecione o Serviço',
                                    style: TextStyle(
                                        color: Color.fromRGBO(187, 161, 79, 40),
                                        fontFamily: 'DancingScript',
                                        fontSize: 18)),
                              ],
                            ),
                          ),
                          // value: ,
                          items: listCombo,
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                              _buscaProfissionais();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.grey[900],
                  child: ListView.builder(
                    itemCount: professionalsList.length,
                    itemBuilder: (context, index) {
                      Professional profissional = professionalsList[index];
                      return Column(
                        children: <Widget>[
                          ListTile(
                            // onTap: () {
                            //   Navigator.push(context,
                            //       MaterialPageRoute(builder: (context) => ResultAuthoritiesPage(permissao: authority)));
                            // },
                            trailing: TextButton(
                                onPressed: () {},
                                child: Container(
                                  color: Color.fromRGBO(187, 161, 79, 40),
                                  child: Text(
                                    'Horários',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'DancingScript',
                                        color: Colors.grey[900]),
                                  ),
                                )),
                            selected: true,
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesome.user,
                                    size: 20,
                                    color: Color.fromRGBO(187, 161, 79, 40)),
                              ],
                            ),
                            title: Text(
                              profissional.nome!,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'DancingScript',
                                  color: Color.fromRGBO(187, 161, 79, 40)),
                            ),
                          ),
                          Divider(
                              thickness: 1,
                              endIndent: 18,
                              indent: 18,
                              color: Colors.grey[350])
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buscarProfessionals() async {
    try {
      return await ProfessionalsClient().consultarProfessionals(selectedValue);
    } on AppException catch (e) {
    } catch (e) {
      return null;
    } finally {
      setState(() {});
    }
  }

  _buscarServicos() async {
    try {
      return await ServiceClient().consultarServices();
    } on AppException catch (e) {
    } catch (e) {
      return null;
    }
  }
}
