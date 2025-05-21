import 'dart:convert';
import 'dart:io';

import 'package:dart_application/entity/agent.dart';
import 'package:dart_application/entity/jourFerie.dart';
import 'package:dart_application/entity/notification.dart';
import 'package:dart_application/entity/rotation.dart';
import 'package:dart_application/entity/tour.dart';

// La classe `DataManager` est une classe utilitaire pour gérer la persistance des données dans des fichiers JSON.
class DataManager {
  // Ces constantes définissent les chemins/noms des fichiers JSON où les données seront stockées.
  static const String agentsFile = 'lib/repository/agents.json'; // Fichier pour les agents.
  static const String rotationsFile =
      'lib/repository/rotations.json'; // Fichier pour les rotations.
  static const String jourFeriesFile =
      'lib/repository/jourFeries.json'; // Fichier pour les jours fériés.
  static const String toursFile = 'lib/repository/tours.json'; // Fichier pour les tours.
  static const String notificationsFile =
      'lib/repository/notifications.json'; // Fichier pour les notifications.

  // Méthode statique pour sauvegarder une liste de données dans un fichier JSON.
  static Future<void> saveToFile(
    String filePath, // Chemin ou nom du fichier où sauvegarder les données.
    List<Map<String, dynamic>>
    data, // Liste de données sous forme de `Map` JSON.
  ) async {
    // `try` et `catch` sont utilisés pour gérer les exceptions et éviter que le programme ne plante.
    try {
      // `File` est une classe de `dart:io` qui représente un fichier sur le système de fichiers.
      final file = File(filePath);
      // `writeAsString` écrit une chaîne dans le fichier de manière asynchrone.
      // `jsonEncode` (de `dart:convert`) convertit la liste de `Map` en une chaîne JSON.
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      // Si une erreur survient (par exemple, fichier inaccessible), elle est capturée et affichée.
      print('Erreur lors de la sauvegarde dans $filePath : $e');
    }
  }

  // Méthode statique pour charger une liste de données à partir d'un fichier JSON.
  static Future<List<Map<String, dynamic>>> loadFromFile(
    String filePath, // Chemin ou nom du fichier à charger.
  ) async {
    try {
      // Crée un objet `File` pour le fichier spécifié.
      final file = File(filePath);
      // `exists()` vérifie si le fichier existe de manière asynchrone.
      if (await file.exists()) {
        // `readAsString` lit le contenu du fichier sous forme de chaîne de manière asynchrone.
        final content = await file.readAsString();
        // `jsonDecode` (de `dart:convert`) convertit la chaîne JSON en une structure de données Dart.
        // `List<Map<String, dynamic>>.from` convertit la structure décodée en une liste de `Map`.
        return List<Map<String, dynamic>>.from(jsonDecode(content));
      }
    } catch (e) {
      // Si une erreur survient (par exemple, fichier corrompu), elle est capturée et affichée.
      print('Erreur lors du chargement de $filePath : $e');
    }
    // Retourne une liste vide si le fichier n'existe pas ou si une erreur survient.
    return [];
  }

  // Méthode statique pour sauvegarder une liste d'agents dans un fichier JSON.
  static Future<void> saveAgents(List<Agent> agents) async {
    // `map` transforme chaque objet `Agent` en son équivalent JSON avec `toJson`.
    final data = agents.map((agent) => agent.toJson()).toList();
    // Appelle `saveToFile` pour écrire les données dans le fichier `agents.json`.
    await saveToFile(agentsFile, data);
  }

  // Méthode statique pour charger une liste d'agents à partir d'un fichier JSON.
  static Future<List<Agent>> loadAgents() async {
    // Charge les données JSON depuis le fichier `agents.json`.
    final data = await loadFromFile(agentsFile);
    return data.map((json) => Agent.fromJson(json)).toList();
  }

  // Méthode statique pour sauvegarder une rotation dans un fichier JSON.
  static Future<void> saveRotation(Rotation rotation) async {
    // La liste contient un seul élément car il n'y a qu'une rotation à sauvegarder.
    await saveToFile(rotationsFile, [rotation.toJson()]);
  }

  // Méthode statique pour charger une rotation à partir d'un fichier JSON.
  static Future<Rotation?> loadRotation() async {
    // Charge les données JSON depuis le fichier `rotations.json`.
    final data = await loadFromFile(rotationsFile);
    // Vérifie si la liste n'est pas vide.
    if (data.isNotEmpty) {
      // `data.first` prend le premier (et seul) élément de la liste et le convertit en `Rotation`.
      return Rotation.fromJson(data.first);
    }
    // Retourne `null` si aucune donnée n'est trouvée.
    return null;
  }

  // Méthode statique pour sauvegarder une liste de jours fériés dans un fichier JSON.
  static Future<void> saveHolidays(List<Jourferie> holidays) async {
    // `map` transforme chaque objet `Jourferie` en son équivalent JSON avec `toJson`.
    final data = holidays.map((holiday) => holiday.toJson()).toList();
    // Appelle `saveToFile` pour écrire les données dans le fichier `jourFeries.json`.
    await saveToFile(jourFeriesFile, data);
  }

  // Méthode statique pour charger une liste de jours fériés à partir d'un fichier JSON.
  static Future<List<Jourferie>> loadHolidays() async {
    // Charge les données JSON depuis le fichier `jourFeries.json`.
    final data = await loadFromFile(jourFeriesFile);
    // `map` convertit chaque `Map` JSON en un objet `Jourferie` en utilisant `fromJson`.
    return data.map((json) => Jourferie.fromJson(json)).toList();
  }

  // Méthode statique pour sauvegarder une liste de tours dans un fichier JSON.
  static Future<void> saveTours(List<Tour> tours) async {
    // `map` transforme chaque objet `Tour` en son équivalent JSON avec `toJson`.
    final data = tours.map((tour) => tour.toJson()).toList();
    // Appelle `saveToFile` pour écrire les données dans le fichier `tours.json`.
    await saveToFile(toursFile, data);
  }

  // Méthode statique pour charger une liste de tours à partir d'un fichier JSON.
  static Future<List<Tour>> loadTours() async {
    // Charge les données JSON depuis le fichier `tours.json`.
    final data = await loadFromFile(toursFile);
    // `map` convertit chaque `Map` JSON en un objet `Tour` en utilisant `fromJson`.
    return data.map((json) => Tour.fromJson(json)).toList();
  }

  // Méthode statique pour sauvegarder une liste de notifications dans un fichier JSON.
  static Future<void> saveNotifications(
    List<Notification> notifications, // Liste des notifications à sauvegarder.
  ) async {
    // `map` transforme chaque objet `Notification` en son équivalent JSON avec `toJson`.
    final data = notifications.map((notif) => notif.toJson()).toList();
    // Appelle `saveToFile` pour écrire les données dans le fichier `notifications.json`.
    await saveToFile(notificationsFile, data);
  }

  // Méthode statique pour charger une liste de notifications à partir d'un fichier JSON.
  static Future<List<Notification>> loadNotifications() async {
    // Charge les données JSON depuis le fichier `notifications.json`.
    final data = await loadFromFile(notificationsFile);
    // `map` convertit chaque `Map` JSON en un objet `Notification` en utilisant `fromJson`.
    return data.map((json) => Notification.fromJson(json)).toList();
  }
}
