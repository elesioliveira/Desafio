class CompraCarro {
  final String idCarro;
  final String nome;
  final String telefone;

  CompraCarro(
      {required this.idCarro, required this.nome, required this.telefone});

  factory CompraCarro.fromMap(Map<String, dynamic> map) {
    return CompraCarro(
      idCarro: map['idCarro'],
      nome: map['nome'],
      telefone: map['telefone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idCarro': idCarro,
      'nome': nome,
      'telefone': telefone,
    };
  }
}
