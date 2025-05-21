import 'package:dart_application/entity/absence.dart';
import 'package:dart_application/entity/agent.dart';
import 'package:dart_application/entity/indisponibilite.dart';
import 'package:dart_application/entity/jourFerie.dart';
import 'package:dart_application/entity/rotation.dart';
import 'package:dart_application/entity/tour.dart';
import 'package:dart_application/repository/dataManager.dart';

class Planningrotation {

  Rotation? rotation;
  List<Tour> tours = [];
  List<Jourferie> holidays = [];

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
    // // Charge les jours fériés depuis le fichier JSON.
    holidays = await DataManager.loadHolidays();
    // // Charge l'historique des tours depuis le fichier JSON.
    tours = await DataManager.loadTours();
    // // Charge les notifications depuis le fichier JSON.
    // notifications = await DataManager.loadNotifications();

    // Si aucune rotation n'existe (`rotation` est `null`), en créer une nouvelle.
    rotation ??= Rotation(agentCourant: 0, jourParametrable: 5);
  }

  // Méthode pour afficher les 4 prochaines rotations.
  Future<void> showNextRotations() async {
    // Vérifie si la liste des agents est vide.
    if (rotation!.tours.isEmpty) {
      print('Aucun agent dans la liste.');
      return;
    }

    print('\nProchaines rotations :');
    // `DateTime.now()` utilise la date actuelle (2025-05-13) comme point de départ.
    DateTime currentDate = DateTime.now();
    // `tempIndex` est une copie de l'index courant pour éviter de modifier `rotation.agentCourant`.
    int tempIndex = rotation!.agentCourant;

    // Boucle pour afficher les 4 prochaines rotations.
    for (int i = 0; i < 4; i++) {
      // Avance la date jusqu'à ce qu'elle corresponde au jour de rotation (ex. vendredi) et ne soit pas fériée.
      while (currentDate.weekday != rotation!.jourParametrable ||
          isHoliday(currentDate)) {
        currentDate = currentDate.add(Duration(days: 1));
      }

      // Récupère l'agent correspondant à l'index temporaire.
      Agent agent = Rotation.agents[tempIndex];
      // Affiche la date et le nom de l'agent pour cette rotation.
      print(
        'Rotation ${i + 1}: ${currentDate.toString().substring(0, 10)} - ${agent.fullName}',
      );

      // // Simule l'envoi de rappels à J-2 et J-1.
      // sendReminder(agent.fullName, currentDate, 'J-2');
      // sendReminder(agent.fullName, currentDate, 'J-1');

      // Incrémente l'index temporaire avec un modulo pour revenir au début si nécessaire.
      tempIndex = (tempIndex + 1) % Rotation.agents.length;
      // Trouve la prochaine date de rotation valide.
      currentDate = getNextRotationDate(currentDate);
    }

    // // Sauvegarde les notifications simulées dans le fichier JSON.
    // await DataManager.saveNotifications(notifications);
  }

// Méthode pour vérifier si une date donnée est un jour férié.
  bool isHoliday(DateTime date) {
    // Vérifie si `date` se trouve dans la plage d'un jour férié (entre `jourDebut` et `jourFin`).
    // `subtract(Duration(days: 1))` et `add(Duration(days: 1))` élargissent légèrement la plage pour inclure les jours adjacents.
    return holidays.any(
      (holiday) =>
          date.isAfter(holiday.jourDebut.subtract(Duration(days: 1))) &&
          date.isBefore(holiday.jourFin.add(Duration(days: 1))),
    );
  }

 // Méthode pour trouver la prochaine date de rotation (par exemple, le prochain vendredi).
  DateTime getNextRotationDate(DateTime startDate) {
    // `nextDate` est une variable qui sera incrémentée pour trouver la prochaine date valide.
    DateTime nextDate = startDate;
    // Boucle `do-while` pour s'assurer que la date finale n'est pas un jour férié.
    do {
      // Incrémente la date de 1 jour.
      nextDate = nextDate.add(Duration(days: 1));
      // Boucle `while` pour avancer jusqu'à ce que le jour soit celui de la rotation (ex. vendredi) et non férié.
      while (nextDate.weekday != rotation!.jourParametrable ||
          isHoliday(nextDate)) {
        nextDate = nextDate.add(Duration(days: 1));
      }
    } while (isHoliday(nextDate));
    // Retourne la prochaine date de rotation valide.
    return nextDate;
  }

Future<void> declareIndisponibilite(String agentName, DateTime date, String reason) async {
    if (rotation == null) {
      print('❌ Erreur : La rotation n\'est pas encore initialisée.');
      return;
    }
    final agent = Rotation.agents.firstWhere(
      (a) => a.fullName == agentName,
      orElse: () => throw Exception('Agent non trouvé'),
    );

    DateTime now = DateTime.now();
    if (date.difference(now).inDays < 2) {
      print('Erreur : L\'indisponibilité doit être déclarée au moins 2 jours avant.');
      return;
    }

    final absence = Absence(declareLe: now, motif: reason);
    final indisponibilite = Indisponibilite(declareLe: now, motif: reason);

    final tour = Tour(
      agentDesigne: agent,
      datePrevue: date,
      statut: Statut.INDISPONIBLE,
      indisponibilite: indisponibilite,
      absence: absence,
    );
    tours.add(tour);

    if (Rotation.agents[rotation!.agentCourant].fullName == agentName) {
      Rotation.agents.removeAt(rotation!.agentCourant);
      Rotation.agents.add(agent);
      rotation!.agentCourant = rotation!.agentCourant % Rotation.agents.length;
      print('Tour reporté à ${Rotation.agents[rotation!.agentCourant].fullName}.');
    }

    await DataManager.saveAgents(Rotation.agents);
    await DataManager.saveRotation(rotation!);
    await DataManager.saveTours(tours);
  }
}