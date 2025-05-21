import 'dart:convert';
import 'dart:io';

import 'package:breakfeastmanage/breakfeastmanage.dart';
import 'package:test/test.dart';

import '../bin/models/agent.dart';
import '../bin/services/agentservice.dart';

void main() {
  
  late File file;
  late Agent agent;
  setUp(()async{
    file = File('agents.json');
    agent = Agent(
      nom: "Traoré",
      prenom: "Awa",
      email: "awa.traore@example.com",
      motDePasse: "motdepasse2",
    );
  });
  test('test se connecter', () async
  {
    //expect connection reussie
    var resultat  = await AgentService.authentification(agent.email, agent.motDePasse);
    //expect connection echouée
    var result = await AgentService.authentification(agent.email,"blblafdsjdkfjjkjskfjk");
    
    expect(resultat, equals(true));

  });
}
