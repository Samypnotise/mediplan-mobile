import 'package:mediplan/blocs/mediplan_bloc/mediplan_event.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/repositories/mediplan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MediplanBloc extends Bloc<MediplanEvent, MediplanState> {
  final MediplanRepository mediplanRepository;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  MediplanBloc({required this.mediplanRepository}) : super(MediplanState()) {
    add(TriggerSettingsUpdate());

    on<TriggerSettingsUpdate>(
      (event, emit) async {},
    );
  }
}
