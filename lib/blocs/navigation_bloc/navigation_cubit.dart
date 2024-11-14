import 'package:mediplan/blocs/navigation_bloc/navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(Home());

  //? Available in bottom navigation bar
  void showHomeView() => emit(Home());
  void showPlanningView() => emit(Planning());
  void showCurrentMissionView() => emit(CurrentMission());

  //? Available in sidebar
  void showProfileView() => emit(Profile());
  void showMissionSwapView() => emit(MissionSwap());
  void showSettingsView() => emit(Settings());
  void showHelpView() => emit(Help());
}
