class Indisponibilite {
  // stocke la date et l'heure à laquelle l'indisponibilité a été déclarée.
  DateTime declareLe;
  // `motif` contient la raison de l'indisponibilité (par exemple, "Vacances" ou "Maladie").
  String motif;

  // Constructeur de la classe `Indisponibilite` avec paramètres nommés.
  Indisponibilite({required this.declareLe, required this.motif});

  // Méthode pour sérialiser l'objet `Indisponibilite` en un format JSON.
  Map<String, dynamic> toJson() => {
    'declare_le': declareLe.toIso8601String(),
    'motif': motif,
  };

  // Elle est utilisée pour désérialiser des données JSON en objet Dart.
  factory Indisponibilite.fromJson(Map<String, dynamic> json) =>
      Indisponibilite(
        // `DateTime.parse` convertit une chaîne ISO 8601 en objet `DateTime`.
        declareLe: DateTime.parse(json['declare_le'] as String),
        // `as String` cast la valeur dynamique en `String` pour `motif`.
        motif: json['motif'] as String,
      );
}
