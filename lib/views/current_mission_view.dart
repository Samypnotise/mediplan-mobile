import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mediplan/components/maps_selection_modal.dart';
import 'package:mediplan/components/report_modal.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/directions.dart';
import 'package:mediplan/models/mission.dart';
import 'package:mediplan/repositories/directions_repository.dart';
import 'package:mediplan/services/location_service.dart';

class CurrentMissionView extends StatelessWidget {
  const CurrentMissionView({
    super.key,
    required this.currentMission,
  });

  final Mission currentMission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 30,
            right: 30,
            bottom: 20,
          ),
          child: Column(
            children: [
              MissionRecapView(mission: currentMission),
            ],
          ),
        ),
      ),
    );
  }
}

class MissionRecapView extends StatefulWidget {
  const MissionRecapView({
    super.key,
    required this.mission,
  });

  final Mission mission;

  @override
  State<MissionRecapView> createState() => _MissionRecapViewState();
}

class _MissionRecapViewState extends State<MissionRecapView> {
  @override
  Widget build(BuildContext context) {
    final mission = widget.mission;

    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      // height: height * (isMissionAvailable ? 0.95 : 0.85),
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  //! Horaires de la mission
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.solidClock,
                          color: MediplanColors.secondary,
                          size: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            "${DateFormat("dd/MM").format(mission.start)} • ${DateFormat("HH:mm").format(mission.start)} - ${DateFormat("HH:mm").format(mission.end)}",
                            style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //! Nom du patient
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.solidUser,
                          color: MediplanColors.secondary,
                          size: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            mission.patient,
                            style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //! Bouton pour lancer une application MAPS
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MediplanColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      splashColor: MediplanColors.quaternary,
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        showMapsSelectionModal(context, mission);
                      },
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //! Titre de la mission
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.syringe,
                  color: MediplanColors.secondary,
                  size: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: SizedBox(
                    width: width * 0.75,
                    child: Text(
                      mission.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //! Google Map
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: MediplanColors.quaternary,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              height: 375,
              child: MissionMap(mission: mission),
            ),
          ),

          //! Bouton pour ouvrir la modale de compte rendu
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  showReportModal(context, mission);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MediplanColors.primary,
                  elevation: 5,
                  shadowColor: MediplanColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.fileMedical,
                      size: 25,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Compte rendu",
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: MediplanColors.background,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MissionMap extends StatefulWidget {
  final Mission mission;

  const MissionMap({super.key, required this.mission});

  @override
  State<MissionMap> createState() => _MissionMapState();
}

class _MissionMapState extends State<MissionMap> {
  static const LatLng sourceLocation = LatLng(47.640520, 6.853650);
  late LatLng destinationLocation;

  late GoogleMapController _googleMapController;
  Directions? _directions;
  // LocationData? _currentLocation; // Sera utile pour la localisation en temps reel

  LocationService locationService = LocationService();

  void getItinerary() async {
    final directions = await DirectionsRepository().getDirections(
      origin: sourceLocation,
      destination: destinationLocation,
    );

    setState(() {
      _directions = directions;
    });
  }

  //? Utile pour la localisation en temps reel
  // void getCurrentLocation() {
  //   locationService.getCurrentLocation().then((LocationData location) {
  //     print(location.longitude);
  //     setState(() {
  //       _currentLocation = location;
  //     });
  //   });

  // Location location = Location();

  // location.getLocation().then((LocationData location) {
  // print(location?.longitude);
  // setState(() {
  //   _currentLocation = location;
  // });
  // });
  // }

  @override
  void initState() {
    // getCurrentLocation();

    destinationLocation = LatLng(
      widget.mission.latitude,
      widget.mission.longitude,
    );

    getItinerary();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          onMapCreated: (controller) => _googleMapController = controller,
          myLocationButtonEnabled: false,
          initialCameraPosition: const CameraPosition(
            target: sourceLocation,
            zoom: 14.5,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("source"),
              position: sourceLocation,
              infoWindow: const InfoWindow(title: "Vous"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              ),
            ),
            Marker(
              markerId: const MarkerId("destination"),
              position: destinationLocation,
              infoWindow: const InfoWindow(title: "Patient"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          },
          polylines: {
            if (_directions != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: MediplanColors.tertiary,
                width: 6,
                points: _directions!.polylinePoints
                    .map(
                      (point) => LatLng(
                        point.latitude,
                        point.longitude,
                      ),
                    )
                    .toList(),
              ),
          },
        ),

        //! Affichage de la distance et du temps de trajet
        if (_directions != null)
          Positioned(
            top: 20,
            child: Container(
              decoration: BoxDecoration(
                color: MediplanColors.warning,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: MediplanColors.quaternary,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Text(
                  "${_directions?.totalDistance} • ${_directions?.totalDuration}",
                  style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),

        //! Bouton pour recentrer la map
        Positioned(
          bottom: 20,
          left: 20,
          child: Container(
            decoration: BoxDecoration(
              color: MediplanColors.secondary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: MediplanColors.quaternary,
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _googleMapController.animateCamera(
                        CameraUpdate.newLatLngBounds(_directions!.bounds, 50),
                      );
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.expand,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Bouton pour centrer la map sur la localisation de l'aide-soignant
        if (_directions != null)
          Positioned(
            bottom: 20,
            right: 85,
            child: Container(
              decoration: BoxDecoration(
                color: MediplanColors.secondary, // Background color
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: MediplanColors.quaternary, // Shadow color
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            const CameraPosition(
                              target: sourceLocation,
                              zoom: 16.5,
                            ),
                          ),
                        );
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.truckMedical,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Bouton pour centrer la map sur l'adresse du patient
        if (_directions != null)
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: MediplanColors.secondary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: MediplanColors.quaternary, // Shadow color
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _googleMapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: destinationLocation,
                              zoom: 16.5,
                            ),
                          ),
                        );
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.solidUser,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
