import 'package:mediplan/blocs/navigation_bloc/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(Home());

  void showHomeView() => emit(Home());
  void showPlanningView() => emit(Planning());
  void showCurrentMissionView() => emit(CurrentMission());
}
