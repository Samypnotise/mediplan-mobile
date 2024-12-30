import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_bloc.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_event.dart';
import 'package:mediplan/blocs/mission_swap_bloc/mission_swap_event.dart';
import 'package:mediplan/blocs/mission_swap_bloc/mission_swap_state.dart';
import 'package:mediplan/models/mission_swap.dart';
import 'package:mediplan/repositories/mission_swap_repository.dart';
import 'package:mediplan/status/form_submission_status.dart';

class MissionSwapBloc extends Bloc<MissionSwapEvent, MissionSwapState> {
  // Utile pour trigger la mise à jour des missions
  final MediplanBloc mediplanBloc;
  final MissionSwap? missionSwapDemand;
  final MissionSwapRepository missionSwapRepository;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  MissionSwapBloc({
    required this.mediplanBloc,
    required this.missionSwapRepository,
    this.missionSwapDemand,
  }) : super(
          MissionSwapState().copyWith(
            senderId: missionSwapDemand?.senderId,
            receiverId: missionSwapDemand?.receiverId,
            missionId: missionSwapDemand?.mission.id,
            demandStatus: missionSwapDemand?.demandStatus,
          ),
        ) {
    on<InitMissionSwapDemand>((event, emit) async {
      try {
        final userId = await secureStorage.read(key: 'userId');

        if (userId!.isNotEmpty) {
          emit(state.copyWith(senderId: userId));
        } else {
          emit(
            state.copyWith(
              formStatus: SubmissionFailed(
                Exception(
                  "Erreur lors de la récupération de l'identifiant de l'utilisateur.",
                ),
              ),
            ),
          );
        }
      } catch (error) {
        emit(
          state.copyWith(
            formStatus: SubmissionFailed(
              Exception(error),
            ),
          ),
        );
      }
    });

    on<ReceiverIdChanged>((event, emit) async {
      emit(state.copyWith(receiverId: event.receiverId));
    });

    on<MissionIdChanged>((event, emit) async {
      emit(state.copyWith(missionId: event.missionId));
    });

    on<DemandStatusChanged>((event, emit) async {
      emit(state.copyWith(demandStatus: event.demandStatus));
    });

    on<TriggerMissionSwapDemandReset>((event, emit) async {
      emit(state.copyWith(
        receiverId: '',
        missionId: '',
        demandStatus: 'PENDING',
        formStatus: const InitialFormStatus(),
      ));
    });

    on<MissionSwapDemandCreated>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmittting()));

      try {
        final token = await secureStorage.read(key: 'jwt');

        final response = await missionSwapRepository.createMissionSwapDemand(
          token: token!,
          missionSwapDemandJson: jsonEncode({
            'senderId': state.senderId,
            'receiverId': state.receiverId,
            'missionId': state.missionId,
            'status': state.demandStatus,
          }),
        );

        if (response.statusCode == 200) {
          emit(state.copyWith(formStatus: SubmissionSuccess()));
        } else {
          emit(
            state.copyWith(
              formStatus: SubmissionFailed(
                Exception(
                  "Erreur lors de la création de la demande d'échange.",
                ),
              ),
            ),
          );
        }
      } catch (error) {
        emit(
          state.copyWith(
            formStatus: SubmissionFailed(
              Exception(error),
            ),
          ),
        );
      }

      add(TriggerMissionSwapDemandReset());
    });

    on<MissionSwapDemandUpdated>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmittting()));

      try {
        final token = await secureStorage.read(key: 'jwt');

        final response = await missionSwapRepository.updateMissionSwapDemand(
          token: token!,
          missionSwapDemandId: event.missionSwapDemandId,
          missionSwapDemandJson: jsonEncode({
            'senderId': state.senderId,
            'receiverId': state.receiverId,
            'missionId': state.missionId,
            'status': state.demandStatus,
          }),
        );

        print(response.statusCode);
        if (response.statusCode == 200) {
          emit(state.copyWith(formStatus: SubmissionSuccess()));
        } else {
          emit(
            state.copyWith(
              formStatus: SubmissionFailed(
                Exception(
                  "Erreur lors de la mise à jour de la demande d'échange.",
                ),
              ),
            ),
          );
        }
      } catch (error) {
        emit(
          state.copyWith(
            formStatus: SubmissionFailed(
              Exception(error),
            ),
          ),
        );
      }

      add(TriggerMissionSwapDemandReset());

      mediplanBloc.add(TriggerMissionSwapDemandsUpdate());
    });
  }
}
