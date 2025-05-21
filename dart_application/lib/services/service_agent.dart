import 'dart:io';
import '../entity/agent.dart';
import 'dart:convert';

class ServiceAgent {
  //inscription d'un agent
  static Future inscrireAgent() async {
    // recuperer le fichier json
    File file = File('agents.json');
    //creer un agent à partir des saisies clavier
    Agent? agent = setAgent();
    //verifier que l'agent n'est pas null
    if (agent != null) {
      //appel de la fonction ajouterAgent
      ajouterAgent(file, agent);
    } else {
      print(
        "Nous n'avons pas pu vous inscrire, veillez ressaisir les informations",
      );
      inscrireAgent();
    }
  }

  // creer un agent
  static Agent? setAgent() {
    print("Donner le nom de l'agent :");
    String? nomAgent = stdin.readLineSync();
    print("Donner le prénom de l'agent :");
    String? prenomAgent = stdin.readLineSync();
    print("Donner l'email de l'agent :");
    String? emailAgent = stdin.readLineSync();
    print("Donner le mot de passe de l'agent :");
    String? passwordAgent = stdin.readLineSync();
    if (nomAgent != null &&
        prenomAgent != null &&
        emailAgent != null &&
        passwordAgent != null &&
        nomAgent.isNotEmpty &&
        prenomAgent.isNotEmpty &&
        emailAgent.isNotEmpty &&
        passwordAgent.isNotEmpty) {
      return Agent(
        nom: nomAgent,
        prenom: prenomAgent,
        email: emailAgent,
        motDePasse: passwordAgent,
      );
    } else {
      print(" Erreur : tous les champs doivent être remplis !");
      //appeler en cas d'erreurs
      setAgent();
    }
    return null;
  }

  //Ajouter un ajout agent
  static ajouterAgent(File jsonFile, Agent agent) async {
    // verifier que le fichier existe
    if (await jsonFile.exists()) {
      final content = await jsonFile.readAsString();
      Map<String, dynamic> data = jsonDecode(content);
      // Recuperer la liste des agents
      List<dynamic> listAgents = data['agents'] ?? [];
      //on verifie l'agent n'est pas dans la liste d'agent
      if (agentExist(listAgents, agent.email)) {
        print('Un agent avec cet email existe');
      } else {
        listAgents.add(agent.toJson());
        data['agents'] = listAgents;
        // Sauvegarder
        await jsonFile.writeAsString(jsonEncode(data));
        print("✅ Agent ajouté avec succès !");
      }
    } else {
      print("Ce fichier n'existe pas");
    }
  }

  //desactiver un agent
  static desactiverAgent(File jsonFile, String email) async {
    if (await jsonFile.exists()) {
      final content = await jsonFile.readAsString();
      Map<String, dynamic> data = jsonDecode(content);
      // Recuperer la liste des agents
      List<dynamic> listAgents = data['agents'];
      //verifier que l'agent existe
      var agent = listAgents.firstWhere(
        (element) => element['email'] == email,
        orElse: () => null,
      );
      agent['estActif'] = false;
      print(agent['estActif']);
      data['agents'] = listAgents;
      jsonFile.writeAsString(jsonEncode(data));
      return agent;
    } else {
      print("fichier non existant");
    }
  }

  //activer un agent
  static activerAgent(File jsonFile, String email) async {
    if (await jsonFile.exists()) {
      final content = await jsonFile.readAsString();
      Map<String, dynamic> data = jsonDecode(content);
      // Recuperer la liste des agents
      List<dynamic> listAgents = data['agents'];
      //verifier que l'agent existe
      var agent = listAgents.firstWhere(
        (element) => element['email'] == email,
        orElse: () => null,
      );
      agent['estActif'] = true;
      data['agents'] = listAgents;
      jsonFile.writeAsString(jsonEncode(data));
      return agent;
    } else {
      print("fichier non existant");
    }
  }

  //verifie qu'un agent n'est pas dans la liste d'agent
  static agentExist(List<dynamic> listAgents, String email) {
    return listAgents.any((element) => element['email'] == email);
  }
}
