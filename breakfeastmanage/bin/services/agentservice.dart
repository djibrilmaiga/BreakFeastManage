import 'dart:convert';
import 'dart:io';

class AgentService {
  // methode pour faire l'authentification d'un agent

  static authentification () async{

  File file = File("agents.json");
  // prendre les entrer de l'utilisateur
  print("Veillez entrer votre Email:");
  String? emailAgent = stdin.readLineSync();
  print("Veiller saisir votre mot de passe:");
  String? motDePasse = stdin.readLineSync();
  List <dynamic> agents = [];
  // faire la lecture des informations de l'agent dans le fichier json
  if (await file.exists())
  {
    final contenu = await file.readAsString();
    Map<String, dynamic> dataJson = jsonDecode(contenu);
    agents = dataJson["agents"];
    // boucle pour verifier si les entrer corresponde au contenu du json
    bool exist = false;
    for (var agent in agents)
    {
      if ((emailAgent == agent["email"]) && (motDePasse == agent["mot_de_passe"]) && (agent["estActif"] == true))
      {
        exist = true;
        break; 
      }
    }
    if(exist)
    {
      print('Connection reussie');
    }
    else
    {
      print("Connection echouée");
    }
    return exist;
    
  }
  else{
    print("le fichier n'existe pas");
  }
  
  }
}
