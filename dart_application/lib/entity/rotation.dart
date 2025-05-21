import 'package:dart_application/entity/jourFerie.dart';
import 'package:dart_application/entity/tour.dart';

// La classe `Rotation` modélise la gestion des rotations des agents pour offrir le petit-déjeuner.
class Rotation {
  // stocke l'index de l'agent actuellement désigné dans la liste `agents`.
  int agentCourant;
  // définit le jour hebdomadaire où les rotations ont lieu.
  int jourParametrable;
  // compte le nombre de cycles complets de rotation (incrémenté quand on revient au premier agent).
  static int nbreCycle = 0;
  // `jours` contient la liste des jours fériés à prendre en compte pour décaler les rotations.
  List<Jourferie> jours = [];
  // `tours` contient l'historique ou la planification des tours effectués ou prévus.
  List<Tour> tours = [];

  // Constructeur de la classe `Rotation` avec paramètres nommés.
  Rotation({required this.agentCourant, required this.jourParametrable});

  // Méthode pour sérialiser l'objet `Rotation` en un format JSON.
  Map<String, dynamic> toJson() => {
    'index_agent_courant': agentCourant,
    'nbre_cycle': nbreCycle,
    'jours': jours.map((jour) => jour.toJson()).toList(),
    'tours': tours.map((tour) => tour.toJson()).toList(),
  };

  // Méthode pour désérialiser des données JSON en objet Dart.
  factory Rotation.fromJson(Map<String, dynamic> json) {
    final rotation = Rotation(
      agentCourant: json['index_agent_courant'] as int,
      jourParametrable: json['jour_rotation'] as int,
    );
    nbreCycle = json['nbre_cycle'] as int;
    rotation.jours =
        (json['jours'] as List)
            .map((jourJson) => Jourferie.fromJson(jourJson))
            .toList();
    rotation.tours =
        (json['tours'] as List)
            .map((tourJson) => Tour.fromJson(tourJson))
            .toList();
    return rotation;
  }
}
