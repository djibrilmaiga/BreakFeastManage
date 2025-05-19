// La classe `Jourferie` modélise un jour férié dans le système, utilisé pour décaler les rotations si nécessaire.
class Jourferie {
  // stocke la date de début du jour férié (par exemple, le 1er janvier 2025).
  DateTime jourDebut;
  // permet de gérer des périodes fériées qui peuvent s'étendre sur plusieurs jours (par exemple, un long week-end).
  DateTime jourFin;
  // `raison` contient la raison du jour férié (par exemple, "Nouvel An" ou "Fête du Travail").
  String raison;

  // Constructeur de la classe `Jourferie` avec paramètres nommés.
  Jourferie({
    required this.jourDebut,
    required this.jourFin,
    required this.raison,
  });

  // Méthode pour sérialiser l'objet `Jourferie` en un format JSON.
  Map<String, dynamic> toJson() => {
    'jour_debut': jourDebut.toIso8601String(),
    'jour_fin': jourFin.toIso8601String(),
    'raison': raison,
  };

  // Elle est utilisée pour désérialiser des données JSON en objet Dart.
  factory Jourferie.fromJson(Map<String, dynamic> json) => Jourferie(
    jourDebut: DateTime.parse(json['jour_debut'] as String),
    jourFin: DateTime.parse(json['jour_fin'] as String),
    raison: json['raison'] as String,
  );
}
