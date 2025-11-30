class Grupo {
  final int? id;
  final String title;
  

  Grupo({this.id, required this.title,  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'titulo': title, };
  }

  factory Grupo.fromMap(Map<String, dynamic> map) {
    return Grupo(
      id: map['id'] as int?,
     title: map['titulo'] as String,
     
    );
  }
}
