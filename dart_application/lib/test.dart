import 'package:dart_application/entity/agent.dart';
import 'package:dart_application/repository/dataManager.dart';

void main() async {
  Agent agent = Agent(
    nom: "Maiga",
    prenom: "Djibril",
    email: "dmbamako@gmail.com",
    motDePasse: "dmbamako",
  );
  print('Agent crée : ${agent.fullName}');
  List<Agent> agents = [];
  agents.add(agent);
  DataManager.saveAgents(agents);
}
