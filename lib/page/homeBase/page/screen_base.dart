// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:desafio_wswork/componentes/LogosIntoRow/logo.dart';
import 'package:desafio_wswork/componentes/carros/carros.dart';
import 'package:desafio_wswork/page/homeBase/controller/controller.dart';
import 'package:desafio_wswork/page/homeBase/repository/featch_cars.dart';
import 'package:flutter/material.dart';

class ScreenBase extends StatefulWidget {
  const ScreenBase({super.key});

  @override
  State<ScreenBase> createState() => _ScreenBaseState();
}

class _ScreenBaseState extends State<ScreenBase> {
  late RepositoryCars controllerRepository;
  late BaseScreenController controller;
  late String valorFormatado;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    controllerRepository = RepositoryCars();
    controller = BaseScreenController();
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
      String resultado = await controllerRepository.enviarLeads();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(resultado),
        duration: const Duration(seconds: 3),
        showCloseIcon: true,
      ));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> imagemCarros = [
      'assets/CARROS/ONIX.png',
      'assets/CARROS/JETTA.png',
      'assets/CARROS/HILLUX.png',
    ];
    double sizeWidth = MediaQuery.sizeOf(context).width;
    double sizeHeigth = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return BottomNavigationBar(
                elevation: 2.5,
                selectedFontSize: 20,
                selectedItemColor: Colors.deepPurple,
                currentIndex: controller.pageController,
                onTap: (int index) {
                  controller.mudarPage(index);
                },
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                                10), // Altere o valor conforme necessário
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications_none_outlined,
                          size: 35,
                        ),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10), // Altere o valor conforme necessário
                            ),
                            color: Colors.white),
                        child: const Icon(
                          Icons.location_on_outlined,
                          size: 35,
                        ),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10), // Altere o valor conforme necessário
                            ),
                            color: Colors.white),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 35,
                        ),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  10), // Altere o valor conforme necessário
                            ),
                            color: Colors.white),
                        child: const Icon(
                          Icons.person_outline_outlined,
                          size: 35,
                        ),
                      ),
                      label: ''),
                ],
              );
            }),
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.search),
            )
          ],
          centerTitle: true,
          title: const Text(
            'Car Shop',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: FutureBuilder(
          future: controllerRepository.fetchData(),
          builder: (context, snapshot) {
            if (controllerRepository.carros.isNotEmpty) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: sizeWidth,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'Corporativo Diferencial',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            Text(
                              'Aproveite, e faça um teste driving',
                              style: TextStyle(fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: sizeWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: sizeWidth / 1.5,
                                height: 50,
                                child: TextField(
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    label: const Text(
                                      'Pesquisar por um carro',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              88, 255, 255, 255)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.deepPurple),
                                child: const Icon(
                                  Icons.settings_input_component_outlined,
                                  opticalSize: 2.5,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    SizedBox(
                      width: sizeWidth,
                      child: Column(
                        children: [
                          SizedBox(
                            width: sizeWidth,
                            child: const Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Top Marcas',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    'Ver Todos',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(88, 255, 255, 255)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //LOGO
                          SizedBox(
                            // width: sizeWidth,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: sizeWidth / 3.5,
                                    child: const LogoIntoRow(
                                      imagemLogo: 'assets/LOGO/chevrolet.png',
                                    ),
                                  ),
                                  SizedBox(
                                    width: sizeWidth / 3.5,
                                    child: const LogoIntoRow(
                                      imagemLogo: 'assets/LOGO/toyota.png',
                                    ),
                                  ),
                                  SizedBox(
                                    width: sizeWidth / 3.5,
                                    child: const LogoIntoRow(
                                      imagemLogo: 'assets/LOGO/volkswagen.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //CARROS
                    SizedBox(
                      width: sizeWidth,
                      child: Column(
                        children: [
                          SizedBox(
                            width: sizeWidth,
                            child: const Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Mais comprados',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 15,
                                  ),
                                  child: Text(
                                    'Ver Todos',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(88, 255, 255, 255)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: sizeWidth / 1,
                            height: sizeHeigth / 1,
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CarrosIntoRow(
                                    idCarro: controllerRepository
                                        .carros[index].id
                                        .toString(),
                                    ano: controllerRepository.carros[index].ano
                                        .toString(),
                                    capacidadePessoas: '4',
                                    portas: controllerRepository
                                        .carros[index].numPortas
                                        .toString(),
                                    tipoCombustivel: controllerRepository
                                        .carros[index].combustivel
                                        .toString(),
                                    imagemCarro: imagemCarros[index],
                                    tag: imagemCarros[index],
                                    modeloCarro: controllerRepository
                                        .carros[index].nomeModelo
                                        .toString(),
                                    cor: controllerRepository.carros[index].cor
                                        .toString(),
                                    precoCarro: controllerRepository
                                        .carros[index].valor,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                itemCount: controllerRepository.carros.length),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (controllerRepository.carros.isEmpty) {
              return SizedBox(
                width: sizeWidth,
                height: sizeHeigth,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.info),
                      Text('Algo deu errado'),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox(
                width: sizeWidth,
                height: sizeHeigth,
                child: const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
