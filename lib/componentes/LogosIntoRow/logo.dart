import 'package:flutter/cupertino.dart';

class LogoIntoRow extends StatefulWidget {
  const LogoIntoRow({super.key, required this.imagemLogo});
  final String imagemLogo;

  @override
  State<LogoIntoRow> createState() => _LogoIntoRowState();
}

class _LogoIntoRowState extends State<LogoIntoRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 45, child: Image.asset(widget.imagemLogo));
  }
}
