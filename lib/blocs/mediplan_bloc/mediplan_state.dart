import 'package:mediplan/blocs/mediplan_bloc/mediplan_status.dart';
import 'package:mediplan/models/user.dart';

class MediplanLoadingState {}

class MediplanState {
  final List<User>? caregivers;
  final MediplanStatus mediplanStatus;

  MediplanState({
    this.caregivers = const [],
    this.mediplanStatus = const MediplanInitialStatus(),
  });

  MediplanState copyWith({
    List<User>? caregivers,
    MediplanStatus? mediplanStatus,
  }) {
    return MediplanState(
      caregivers: caregivers ?? this.caregivers,
      mediplanStatus: mediplanStatus ?? this.mediplanStatus,
    );
  }
}
