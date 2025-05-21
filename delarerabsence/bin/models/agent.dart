class Agent {
  //class constructor
  String nom;
  String prenom;
  String email;
  String motDePasse;
  bool estActif = true;
  bool estAdmin = false;
  Agent({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
  });

  //convertir en json
  Map<String, dynamic> enJson() => {
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'mot_de_passe': motDePasse,
        'estActif': estActif,
        'estAdmin': estAdmin,
      };

  //convertir en objet
  factory Agent.fromJson(Map<String, dynamic> json) {
    final agent = Agent(
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      email: json['email'] as String,
      motDePasse: json['mot_de_passe'] as String,
    );
    if (json['estActif'] != null) {
      agent.estActif = json['estActif'] as bool;
    }
    if (json['estAdmin'] != null) {
      agent.estAdmin = json['estAdmin'] as bool;
    }
    return agent;
  }
}
