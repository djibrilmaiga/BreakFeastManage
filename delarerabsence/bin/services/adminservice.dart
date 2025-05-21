import 'dart:convert';
import 'dart:io';
class ServiceAdmin{
  // declaration de l'abscence d'un agent
  static declarerAbscence() async{
    File fichier = File('fichier.json');
  //condition pour verifier si le fichier existe
    if(await fichier.exists()){
      String contenuJson = fichier.readAsStringSync();
      Map <String, dynamic> dataFichier = jsonDecode(contenuJson);
      List <dynamic> listAgents = dataFichier['agents'];
  //j'affiche la liste des agents 
      print('Voici la liste des agents : ');
      for (var agent in listAgents){
        print("nom : $agent['nom'], Email : $agent['email']");
      }
  // l'admin entre l'email de l'agent à declarer abscent
      print("entrer l'email de l'agent que vous voulez declarer comme abscent :");
      String? emailAgent = stdin.readLineSync();
  // je verifi si l'email existe ou pas 
      bool emailExiste = listAgents.any((u) => u['email'] == emailAgent );
      if(emailAgent == null || emailAgent.isEmpty){
      print("aucune donnée entree");
      return;
      }
      else if(emailExiste == true){
        print("entrer la date de l'abscence de l'agent au format AAAA-MM-JJ");
    // je verifi si date est correct
        String? dateEntree = stdin.readLineSync();
        try{
          DateTime date = DateTime.parse(dateEntree!);
          DateTime maintenant = DateTime.now();
    //je verifi si la date existe dans le json
          String dateFormatee = date.toIso8601String();
          List<dynamic> listRotations = dataFichier['rotations'];
          bool dateExiste = listRotations.any((o) => o['date'] == dateFormatee);
          if(date.isAfter(maintenant) || dateExiste == false){
              print("la date n'est pas une date de tour de passage ou la date est superiur à today");
          }
          if(dateExiste == true){
            
            print("Entrer le motif de l'abscence :");
            String? motif = stdin.readLineSync();
            List<dynamic> listAbscences = dataFichier['absences'] ?? [];

          // je Crée l'objet nouvelle absence pour creer une nouvelle absence  
            Map<String, dynamic> nouvelleAbscence = {
              "agent" :{
                "email" : emailAgent,
              },
              "date" : dateFormatee,
              "motif": motif
            };
            listAbscences.add(nouvelleAbscence);
            dataFichier['absences'] = listAbscences;

            //écriture dans le fichier json
            await fichier.writeAsString(JsonEncoder.withIndent(' ').convert(dataFichier));

            
          }
      // je verifi que la date correspond à un tour de passage passée
        }catch(e){
          print("format de la date invalide réessayez");
        }
      }
      else{
        print("L'adresse email n'existe pas");
      }

    }
    else{
      print('Le fichier est introuvable');
    }
  }
  File fichier = File("fichier.json");
}