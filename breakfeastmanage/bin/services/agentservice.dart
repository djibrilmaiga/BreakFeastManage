

// methode pour faire l'authentification d'un agent
import 'dart:convert';
import 'dart:io';

import '../models/agent.dart';
String? authentification (Email, mot_de_passe){


// prendre les entrer de l'utilisateur
print("Veillez entrer votre Email:");
String? emailAgent = stdin.readLineSync();
print("Veiller saisir votre mot de passe:");
String? motDePasse = stdin.readLineSync();

// faire la lecture des informations de l'agent dans le fichier json
if (await file.exists()){
  final contenu = await file.readAsString();
  final Map <String, dynamic> dataJson = jsonDecode(contenu);

}

// boucle pour verifier si les entrer corresponde au contenu du json

for (Agent in contenu){
  if (emailAgent == Agent.email && motDePasse == Agent.mot_de_passe){
    print("Les informations fournies sont correctes!");
  }
  else{
    print("Echec! Veillez saisir un email et un mot de passe valide");
  }
}

// verifier si le status est actif ou non
if(Agent.status == "actif"){
  print("Bienvenue sur notre plateforme!");
}
else {
  print("Votre compte a été désactiver veillez contacter un administrateur !");
}
}
