class Donor {
  final String id;
  final String nome;
  final int idade;
  final String sexo;
  final double peso;
  final double altura;
  final String tipoSanguineo;
  final String estado;

  Donor({
    required this.id,
    required this.nome,
    required this.idade,
    required this.sexo,
    required this.peso,
    required this.altura,
    required this.tipoSanguineo,
    required this.estado,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['id'],
      nome: json['nome'],
      idade: json['idade'],
      sexo: json['sexo'],
      peso: json['peso'].toDouble(),
      altura: json['altura'].toDouble(),
      tipoSanguineo: json['tipo_sanguineo'],
      estado: json['estado'],
    );
  }
}