import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_bloc.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/blocs/mission_swap_bloc/mission_swap_bloc.dart';
import 'package:mediplan/blocs/mission_swap_bloc/mission_swap_event.dart';
import 'package:mediplan/blocs/mission_swap_bloc/mission_swap_state.dart';
import 'package:mediplan/components/confirmation_modal.dart';
import 'package:mediplan/components/custom_flushbar.dart';
import 'package:mediplan/components/loader.dart';
import 'package:mediplan/components/mission_swap_tile.dart';
import 'package:mediplan/constants/flushbar_type.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/mission.dart';
import 'package:mediplan/models/mission_swap.dart';
import 'package:mediplan/models/user.dart';
import 'package:mediplan/repositories/mission_swap_repository.dart';
import 'package:mediplan/status/form_submission_status.dart';

class MissionSwapView extends StatefulWidget {
  const MissionSwapView({super.key});

  @override
  State<MissionSwapView> createState() => _MissionSwapViewState();
}

class _MissionSwapViewState extends State<MissionSwapView> {
  bool _isShowingReceivedMissions = false;

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 30,
            right: 30,
            bottom: 20,
          ),
          child: Column(
            children: [
              //! Page title
              Row(
                children: [
                  Text(
                    "Échange de missions",
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              //! Page description
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidCircleQuestion,
                    color: MediplanColors.placeholder,
                    size: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Visualisez et créez des demandes.",
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: MediplanColors.placeholder,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //! Nouvellle demande
                    Container(
                      width: phoneWidth * 0.40,
                      decoration: BoxDecoration(
                        color: _isShowingReceivedMissions
                            ? Colors.white
                            : MediplanColors.tertiary,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: MediplanColors.quaternary,
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          splashColor: MediplanColors.quaternary,
                          borderRadius: BorderRadius.circular(15),
                          onTap: _isShowingReceivedMissions
                              ? () {
                                  setState(() {
                                    _isShowingReceivedMissions =
                                        !_isShowingReceivedMissions;
                                  });
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Nouvelle",
                                  style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: _isShowingReceivedMissions
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //! Demandes recues
                    Container(
                      width: phoneWidth * 0.40,
                      decoration: BoxDecoration(
                        color: _isShowingReceivedMissions
                            ? MediplanColors.tertiary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: MediplanColors.quaternary,
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          BlocBuilder<MediplanBloc, MediplanState>(
                            builder: (context, state) {
                              return state
                                      .receivedMissionSwapDemands!.isNotEmpty
                                  ? Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          color: MediplanColors.danger,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1),
                                          child: Center(
                                            child: Text(
                                              state.receivedMissionSwapDemands!
                                                  .length
                                                  .toString(),
                                              style: GoogleFonts.sourceSansPro(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(width: 0);
                            },
                          ),
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            child: InkWell(
                              splashColor: MediplanColors.quaternary,
                              borderRadius: BorderRadius.circular(15),
                              onTap: !_isShowingReceivedMissions
                                  ? () {
                                      setState(() {
                                        _isShowingReceivedMissions =
                                            !_isShowingReceivedMissions;
                                      });
                                    }
                                  : null,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Reçues",
                                      style: GoogleFonts.sourceSansPro(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: _isShowingReceivedMissions
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //! Affichage conditionnel en fonction de la vue sélectionnée
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: _isShowingReceivedMissions
                      ? SwapDemandsList(phoneWidth: phoneWidth)
                      : NewSwapDemand(phoneWidth: phoneWidth),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewSwapDemand extends StatelessWidget {
  const NewSwapDemand({
    super.key,
    required this.phoneWidth,
  });

  final double phoneWidth;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MissionSwapRepository(),
      child: BlocProvider(
        create: (context) {
          final missionSwapBloc = MissionSwapBloc(
            mediplanBloc: context.read<MediplanBloc>(),
            missionSwapRepository: context.read<MissionSwapRepository>(),
          );

          missionSwapBloc.add(InitMissionSwapDemand());

          return missionSwapBloc;
        },
        child: BlocListener<MissionSwapBloc, MissionSwapState>(
          listener: (context, state) {
            final formStatus = state.formStatus;

            if (formStatus is SubmissionFailed) {
              showCustomFlushbar(
                context,
                'Demande non créée ...',
                "Veuillez réessayer ultérieurement.",
                const FaIcon(
                  FontAwesomeIcons.arrowRightArrowLeft,
                  color: Colors.white,
                  size: 30,
                ),
                FlushbarType.danger,
              );
            }

            if (formStatus is SubmissionSuccess) {
              showCustomFlushbar(
                context,
                'Demande créée avec succès !',
                "La demande d'échange a bien été envoyée.",
                const FaIcon(
                  FontAwesomeIcons.arrowRightArrowLeft,
                  color: Colors.white,
                  size: 30,
                ),
                FlushbarType.success,
              );
            }
          },
          child: Column(
            children: [
              Column(
                children: [
                  //! Mission a echanger
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.bookMedical,
                        color: Colors.black,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Mission à échanger",
                          style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //! Mission dropdown
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: BlocBuilder<MissionSwapBloc, MissionSwapState>(
                      builder: (context, state) {
                        return state.formStatus is InitialFormStatus
                            ? const MissionsDropdown()
                            : const Loader();
                      },
                    ),
                  ),

                  //! Caregiver title
                  BlocBuilder<MissionSwapBloc, MissionSwapState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: state.missionId.isEmpty ? 20 : 30),
                        child: state.missionId.isNotEmpty
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.userNurse,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Aide-soignant",
                                          style: GoogleFonts.sourceSansPro(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //! Caregiver dropdown
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: CaregiversDropdown(),
                                  ),
                                ],
                              )
                            : Column(
                                spacing: 10,
                                children: [
                                  SvgPicture.asset(
                                    'lib/images/Select-amico.svg',
                                    width: phoneWidth * 0.43,
                                  ),
                                  Text(
                                    "Commencez par sélectionner une mission.",
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: MediplanColors.placeholder,
                                    ),
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                ],
              ),
              const Spacer(),

              //! Bouton de demande d'échange de mission
              BlocBuilder<MissionSwapBloc, MissionSwapState>(
                builder: (context, state) {
                  final bool isButtonDisabled =
                      state.missionId.isEmpty || state.receiverId.isEmpty;

                  return SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: isButtonDisabled
                          ? null
                          : () {
                              // TODO : Open a confirmation modal to send the mission swap request
                              showConfirmationModal(
                                context,
                                heightMultiplicator: 0.30,
                                Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.triangleExclamation,
                                      size: 30,
                                      color: MediplanColors.danger,
                                    ),
                                    // Spacer to push the text to the center
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Émission de la demande",
                                          style: GoogleFonts.sourceSansPro(
                                            fontWeight: FontWeight.w900,
                                            color: MediplanColors.danger,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.triangleExclamation,
                                      color: MediplanColors.danger,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                "Voulez-vous vraiment créer cette demande d'échange ?",
                                () {
                                  context
                                      .read<MissionSwapBloc>()
                                      .add(MissionSwapDemandCreated());
                                },
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MediplanColors.primary,
                        elevation: 5,
                        shadowColor: MediplanColors.quaternary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            isButtonDisabled
                                ? FontAwesomeIcons.lock
                                : FontAwesomeIcons.arrowRightArrowLeft,
                            color: Colors.white,
                            size: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              "Faire une demande d'échange",
                              style: GoogleFonts.sourceSansPro(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwapDemandsList extends StatelessWidget {
  const SwapDemandsList({super.key, required this.phoneWidth});

  final double phoneWidth;

  @override
  Widget build(BuildContext context) {
    return //! Liste des missions
        BlocBuilder<MediplanBloc, MediplanState>(
      builder: (context, mediplanState) {
        List<MissionSwap>? receivedMissionSwapDemands =
            mediplanState.receivedMissionSwapDemands;

        return Expanded(
          child: receivedMissionSwapDemands!.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'lib/images/Health professional team-amico.svg',
                      width: phoneWidth * 0.8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Aucune demande d'échange reçue.",
                        style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: MediplanColors.placeholder,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemCount: receivedMissionSwapDemands.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == receivedMissionSwapDemands.length - 1
                            ? 10
                            : 0,
                      ),
                      child: MissionSwapTile(
                        missionSwapDemand: receivedMissionSwapDemands[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 25);
                  },
                ),
        );
      },
    );
  }
}

class CaregiversDropdown extends StatelessWidget {
  const CaregiversDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediplanBloc, MediplanState>(
      builder: (context, mediplanState) {
        final List<User>? caregivers = mediplanState.caregivers;

        return CustomDropdown.search(
          items: caregivers,
          maxlines: 1,
          hintText: 'Choisissez un aide-soignant',
          searchHintText: "Rechercher",
          decoration: CustomDropdownDecoration(
            noResultFoundStyle: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: MediplanColors.dangerDarker,
            ),
            hintStyle: GoogleFonts.sourceSansPro(
              color: MediplanColors.placeholder,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            // TODO : Possible amelioration - Remplacer par un bouton pour vider la dropdown
            closedSuffixIcon: const FaIcon(
              FontAwesomeIcons.circleChevronDown,
              color: MediplanColors.primary,
            ),
            closedShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
            closedBorder: Border.all(
              color: MediplanColors.inputBackground,
            ),
            closedBorderRadius: BorderRadius.circular(10),
            closedFillColor: MediplanColors.inputBackground,
            expandedBorder: Border.all(
              color: MediplanColors.tertiary,
              width: 2,
            ),
            expandedFillColor: MediplanColors.quaternary,
            expandedSuffixIcon: const FaIcon(
              FontAwesomeIcons.circleChevronUp,
              color: MediplanColors.primary,
            ),
            expandedShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
            listItemStyle: GoogleFonts.sourceSansPro(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            searchFieldDecoration: SearchFieldDecoration(
              prefixIcon: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 17,
                    color: MediplanColors.placeholder,
                  ),
                ],
              ),
              hintStyle: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600,
                color: MediplanColors.placeholder,
              ),
              textStyle: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            listItemDecoration: const ListItemDecoration(
              selectedColor: MediplanColors.primary,
              splashColor: MediplanColors.tertiary,
              highlightColor: MediplanColors.tertiary,
            ),
          ),
          listItemBuilder: (context, item, isSelected, onItemSelect) {
            return SizedBox(
              child: Text(
                "${item.lastName.toUpperCase()} ${item.firstName}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.sourceSansPro(
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
          headerBuilder: (context, selectedItem, enabled) {
            return Text(
              "${selectedItem.lastName.toUpperCase()} ${selectedItem.firstName}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.sourceSansPro(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MediplanColors.primary,
              ),
            );
          },
          noResultFoundText: "Aucun aide-soignant trouvé...",
          excludeSelected: false,
          onChanged: (caregiver) {
            context
                .read<MissionSwapBloc>()
                .add(ReceiverIdChanged(receiverId: caregiver!.id));
          },
        );
      },
    );
  }
}

class MissionsDropdown extends StatelessWidget {
  const MissionsDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediplanBloc, MediplanState>(
      builder: (context, mediplanState) {
        final List<Mission>? missions = mediplanState.missions;

        return CustomDropdown.search(
          items: missions,
          maxlines: 1,
          hintText: 'Choisissez une mission',
          searchHintText: "Rechercher",
          decoration: CustomDropdownDecoration(
            noResultFoundStyle: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: MediplanColors.dangerDarker,
            ),
            hintStyle: GoogleFonts.sourceSansPro(
              color: MediplanColors.placeholder,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            closedSuffixIcon: const FaIcon(
              FontAwesomeIcons.circleChevronDown,
              color: MediplanColors.primary,
            ),
            closedShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
            closedBorder: Border.all(
              color: MediplanColors.inputBackground,
            ),
            closedBorderRadius: BorderRadius.circular(10),
            closedFillColor: MediplanColors.inputBackground,
            expandedBorder: Border.all(
              color: MediplanColors.tertiary,
              width: 2,
            ),
            expandedFillColor: MediplanColors.quaternary,
            expandedSuffixIcon: const FaIcon(
              FontAwesomeIcons.circleChevronUp,
              color: MediplanColors.primary,
            ),
            expandedShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
            listItemStyle: GoogleFonts.sourceSansPro(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            searchFieldDecoration: SearchFieldDecoration(
              prefixIcon: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 17,
                    color: MediplanColors.placeholder,
                  ),
                ],
              ),
              hintStyle: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600,
                color: MediplanColors.placeholder,
              ),
              textStyle: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            listItemDecoration: const ListItemDecoration(
              selectedColor: MediplanColors.primary,
              splashColor: MediplanColors.tertiary,
              highlightColor: MediplanColors.tertiary,
            ),
          ),
          listItemBuilder: (context, item, isSelected, onItemSelect) {
            return SizedBox(
              child: Text(
                "${DateFormat("dd/MM/yyyy").format(item.start)} • ${DateFormat("HH:mm").format(item.start)} - ${DateFormat("HH:mm").format(item.end)}\n${item.patient}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.sourceSansPro(
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
          headerBuilder: (context, selectedItem, enabled) {
            return Text(
              "${DateFormat("dd/MM/yyyy").format(selectedItem.start)} • ${DateFormat("HH:mm").format(selectedItem.start)} - ${DateFormat("HH:mm").format(selectedItem.end)} : ${selectedItem.patient}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.sourceSansPro(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: MediplanColors.primary,
              ),
            );
          },
          noResultFoundText: "Aucune mission trouvée ...",
          excludeSelected: false,
          onChanged: (mission) {
            context
                .read<MissionSwapBloc>()
                .add(MissionIdChanged(missionId: mission!.id));
          },
        );
      },
    );
  }
}
