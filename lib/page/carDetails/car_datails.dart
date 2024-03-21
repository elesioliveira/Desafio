// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:brasil_fields/brasil_fields.dart';
import 'package:desafio_wswork/componentes/infoCar/info_car.dart';
import 'package:desafio_wswork/db/db.dart';
import 'package:desafio_wswork/model/compra_carro.dart';
import 'package:desafio_wswork/page/carDetails/controller/controller_details_car.dart';
import 'package:desafio_wswork/page/homeBase/repository/featch_cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter/cupertino.dart';

class CarDetails extends StatefulWidget {
  CarDetails({
    super.key,
    required this.tag,
    required this.imagemHero,
    required this.ano,
    required this.modelo,
    required this.tipoCombustivel,
    required this.capacidadePessoas,
    required this.portas,
    required this.valor,
    required this.cor,
    required this.idCarro,
  });
  final String tag;
  final String imagemHero;
  final String ano;
  final String modelo;
  final String tipoCombustivel;
  final String capacidadePessoas;
  final String portas;
  final double valor;
  final String cor;
  final String idCarro;
  late TextEditingController nome;
  late TextEditingController telefone;

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late RepositoryCars controllerRepository;
  @override
  void initState() {
    super.initState();
    controllerRepository = RepositoryCars();
    widget.nome = TextEditingController();
    widget.telefone = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    widget.nome.dispose();
    widget.telefone.dispose();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Impede o fechamento ao clicar fora do diálogo
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirme a compra'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  },
                  controller: widget.nome,
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const Gap(5),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu telefone';
                    }
                    return null;
                  },
                  controller: widget.telefone,
                  decoration: const InputDecoration(
                    label: Text('Telefone'),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Fecha o diálogo manualmente
              },
              child: const Text(
                'Cancelar',
              ),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  CompraCarro novaCompra = CompraCarro(
                      nome: widget.nome.text,
                      telefone: widget.telefone.text,
                      idCarro: widget.idCarro);
                  await DatabaseHelper.instance.insertData(novaCompra.toMap());
                  widget.nome.text = '';
                  widget.telefone.text = '';
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Confirmar',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  DetailsController controllerDetails = DetailsController();
  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.sizeOf(context).width;
    double sizeHeigth = MediaQuery.sizeOf(context).height;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Detalhes',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              width: sizeWidth,
              child: Hero(
                tag: widget.tag,
                child: Image.asset(
                  widget.imagemHero,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  height: sizeHeigth / 3,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              width: sizeWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.ano,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  AnimatedBuilder(
                      animation: controllerDetails,
                      builder: (context, _) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controllerDetails.curtirCarro();
                              },
                              child: Icon(
                                controllerDetails.likeCar
                                    ? CupertinoIcons.star_fill
                                    : CupertinoIcons.star,
                                color: controllerDetails.likeCar
                                    ? Colors.amber
                                    : Colors.white,
                              ),
                            ),
                            Text(
                              '4.8',
                              style: TextStyle(
                                color: controllerDetails.likeCar
                                    ? Colors.amber
                                    : Colors.white,
                              ),
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
            const Gap(5),
            Container(
              width: sizeWidth,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.modelo,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${widget.valor} R\$ ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'preço final',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Gap(35),
            InfoCarIcon(
              cor: widget.cor,
              portas: widget.portas,
              tipoCombustivel: widget.tipoCombustivel,
              size: sizeWidth,
            ),
            const Gap(35),
            SizedBox(
              width: sizeWidth,
              child: Padding(
                padding: EdgeInsets.only(left: sizeWidth / 15),
                child: const Text(
                  'Select Location',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            const Gap(20),
            SizedBox(
              width: sizeWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: sizeWidth / 2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          CupertinoIcons.placemark,
                          color: Colors.deepPurple,
                          size: 35,
                        ),
                        Text(
                          'Braço do Norte',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text('Rua Leonardo Marino Harger 552'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    child: Column(
                      children: [
                        Text(
                          'Map',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Preview',
                          style: TextStyle(fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              width: sizeWidth,
              height: sizeHeigth / 15,
              child: ElevatedButton(
                onPressed: () {
                  _showDialog(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurple),
                ),
                child: const Text(
                  'Comprar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
