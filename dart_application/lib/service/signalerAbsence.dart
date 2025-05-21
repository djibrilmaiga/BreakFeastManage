import 'package:dart_application/entity/absence.dart';
import 'package:dart_application/entity/rotation.dart';
import 'package:dart_application/entity/tour.dart';
import 'package:dart_application/repository/dataManager.dart';

class Signalerabsence {

  Rotation? rotation;
  List<Tour> tours = [];

   // Constructeur de la classe
  // Appelle la méthode privée `_initialize` pour charger les données initiales.
  // ignore: non_constant_identifier_names
  Servicemanager() {
    _initialize();
  }

  // Méthode privée pour initialiser les données au démarrage.
  Future<void> _initialize() async {
    // Charge la rotation active depuis le fichier JSON via `DataManager`.
    rotation = await DataManager.loadRotation();
    // Charge l'historique des tours depuis le fichier JSON.
    tours = await DataManager.loadTours();
    // Si aucune rotation n'existe (`rotation` est `null`), en créer une nouvelle.
    rotation ??= Rotation(agentCourant: 0, jourParametrable: 5);
  }

  // Nouvelle méthode pour marquer un agent comme absent par l'admin
  Future<void> markAgentAsAbsent(String agentName, DateTime tourDate, String reason) async {
    if (rotation == null) {
      print('❌ Erreur : La rotation n\'est pas encore initialisée.');
      return;
    }

    // Trouver l'agent correspondant
    final agent = Rotation.agents.firstWhere(
      (a) => a.fullName == agentName,
      orElse: () => throw Exception('Agent non trouvé'),
    );

    // Vérifier si la date du tour est aujourd'hui ou dans le passé
    DateTime now = DateTime.now();
    if (tourDate.isAfter(now)) {
      print('Erreur : Vous ne pouvez marquer un agent comme absent que pour un tour passé ou aujourd\'hui.');
      return;
    }

    // Créer un objet Absence avec la date actuelle et le motif saisi par l'admin
    final absence = Absence(declareLe: now, motif: reason);

    // Créer un objet Tour avec le statut ABSENT
    final tour = Tour(
      agentDesigne: agent,
      datePrevue: tourDate,
      statut: Statut.ABSENT, // Statut ABSENT
      absence: absence,
      indisponibilite: null, // Pas d'indisponibilité, car l'agent n'a pas signalé
    );
    tours.add(tour);

    // Si l'agent absent est le prochain dans la rotation, ajuster la rotation
    if (Rotation.agents[rotation!.agentCourant].fullName == agentName) {
      Rotation.agents.removeAt(rotation!.agentCourant);
      Rotation.agents.add(agent);
      rotation!.agentCourant = rotation!.agentCourant % Rotation.agents.length;
      print('Tour reporté à ${Rotation.agents[rotation!.agentCourant].fullName}.');
    }

    // Sauvegarder les données
    await DataManager.saveAgents(Rotation.agents);
    await DataManager.saveRotation(rotation!);
    await DataManager.saveTours(tours);
    print('✅ Agent ${agent.fullName} marqué comme absent pour le ${tourDate.toString().substring(0, 10)}.');
  }
}