import 'package:desafio_wswork/page/homeBase/page/screen_base.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
            primary: Colors.deepPurple,
            onPrimary: Colors.deepPurple,
            primaryContainer: Colors.deepPurple),
      ),
      home: const ScreenBase(),
    );
  }
}
