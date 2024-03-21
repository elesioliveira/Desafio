// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';

import 'package:desafio_wswork/db/db.dart';
import 'package:desafio_wswork/model/cars.dart';
import 'package:desafio_wswork/model/compra_carro.dart';
import 'package:dio/dio.dart';

class RepositoryCars {
  final List<Car> _carros = [];
  List<Car> get carros => _carros;

  // Método para converter lista de CompraCarro em formato JSON
  String comprasToJson(List<CompraCarro> compras) {
    List<Map<String, dynamic>> comprasMapList =
        compras.map((compra) => compra.toMap()).toList();
    return jsonEncode(comprasMapList);
  }

  Future<List<Car>> fetchData() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['cars'];
        for (var carData in data) {
          Car car = Car.fromJson(carData);
          _carros.add(car);
        }
        return carros;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String> enviarLeads() async {
    try {
      // Obtenha os leads do banco de dados
      List<CompraCarro> leads =
          await DatabaseHelper.instance.getAllData(orderBy: 'nome');

      print(leads);

      // Envie os leads para a URL
      await postData(leads);
      return 'Compra enviada com sucesso!';
    } catch (e) {
      return 'Erro ao enviar os leads: $e';
    }
  }

  Future<void> postData(List<CompraCarro> compras) async {
    // Crie uma instância do Dio
    Dio dio = Dio();

    // Defina a URL para onde enviar o POST
    String url = '';

    try {
      // Converta a lista de compras para JSON
      String comprasJson = comprasToJson(compras);

      // Realize a requisição POST com os dados JSON
      Response response = await dio.post(
        url,
        data: comprasJson,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      // Verifique se a requisição foi bem-sucedida
      if (response.statusCode == 200) {
        print('Resposta do servidor: ${response.data}');
      } else {
        // Lidere com erros de requisição, se houver
        print('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      // Capture e lide com erros de exceção
      print('Erro ao realizar a requisição: $e');
    }
  }
}
