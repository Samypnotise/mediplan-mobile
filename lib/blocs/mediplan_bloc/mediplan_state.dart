import 'package:mediplan/blocs/mediplan_bloc/mediplan_status.dart';
import 'package:mediplan/models/mission.dart';
import 'package:mediplan/models/mission_swap.dart';
import 'package:mediplan/models/user.dart';

class MediplanLoadingState {}

class MediplanState {
  final List<User>? caregivers;
  final List<Mission>? missions;
  final List<MissionSwap>? emittedMissionSwapDemands;
  final List<MissionSwap>? receivedMissionSwapDemands;
  final MediplanStatus mediplanStatus;

  MediplanState({
    this.caregivers = const [],
    this.missions = const [],
    this.emittedMissionSwapDemands = const [],
    this.receivedMissionSwapDemands = const [],
    this.mediplanStatus = const MediplanInitialStatus(),
  });

  MediplanState copyWith({
    List<User>? caregivers,
    List<Mission>? missions,
    List<MissionSwap>? emittedMissionSwapDemands,
    List<MissionSwap>? receivedMissionSwapDemands,
    MediplanStatus? mediplanStatus,
  }) {
    return MediplanState(
      caregivers: caregivers ?? this.caregivers,
      missions: missions ?? this.missions,
      emittedMissionSwapDemands:
          emittedMissionSwapDemands ?? this.emittedMissionSwapDemands,
      receivedMissionSwapDemands:
          receivedMissionSwapDemands ?? this.receivedMissionSwapDemands,
      mediplanStatus: mediplanStatus ?? this.mediplanStatus,
    );
  }
}
