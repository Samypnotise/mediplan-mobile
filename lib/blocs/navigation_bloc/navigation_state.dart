import 'package:mediplan/models/mission.dart';

abstract class NavigationState {}

class Home extends NavigationState {}

class Planning extends NavigationState {}

class CurrentMission extends NavigationState {
  final Mission currentMission;

  CurrentMission({required this.currentMission});
}

class Profile extends NavigationState {}

class MissionSwap extends NavigationState {}

class Settings extends NavigationState {}

class Help extends NavigationState {}
