class Task {
  final int? id;
  final String title;
  final String descricao;
  final int prioridadeId;
  final DateTime criadoEm;
  final int grupoResponsavelId;
  final bool done;

  Task({this.id, required this.title,
  required this.descricao,required this.prioridadeId,required this.criadoEm,
  required this.grupoResponsavelId,
   this.done = false});

  Map<String, dynamic> toMap() {
    return {'id': id, 'titulo': title,'descricao':descricao,'prioridade_Id':prioridadeId,
    'criadoEm':criadoEm, 
    'grupoReponsavelId':grupoResponsavelId,  'done': done ? 1 : 0};
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,title: map['titulo'] as String,
      descricao:map['descricao'] as String,
      prioridadeId:map['prioridade_id'] as int,
      criadoEm:DateTime.parse(map['criadoEm'] as String),
      grupoResponsavelId:map['grupoResponsavel_id'] as int,
      
      done: (map['done'] as int) == 1,
    );
  }
}
