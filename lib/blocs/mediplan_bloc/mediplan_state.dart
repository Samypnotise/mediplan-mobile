import 'package:mediplan/blocs/mediplan_bloc/mediplan_status.dart';

class MediplanLoadingState {}

class MediplanState {
  final MediplanStatus mediplanStatus;

  MediplanState({
    this.mediplanStatus = const MediplanInitialStatus(),
  });

  MediplanState copyWith({
    MediplanStatus? mediplanStatus,
  }) {
    return MediplanState(
      mediplanStatus: mediplanStatus ?? this.mediplanStatus,
    );
  }
}
