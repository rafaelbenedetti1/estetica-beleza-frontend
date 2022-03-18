class Hour {
  int? id;
  int? profissionalId;
  String? horario;
  bool? status;

  Hour(this.id, this.profissionalId, this.horario, this.status);

  Hour.fromJsonApi(Map<String, dynamic> json) {
    this.id = json['id'];
    this.profissionalId = json['profissional_id'];
    this.id = json['horario'];
    this.id = json['status'];
  }
}
