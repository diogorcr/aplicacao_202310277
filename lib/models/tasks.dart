class Task {
  final int? id;
  final String title;
  final String descricao;
  final int prioridade_id;
  final DateTime criadoEm;
  final int grupoResponsavel_id;
  final bool done;

  Task({this.id, required this.title,
  required this.descricao,required this.prioridade_id,required this.criadoEm,
  required this.grupoResponsavel_id,
   this.done = false});

  Map<String, dynamic> toMap() {
    return {'id': id, 'titulo': title,'descricao':descricao,'prioridade_Id':prioridade_id,
    'criadoEm':criadoEm, 
    'grupoReponsavelId':grupoResponsavel_id,  'done': done ? 1 : 0};
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,title: map['titulo'] as String,
      descricao:map['descricao'] as String,
      prioridade_id:map['prioridade_id'] as int,
      criadoEm:DateTime.parse(map['criadoEm'] as String),
      grupoResponsavel_id:map['grupoResponsavel_id'] as int,
      
      done: (map['done'] as int) == 1,
    );
  }
}
