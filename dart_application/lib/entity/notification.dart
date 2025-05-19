// La classe `Notification` modélise une notification dans le système, utilisée pour envoyer des rappels (par exemple, J-2 ou J-1 pour les rotations).
class Notification {
  // contient le message ou la raison de la notification (par exemple, "Rappel J-2").
  String motif;
  // stocke la date et l'heure auxquelles la notification a été créée ou doit être envoyée.
  DateTime dateNotification;

  // Constructeur de la classe `Notification` avec paramètres nommés.
  Notification({required this.motif, required this.dateNotification});

  // Méthode pour sérialiser l'objet `Notification` en un format JSON.
  Map<String, dynamic> toJson() => {
    'motif': motif,
    'date_notification': dateNotification.toIso8601String(),
  };

  // Méthode pour désérialiser des données JSON en objet Dart.
  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    motif: json['motif'] as String,
    dateNotification: DateTime.parse(json['date_notification'] as String),
  );
}
