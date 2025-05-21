import 'dart:convert';
import 'dart:io';
import 'package:dart_application/services/service_agent.dart';
import 'package:dart_application/entity/agent.dart';
import 'package:test/test.dart';

void main() {
  late File file;
  late Agent agent1;
  late Agent agent2;
  //fonction pour partager des données avant le test
  setUp(() async {
    //charger le fichier
    // recuperer le fichier json
    file = File('test/testfile.json');
    file.writeAsString(jsonEncode({"agents": []}));
    agent1 = Agent(
      nom: 'Amadou',
      prenom: 'Diallo',
      email: 'jimlecracken13@gmail.com',
      motDePasse: 'jevaispasapplaudir',
    );
    agent2 = Agent(
      nom: "hamza",
      prenom: 'sanmo',
      email: 'sanmo23@gmail.com',
      motDePasse: 'blablacarrs',
    );
  });
  // tearDown(() async {
  //   // Supprime le fichier après chaque test
  //   if (await file.exists()) {
  //     await file.writeAsString('');
  //   }
  // });
  test('ajouterAgent', () async {
    await ServiceAgent.ajouterAgent(file, agent1); //
    await ServiceAgent.ajouterAgent(file, agent2);

    final content = await file.readAsString();
    final data = jsonDecode(content);

    expect(data['agents'], isA<List>());
    expect(data['agents'].length, equals(2));
    expect(data['agents'][0]['email'], equals(agent1.email));
  });
  test('agentExist', () async {
    await ServiceAgent.ajouterAgent(file, agent1);
    final content = await file.readAsString();
    final data = jsonDecode(content);
    //on recupère la liste des elements
    var list = data['agents'];
    expect(
      ServiceAgent.agentExist(list, 'jimlecracken13@gmail.com'),
      equals(true),
    );
    expect(
      ServiceAgent.agentExist(list, 'monemail30@gmail.com'),
      equals(false),
    );
  });

  //test pour activerAgent
  test('activerAgent', () async {
    await ServiceAgent.ajouterAgent(file, agent1);
    var agen = await ServiceAgent.activerAgent(
      file,
      'jimlecracken13@gmail.com',
    );
    expect(agen['estActif'] == true, equals(true));
    expect(agen['estActif'] != false, equals(true));
  });

  //test pour desactiverAgent
  test('desactiverAgent', () async {
    await ServiceAgent.ajouterAgent(file, agent1);
    var agen = await ServiceAgent.desactiverAgent(
      file,
      'jimlecracken13@gmail.com',
    );
    print(agen['estActif']);
    expect(agen['estActif'] == false, equals(true));
    expect(agen['estActif'] != false, equals(false));
  });
}
