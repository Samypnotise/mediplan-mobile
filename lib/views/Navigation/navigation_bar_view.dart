import 'package:mediplan/blocs/navigation_bloc/navigation_cubit.dart';
import 'package:mediplan/blocs/navigation_bloc/navigation_state.dart';
import 'package:mediplan/blocs/session_bloc/session_cubit.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/views/current_mission_view.dart';
import 'package:mediplan/views/home_view.dart';
import 'package:mediplan/views/planning_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationBarView extends StatefulWidget {
  const NavigationBarView({super.key});

  @override
  State<NavigationBarView> createState() => _NavigationBarViewState();
}

class _NavigationBarViewState extends State<NavigationBarView> {
  final pageList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              //? Builder is necessary to access the Scaffol.of(context) to display drawer
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    highlightColor: MediplanColors.quaternary,
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: FaIcon(
                        FontAwesomeIcons.barsStaggered,
                        color: MediplanColors.primary,
                        size: 30,
                      ),
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                },
              ),
              actions: [
                IconButton(
                  highlightColor: MediplanColors.quaternary,
                  onPressed: () {
                    context.read<SessionCubit>().signOut();
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: FaIcon(
                      FontAwesomeIcons.powerOff,
                      color: MediplanColors.danger,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const BottomNavigationBar(),
            drawer: const SidebarDrawer(),
            body: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                if (state is Home) {
                  return const HomeView();
                } else if (state is Planning) {
                  return const PlanningView();
                } else if (state is CurrentMission) {
                  return const CurrentMissionView();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MediplanColors.primary,
                      backgroundColor: MediplanColors.inputBackground,
                      strokeCap: StrokeCap.round,
                      strokeWidth: 6,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      shadowColor: MediplanColors.primary,
      backgroundColor: MediplanColors.primary,
      elevation: 5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Text(
              'Mediplan',
              style: TextStyle(
                fontFamily: GoogleFonts.oleoScriptSwashCaps().fontFamily,
                fontSize: 40,
                color: MediplanColors.background,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.globe,
                    color: MediplanColors.background,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.instagram,
                    color: MediplanColors.background,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.tiktok,
                    color: MediplanColors.background,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          //! Home tile
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 15),
              splashColor: MediplanColors.secondary,
              leading: const FaIcon(
                FontAwesomeIcons.solidHospital,
                color: MediplanColors.background,
                size: 30,
              ),
              title: Text(
                'Accueil',
                style: TextStyle(
                  fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: MediplanColors.background,
                ),
              ),
              onTap: () {
                Navigator.pop(context); //? Closes the drawer
                context.read<NavigationCubit>().showHomeView();
              },
            ),
          ),
          //! Profile tile
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 20),
              splashColor: MediplanColors.secondary,
              leading: const FaIcon(
                FontAwesomeIcons.solidUser,
                color: MediplanColors.background,
                size: 30,
              ),
              title: Text(
                'Profil',
                style: TextStyle(
                  fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: MediplanColors.background,
                ),
              ),
              onTap: () {
                // TODO : Navigation to profile page
              },
            ),
          ),
          //! Subscription tile
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListTile(
              splashColor: MediplanColors.secondary,
              leading: const FaIcon(
                FontAwesomeIcons.handHoldingMedical,
                color: MediplanColors.background,
                size: 30,
              ),
              title: Text(
                'Échanges',
                style: TextStyle(
                  fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: MediplanColors.background,
                ),
              ),
              onTap: () {
                // TODO : Navigation to subscription page
              },
            ),
          ),
          //! Settings tile
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 18),
              splashColor: MediplanColors.secondary,
              leading: const FaIcon(
                FontAwesomeIcons.gear,
                color: MediplanColors.background,
                size: 30,
              ),
              title: Text(
                'Paramètres',
                style: TextStyle(
                  fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: MediplanColors.background,
                ),
              ),
              onTap: () {
                // TODO : Navigation to settings page
              },
            ),
          ),
          //! Help tile
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 18),
              splashColor: MediplanColors.secondary,
              leading: const FaIcon(
                FontAwesomeIcons.solidCircleQuestion,
                color: MediplanColors.background,
                size: 30,
              ),
              title: Text(
                'Aide',
                style: TextStyle(
                  fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: MediplanColors.background,
                ),
              ),
              onTap: () {
                // TODO : Navigation to settings page
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: MediplanColors.tertiary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                return IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    context.read<NavigationCubit>().showHomeView();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.solidHospital,
                    color: state is Home
                        ? MediplanColors.primary
                        : MediplanColors.black,
                    size: 30,
                  ),
                );
              },
            ),
            BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                return IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    context.read<NavigationCubit>().showPlanningView();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.solidCalendarDays,
                    color: state is Planning
                        ? MediplanColors.primary
                        : MediplanColors.black,
                    size: 30,
                  ),
                );
              },
            ),
            BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
                return IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    context.read<NavigationCubit>().showCurrentMissionView();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.heartPulse,
                    color: state is CurrentMission
                        ? MediplanColors.primary
                        : MediplanColors.black,
                    size: 30,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
