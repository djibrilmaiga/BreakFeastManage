import 'package:dart_application/entity/agent.dart';

// La classe `Admin` est une sous-classe (ou classe dérivée) de la classe `Agent`.
// `extends` indique qu'`Admin` hérite des propriétés et méthodes de `Agent`.
class Admin extends Agent {
  // Constructeur de la classe `Admin`.
  Admin({
    required super.nom,
    required super.prenom,
    required super.email,
    required super.motDePasse,
  }); // Appelle le constructeur de la classe parente (`Agent`) avec les mêmes paramètres.
}
