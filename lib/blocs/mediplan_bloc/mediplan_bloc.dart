import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_event.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_status.dart';
import 'package:mediplan/models/mission.dart';
import 'package:mediplan/models/mission_swap.dart';
import 'package:mediplan/models/user.dart';
import 'package:mediplan/repositories/mediplan_repository.dart';

class MediplanBloc extends Bloc<MediplanEvent, MediplanState> {
  final MediplanRepository mediplanRepository;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  MediplanBloc({required this.mediplanRepository}) : super(MediplanState()) {
    on<TriggerFetchUserData>(_onFetchUserData);

    on<TriggerMissionSwapDemandsUpdate>((event, emit) async {
      await attemptFetchingMissionSwapReceivedDemands(emit);
      await attemptFetchingUserMissions(emit);
    });

    on<TriggerMissionUpdate>((event, emit) async {
      await attemptFetchingUserMissions(emit);
    });
  }

  Future<void> _onFetchUserData(
    TriggerFetchUserData event,
    Emitter<MediplanState> emit,
  ) async {
    print("Fetching user data...");

    await attemptFetchingCaregivers(emit);
    await attemptFetchingUserMissions(emit);
    await attemptFetchingMissionSwapReceivedDemands(emit);

    print("User data fetched !");
  }

  //! Methode permettant de recuperer les demandes d'echanges de l'utilisateur reçues
  Future<void> attemptFetchingMissionSwapReceivedDemands(
    Emitter<MediplanState> emit,
  ) async {
    final List<MissionSwap> missionSwapDemands = [];

    emit(state.copyWith(mediplanStatus: MediplanLoadingStatus()));

    try {
      final token = await secureStorage.read(key: 'jwt');
      final userId = await secureStorage.read(key: 'userId');

      final response = await mediplanRepository.getReceivedMissionSwapDemands(
        userId: userId!,
        token: token!,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        if (data.length != 0) {
          for (var i = 0; i < data.length; i++) {
            missionSwapDemands.add(MissionSwap.fromJson(data[i]));
          }
        }

        if (data.length > 1) {
          missionSwapDemands.sort((a, b) {
            // Compare by emission date
            return a.createdAt!.compareTo(b.createdAt!);
          });
        }

        emit(
          state.copyWith(
            receivedMissionSwapDemands: missionSwapDemands,
            mediplanStatus: MediplanSuccessStatus(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            mediplanStatus: MediplanErrorStatus(
              Exception(
                  "Erreur lors de la récupération des demandes d'échanges de mission (reçues) de l'utilisateur."),
            ),
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          mediplanStatus: MediplanErrorStatus(
            Exception(error),
          ),
        ),
      );
    }
  }

  //! Methode permettant de recuperer les demandes d'echanges de l'utilisateur émises
  Future<void> attemptFetchingMissionSwapEmittedDemands(
    Emitter<MediplanState> emit,
  ) async {
    final List<MissionSwap> missionSwapDemands = [];

    emit(state.copyWith(mediplanStatus: MediplanLoadingStatus()));

    try {
      final token = await secureStorage.read(key: 'jwt');
      final userId = await secureStorage.read(key: 'userId');

      final response = await mediplanRepository.getEmittedMissionSwapDemands(
        userId: userId!,
        token: token!,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        if (data.length != 0) {
          for (var i = 0; i < data.length; i++) {
            missionSwapDemands.add(MissionSwap.fromJson(data[i]));
          }
        }

        if (data.length > 1) {
          missionSwapDemands.sort((a, b) {
            // Compare by emission date
            return a.createdAt!.compareTo(b.createdAt!);
          });
        }

        emit(
          state.copyWith(
            emittedMissionSwapDemands: missionSwapDemands,
            mediplanStatus: MediplanSuccessStatus(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            mediplanStatus: MediplanErrorStatus(
              Exception(
                  "Erreur lors de la récupération des missions de l'utilisateur."),
            ),
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          mediplanStatus: MediplanErrorStatus(
            Exception(error),
          ),
        ),
      );
    }
  }

  //! Méthode permettant de récupérer les missions de l'utilisateur
  Future<void> attemptFetchingUserMissions(
    Emitter<MediplanState> emit,
  ) async {
    final List<Mission> missions = [];

    emit(state.copyWith(mediplanStatus: MediplanLoadingStatus()));

    try {
      final token = await secureStorage.read(key: 'jwt');
      final userId = await secureStorage.read(key: 'userId');

      final response = await mediplanRepository.getUserMissions(
        userId: userId!,
        token: token!,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];

        if (data.length != 0) {
          for (var i = 0; i < data.length; i++) {
            missions.add(Mission.fromJson(data[i]));
          }
        }

        if (data.length > 1) {
          missions.sort((a, b) {
            // Compare by last time studied
            return a.start.compareTo(b.start);
          });
        }

        emit(
          state.copyWith(
            missions: missions,
            mediplanStatus: MediplanSuccessStatus(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            mediplanStatus: MediplanErrorStatus(
              Exception(
                  "Erreur lors de la récupération des missions de l'utilisateur."),
            ),
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          mediplanStatus: MediplanErrorStatus(
            Exception(error),
          ),
        ),
      );
    }
  }

  //! Méthode permettant de récupérer les aides-soignants
  Future<void> attemptFetchingCaregivers(
    Emitter<MediplanState> emit,
  ) async {
    final List<User> caregivers = [];

    emit(state.copyWith(mediplanStatus: MediplanLoadingStatus()));

    try {
      final token = await secureStorage.read(key: 'jwt');

      final response = await mediplanRepository.getCaregivers(token: token!);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"];

        if (data.length != 0) {
          for (var i = 0; i < data.length; i++) {
            caregivers.add(User.fromJson(data[i]));
          }
        }

        if (data.length > 1) {
          caregivers.sort((a, b) {
            // Compare by last name first
            int lastNameComparison =
                a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase());

            // If last names are equal, compare by first name
            if (lastNameComparison == 0) {
              return a.firstName
                  .toLowerCase()
                  .compareTo(b.lastName.toLowerCase());
            }

            // Otherwise, return the result of last name comparison
            return lastNameComparison;
          });
        }

        emit(
          state.copyWith(
            caregivers: caregivers,
            mediplanStatus: MediplanSuccessStatus(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            mediplanStatus: MediplanErrorStatus(
              Exception(
                "Erreur lors de la récupération des aides-soignants.",
              ),
            ),
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          mediplanStatus: MediplanErrorStatus(
            Exception(error),
          ),
        ),
      );
    }
  }
}
