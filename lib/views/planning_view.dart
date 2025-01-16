import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_bloc.dart';
import 'package:mediplan/blocs/mediplan_bloc/mediplan_state.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/mission.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

class PlanningView extends StatefulWidget {
  const PlanningView({super.key});

  @override
  State<PlanningView> createState() => _PlanningViewState();
}

class _PlanningViewState extends State<PlanningView> {
  CalendarView _currentCalendarView = CalendarView.day;
  late CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double phoneHeight = MediaQuery.of(context).size.height;

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
              //! Titre de la vue
              Row(
                children: [
                  Text(
                    "Planning des missions",
                    style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              //! Indication sur l'utilité de la vue
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
                      "Une vision globale de vos missions.",
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: MediplanColors.placeholder,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              //! Planning des missions
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: phoneHeight * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: MediplanColors.quaternary,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: BlocBuilder<MediplanBloc, MediplanState>(
                    builder: (context, state) {
                      final List<Appointment> appointments = state.missions!
                          .map(
                            (Mission mission) => Appointment(
                              startTime: mission.start,
                              endTime: mission.end,
                              location: mission.address,
                              notes: mission.title,
                              subject:
                                  "${DateFormat("HH:mm").format(mission.start)} - ${DateFormat("HH:mm").format(mission.end)}\n${mission.patient} - ${mission.title}",
                              color: MediplanColors.secondary,
                            ),
                          )
                          .toList();

                      return SfCalendar(
                        controller: _calendarController,
                        view: _currentCalendarView,
                        dataSource: DataSource(appointments),
                        firstDayOfWeek: 1,
                        allowViewNavigation: true,
                        showDatePickerButton: true,
                        showTodayButton: true,
                        showNavigationArrow: true,
                        todayHighlightColor: MediplanColors.tertiary,
                        headerDateFormat: "EEEE - dd/MM/y",
                        headerStyle: CalendarHeaderStyle(
                          textStyle: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        appointmentTextStyle: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        timeSlotViewSettings: const TimeSlotViewSettings(
                          timeFormat: 'HH:mm',
                          dateFormat: 'dd',
                        ),
                      );
                    },
                  ),
                ),
              ),

              const Spacer(),

              //! Selecteur de vue
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! Vue jour
                  Container(
                    width: phoneWidth * 0.22,
                    decoration: BoxDecoration(
                      color: _currentCalendarView != CalendarView.day
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
                        onTap: _currentCalendarView != CalendarView.day
                            ? () {
                                setState(() {
                                  _currentCalendarView = CalendarView.day;
                                });
                                _calendarController.view = CalendarView.day;
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Jour",
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color:
                                      _currentCalendarView != CalendarView.day
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

                  //! Vue semaine
                  Container(
                    width: phoneWidth * 0.30,
                    decoration: BoxDecoration(
                      color: _currentCalendarView != CalendarView.week
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
                        onTap: _currentCalendarView != CalendarView.week
                            ? () {
                                setState(() {
                                  _currentCalendarView = CalendarView.week;
                                });
                                _calendarController.view = CalendarView.week;
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Semaine",
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color:
                                      _currentCalendarView != CalendarView.week
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

                  //! Vue mois
                  Container(
                    width: phoneWidth * 0.22,
                    decoration: BoxDecoration(
                      color: _currentCalendarView != CalendarView.month
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
                        onTap: _currentCalendarView != CalendarView.month
                            ? () {
                                setState(() {
                                  _currentCalendarView = CalendarView.month;
                                });
                                _calendarController.view = CalendarView.month;
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Mois",
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color:
                                      _currentCalendarView != CalendarView.month
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
