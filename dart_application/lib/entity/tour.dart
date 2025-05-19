import 'package:dart_application/entity/absence.dart';
import 'package:dart_application/entity/agent.dart';
import 'package:dart_application/entity/indisponibilite.dart';

// `PRESENT`, `ABSENT`, et `INDISPONIBLE` sont les états possibles d'un tour pour un agent.
enum Statut { PRESENT, ABSENT, INDISPONIBLE }

// La classe `Tour` modélise une rotation ou un tour dans le système, où un agent est désigné pour offrir le petit-déjeuner.
class Tour {
  Agent
  agentDesigne; // est l'agent responsable de ce tour (offrir le petit-déjeuner).
  DateTime
  datePrevue; // stocke la date prévue pour ce tour (par exemple, un vendredi spécifique).
  Statut
  statut; // indique l'état de l'agent pour ce tour (présent, absent, ou indisponible).
  Indisponibilite
  indisponibilite; // stocke les détails de l'indisponibilité associée à ce tour (si applicable).
  Absence
  absence; // stocke les détails de l'absence associée à ce tour (si applicable).

  // Constructeur de la classe `Tour` avec paramètres nommés.
  Tour({
    required this.agentDesigne,
    required this.datePrevue,
    required this.statut,
    required this.indisponibilite,
    required this.absence,
  });

  // Méthode pour sérialiser l'objet `Tour` en un format JSON.
  Map<String, dynamic> toJson() => {
    // `agentDesigne.toJson()` appelle la méthode `toJson` de la classe `Agent` pour sérialiser l'agent désigné.
    'agent_designe': agentDesigne.toJson(),
    'date_prevue': datePrevue.toIso8601String(),
    'statut': statut.toString().split('.').last,
    'indisponibilite': indisponibilite.toJson(),
    'absence': absence.toJson(),
  };

  // Méthode pour désérialiser des données JSON en objet Dart.
  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
    agentDesigne: Agent.fromJson(json['agent_designe']),
    datePrevue: DateTime.parse(json['date_prevue'] as String),
    // `Statut.values` est une liste contenant toutes les valeurs possibles de l'énum `Statut`.
    // `firstWhere` trouve la première valeur de l'énum dont la représentation sous forme de chaîne correspond à la valeur JSON.
    statut: Statut.values.firstWhere(
      (e) => e.toString().split('.').last == json['statut'],
    ),
    indisponibilite: Indisponibilite.fromJson(json['indisponibilite']),
    absence: Absence.fromJson(json['absence']),
  );
}
