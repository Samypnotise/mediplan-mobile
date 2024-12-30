abstract class MissionSwapEvent {}

class InitMissionSwapDemand extends MissionSwapEvent {}

class ReceiverIdChanged extends MissionSwapEvent {
  final String receiverId;

  ReceiverIdChanged({required this.receiverId});
}

class MissionIdChanged extends MissionSwapEvent {
  final String missionId;

  MissionIdChanged({required this.missionId});
}

class DemandStatusChanged extends MissionSwapEvent {
  final String demandStatus;

  DemandStatusChanged({required this.demandStatus});
}

class MissionSwapDemandCreated extends MissionSwapEvent {}

class MissionSwapDemandUpdated extends MissionSwapEvent {
  final String missionSwapDemandId;

  MissionSwapDemandUpdated({required this.missionSwapDemandId});
}

class TriggerMissionSwapDemandReset extends MissionSwapEvent {}
