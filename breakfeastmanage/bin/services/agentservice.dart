import 'dart:convert';
import 'dart:io';

import '../models/agent.dart';

class Agentservice {
  // methode pour faire l'authentification d'un agent

  String? authentification (String Email, String mot_de_passe) async{
  File file = File("usersdata.json");

  // prendre les entrer de l'utilisateur
  print("Veillez entrer votre Email:");
  String? emailAgent = stdin.readLineSync();
  print("Veiller saisir votre mot de passe:");
  String? motDePasse = stdin.readLineSync();

  List <dynamic> agents = [];
  // faire la lecture des informations de l'agent dans le fichier json
  if (await file.exists()){
    final contenu = await file.readAsString();
    final Map <String, dynamic> dataJson = jsonDecode(contenu);
    agents = dataJson["agents"];

  }

  // boucle pour verifier si les entrer corresponde au contenu du json

  for (var agent in agents){
    if (emailAgent == agent["email"] && motDePasse == agent["mot_de_passe"] && agent["estActif"] == true){
      print("Les informations fournies sont correctes!");
    }
    else{
      print("Echec! Veillez saisir un email et un mot de passe valide");
    }
  }
    
  }
}
