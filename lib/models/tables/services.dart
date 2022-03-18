class Service {
 int? id;
 double? preco;
 String? servico;

 Service(this.id, this.preco, this.servico);

   Service.fromJsonApi(Map<String, dynamic> json) {
    this.id = json['id'];
    this.preco = json['preco'];
    this.servico = json['servico'];
  }
}