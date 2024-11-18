import 'dart:convert';

import 'package:mediplan/blocs/mediplan_bloc/mediplan_event.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_status.dart';
import 'package:mediplan/models/user.dart';
import 'package:mediplan/repositories/mediplan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MediplanBloc extends Bloc<MediplanEvent, MediplanState> {
  final MediplanRepository mediplanRepository;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  MediplanBloc({required this.mediplanRepository}) : super(MediplanState()) {
    on<TriggerFetchUserData>(_onFetchUserData);
  }

  Future<void> _onFetchUserData(
      TriggerFetchUserData event, Emitter<MediplanState> emit) async {
    print("fetching user data ... TODO HERE");

    await attemptFetchingCaregivers(emit);
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
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.length != 0) {
          for (var i = 0; i < data.length; i++) {
            caregivers.add(User.fromJson(data[i]));
          }
        }

        emit(
          state.copyWith(
            caregivers: caregivers,
            mediplanStatus: MediplanSuccessStatus(),
          ),
        );
        print("C'est good les gars");
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
