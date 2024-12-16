import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_bloc.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/components/loader.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/mission.dart';
import 'package:mediplan/models/user.dart';

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
                    "Échanges de missions",
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
                          Positioned(
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
                                    // TODO : Remplacer par le vrai nombre de demandes recues (depuis le state mediplan)
                                    "5",
                                    style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                  padding: const EdgeInsets.only(top: 50),
                  child: _isShowingReceivedMissions
                      ? SwapDemandsList(phoneWidth: phoneWidth)
                      : const NewSwapDemand(),
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
  const NewSwapDemand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: MissionsDropdown(),
            ),

            //! Caregiver title
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.userNurse,
                    color: Colors.black,
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
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
            ),
            //! Caregiver dropdown
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: CaregiversDropdown(),
            ),
          ],
        ),
        const Spacer(),

        //! Bouton de demande d'échange de mission
        SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              // TODO : Open a confirmation modal to send the mission swap request
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
                const FaIcon(
                  FontAwesomeIcons.arrowRightArrowLeft,
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
        ),
      ],
    );
  }
}

class SwapDemandsList extends StatelessWidget {
  const SwapDemandsList({super.key, required this.phoneWidth});

  final double phoneWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          'lib/images/Programmer-amico.svg',
          width: phoneWidth * 0.8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Loader(),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "En cours de realisation...",
                style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: MediplanColors.placeholder,
                ),
              ),
            ),
          ],
        ),
      ],
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
            // TODO : onChanged function in the list
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
          onChanged: (caregiver) {
            // TODO : onChanged function in the list
          },
        );
      },
    );
  }
}
