import 'dart:convert';

import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_status.dart';
import 'package:mediplan/repositories/mediplan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MediplanCubit extends Cubit<MediplanState> {
  final MediplanRepository mediplanRepository;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  MediplanCubit({required this.mediplanRepository}) : super(MediplanState()) {
    attemptFetchingUserData();
  }

  //! TODO Fetch user data and affect it to state
  void attemptFetchingUserData() async {
    print("fetching user data ...");
    final token = await secureStorage.read(key: 'jwt');
    final userId = await secureStorage.read(key: 'userId');

    if (token != null && userId != null) {
      emit(MediplanState(mediplanStatus: MediplanLoadingStatus()));
      try {
        final response =
            await mediplanRepository.getUser(userId: userId, token: token);

        final data = jsonDecode(response.body);

        print(data);
        print({"Settings", data['Settings']});
        print({"Lessons", data['Lessons']});

        if (response.statusCode == 200) {
        } else {}

        emit(MediplanState(mediplanStatus: const MediplanInitialStatus()));
      } catch (error) {
        emit(MediplanState(
            mediplanStatus: MediplanErrorStatus(Exception(error))));
        emit(MediplanState(mediplanStatus: const MediplanInitialStatus()));
      }
    } else {
      emit(MediplanState(
          mediplanStatus:
              MediplanErrorStatus(Exception("Utilisateur non connecté."))));
      emit(MediplanState(mediplanStatus: const MediplanInitialStatus()));
    }
  }
}
