import 'package:desafio_wswork/page/carDetails/car_datails.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CarrosIntoRow extends StatefulWidget {
  const CarrosIntoRow(
      {super.key,
      required this.imagemCarro,
      required this.tag,
      required this.modeloCarro,
      required this.precoCarro,
      required this.cor,
      required this.ano,
      required this.capacidadePessoas,
      required this.portas,
      required this.tipoCombustivel,
      required this.idCarro});
  final String imagemCarro;
  final String tag;
  final String modeloCarro;
  final String cor;
  final double precoCarro;
  final String ano;
  final String capacidadePessoas;
  final String portas;
  final String tipoCombustivel;
  final String idCarro;

  @override
  State<CarrosIntoRow> createState() => _CarrosIntoRowState();
}

class _CarrosIntoRowState extends State<CarrosIntoRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 130,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                  type: PageTransitionType.bottomToTop,
                  child: CarDetails(
                    idCarro: widget.idCarro,
                    cor: widget.cor,
                    modelo: widget.modeloCarro,
                    valor: widget.precoCarro,
                    ano: widget.ano,
                    capacidadePessoas: widget.capacidadePessoas,
                    portas: widget.portas,
                    tipoCombustivel: widget.tipoCombustivel,
                    imagemHero: widget.imagemCarro,
                    tag: widget.tag,
                  ),
                ),
              );
            },
            child: Hero(
              tag: widget.tag,
              child: Image.asset(
                widget.imagemCarro,
              ),
            ),
          ),
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  widget.modeloCarro,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              FittedBox(
                child: Text(
                  widget.cor,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      '${widget.precoCarro} R\$',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
