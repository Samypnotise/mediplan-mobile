import 'package:mediplan/status/form_submission_status.dart';

class MissionSwapState {
  final String senderId;
  final String receiverId;
  final String missionId;
  final String demandStatus;
  final FormSubmissionStatus formStatus;

  MissionSwapState({
    this.senderId = '',
    this.receiverId = '',
    this.missionId = '',
    this.demandStatus = 'PENDING',
    this.formStatus = const InitialFormStatus(),
  });

  MissionSwapState copyWith({
    String? senderId,
    String? receiverId,
    String? missionId,
    String? demandStatus,
    FormSubmissionStatus? formStatus,
  }) {
    return MissionSwapState(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      missionId: missionId ?? this.missionId,
      demandStatus: demandStatus ?? this.demandStatus,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
