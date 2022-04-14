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
import 'package:intl/intl.dart';

import '../../models/tables/services.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  String? time = '';
  List<dynamic>? servicos;
  List<Service>? services;
  List<DropdownMenuItem> listCombo = [];
  List<dynamic> professionalsList = [];
  DateTime? _dateTime;
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
    setState(() {
      listCombo;
    });
    print(services);
  }

  void _buscaProfissionais() async {
    var professionals = await _buscarProfessionals();
    print(professionals);
    setState(() {
      professionalsList.clear();
      professionalsList.addAll(professionals);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _pageSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 192, 171, 101),
      appBar: TopAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Agendar Horário',
                style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900])),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey[900]),
                onPressed: () async {
                  _dateTime = await showDatePicker(
                    context: context,
                    initialDate:
                        _dateTime == null ? DateTime.now() : _dateTime!,
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2025),
                  );
                  setState(() {
                    time = DateFormat('dd-MM-yyy').format(_dateTime!);
                  });
                },
                child: Text('Selecione a data',
                    style: TextStyle(
                        color: Color.fromRGBO(187, 161, 79, 40),
                        fontFamily: 'DancingScript',
                        fontSize: 18))),
            sizedBox(),
            Text(
              '$time',
              style: TextStyle(
                        color: Colors.grey[900],
                        fontFamily: 'DancingScript',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)
            ),
            sizedBox(),
            Column(
              children: [
                Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                  color: Color.fromRGBO(187, 161, 79, 40)))),
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
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Flexible(
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
              ),
            )
          ],
        ),
      ),
    );
  }

  sizedBox() {
    if(time == '') {
      return SizedBox(height: 1);
    } else {
      return SizedBox(height: 20);
    }
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
