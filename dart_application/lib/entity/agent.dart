// La classe `Agent` représente une entité qui modélise un agent dans le système.
class Agent {
  // Déclaration des propriétés de la classe avec leurs types.
  String nom; // Le nom de famille de l'agent.
  String prenom; // Le prénom de l'agent.
  String email; // L'adresse email de l'agent, utilisée pour l'authentification.
  String
  motDePasse; // Le mot de passe de l'agent, stocké en clair (non recommandé en production).
  // `estActif` indique si l'agent est actif dans le système (par défaut : true).
  bool estActif = true;
  // `isAdmin` indique si l'agent a des privilèges d'administrateur (par défaut : false).
  bool isAdmin = false;

  // `static` signifie que cette propriété appartient à la classe elle-même, et non à une instance.
  // `AgentList` est une liste statique qui contient tous les agents créés dans l'application.
  static List<Agent> AgentList = [];

  Agent({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
  });

  // `fullName` est une propriété calculée qui retourne le prénom et le nom concaténés.
  String get fullName => '$prenom $nom';

  // Méthode pour sérialiser l'objet `Agent` en un format JSON.
  // `Map<String, dynamic>` est une structure clé-valeur où les clés sont des chaînes et les valeurs peuvent être de n'importe quel type.
  Map<String, dynamic> toJson() => {
    'nom': nom,
    'prenom': prenom,
    'email': email,
    'mot_de_passe': motDePasse,
    'estActif': estActif,
    'estAdmin': isAdmin,
  };

  // `factory` est un mot-clé qui définit une méthode de construction spéciale.
  // `Agent.fromJson` est une méthode statique qui crée un objet `Agent` à partir d'un `Map` JSON.
  // Elle est utilisée pour désérialiser les données lues à partir d'un fichier JSON.
  factory Agent.fromJson(Map<String, dynamic> json) {
    final agent = Agent(
      // `as String` est un cast qui convertit la valeur dynamique en `String`.
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      email: json['email'] as String,
      motDePasse: json['mot_de_passe'] as String,
    );
    // `as bool?` cast la valeur en booléen nullable.
    // `??` est l'opérateur de coalescence nulle : si la valeur est `null`, utilise la valeur par défaut (true ou false).
    agent.estActif = json['estActif'] as bool? ?? true;
    agent.isAdmin = json['estAdmin'] as bool? ?? false;
    return agent;
  }
}
