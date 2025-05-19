class Absence {
  // `declareLe` stocke la date et l'heure à laquelle l'absence a été déclarée.
  DateTime declareLe;
  // `motif` contient la raison de l'absence (par exemple, "Maladie" ou "Congé").
  String motif;

  // Constructeur de la classe `Absence` avec paramètres nommés.
  Absence({required this.declareLe, required this.motif});

  // Méthode pour sérialiser l'objet `Absence` en un format JSON.
  Map<String, dynamic> toJson() => {
    'declare_le': declareLe.toIso8601String(),
    'motif': motif,
  };

  // Elle est utilisée pour désérialiser des données JSON en objet Dart.
  factory Absence.fromJson(Map<String, dynamic> json) => Absence(
    // `DateTime.parse` convertit une chaîne ISO 8601 en objet `DateTime`.
    declareLe: DateTime.parse(json['declare_le'] as String),
    // `as String` cast la valeur dynamique en `String` pour `motif`.
    motif: json['motif'] as String,
  );
}
