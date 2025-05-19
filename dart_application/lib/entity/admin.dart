import 'package:dart_application/entity/agent.dart';

// La classe `Admin` est une sous-classe (ou classe dérivée) de la classe `Agent`.
// `extends` indique qu'`Admin` hérite des propriétés et méthodes de `Agent`.
class Admin extends Agent {
  // Constructeur de la classe `Admin`.
  Admin({
    required String
    nom, // Le nom de famille de l'administrateur, hérité de `Agent`.
    required String prenom,
    required String email,
    required String motDePasse,
  }) : super(
         nom: nom,
         prenom: prenom,
         email: email,
         motDePasse: motDePasse,
       ); // Appelle le constructeur de la classe parente (`Agent`) avec les mêmes paramètres.
}
