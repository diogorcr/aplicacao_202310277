class Prioridade {
  final int? id;
  final String title;
  

  Prioridade({this.id, required this.title,  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'titulo': title, };
  }

  factory Prioridade.fromMap(Map<String, dynamic> map) {
    return Prioridade(
      id: map['id'] as int?,
     title: map['titulo'] as String,
     
    );
  }
}