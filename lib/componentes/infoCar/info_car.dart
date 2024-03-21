import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCarIcon extends StatelessWidget {
  const InfoCarIcon(
      {super.key,
      required this.tipoCombustivel,
      required this.size,
      required this.portas,
      required this.cor});
  final String tipoCombustivel;
  final double size;
  final String portas;
  final String cor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    CupertinoIcons.speedometer,
                    color: Colors.deepPurple,
                  ),
                  const Text(
                    'TIPO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(tipoCombustivel),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    CupertinoIcons.info,
                    color: Colors.deepPurple,
                  ),
                  const Text(
                    'COR',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(cor),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.door_back_door_outlined,
                    color: Colors.deepPurple,
                  ),
                  const Text(
                    'PORTAS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(portas),
                ],
              ),
            ),
          ],
        ));
  }
}
