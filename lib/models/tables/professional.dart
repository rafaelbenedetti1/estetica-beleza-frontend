class Professional {
  int? id;
  String? nome;
  int? telefone;
  String? nomeServico;

  Professional(this.id, this.nome, this.telefone, this.nomeServico);

  Professional.fromJsonApi(Map<String, dynamic> json) {
    this.id = json['id'];
    this.nome = json['name'];
    this.telefone = json['telefone'];
    this.nomeServico = json['nomeServico'];
  }
}
