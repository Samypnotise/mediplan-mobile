import 'package:mediplan/blocs/mediplan_bloc/mediplan_status.dart';
import 'package:mediplan/models/mission.dart';
import 'package:mediplan/models/user.dart';

class MediplanLoadingState {}

class MediplanState {
  final List<User>? caregivers;
  final List<Mission>? missions;
  final MediplanStatus mediplanStatus;

  MediplanState({
    this.caregivers = const [],
    this.missions = const [],
    this.mediplanStatus = const MediplanInitialStatus(),
  });

  MediplanState copyWith({
    List<User>? caregivers,
    List<Mission>? missions,
    MediplanStatus? mediplanStatus,
  }) {
    return MediplanState(
      caregivers: caregivers ?? this.caregivers,
      missions: missions ?? this.missions,
      mediplanStatus: mediplanStatus ?? this.mediplanStatus,
    );
  }
}
