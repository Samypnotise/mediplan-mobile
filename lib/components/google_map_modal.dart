import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mediplan/constants/mediplan_colors.dart';
import 'package:mediplan/models/directions.dart';
import 'package:mediplan/models/mission.dart';
import 'package:mediplan/repositories/directions_repository.dart';

Future<dynamic> showGoogleMapModal(
  BuildContext context,
  Mission mission,
) {
  return showModalBottomSheet(
    isScrollControlled: true, // To adjust size
    backgroundColor: Colors.white,
    barrierColor: MediplanColors.blur,
    context: context,
    builder: (context) {
      return MissionRecapView(mission: mission);
    },
  );
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

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isMissionAvailable = mission.start.isBefore(DateTime.now());

    return SizedBox(
      height: height * (isMissionAvailable ? 0.95 : 0.85),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            //! Titre de la modale
            Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: MediplanColors.primary,
                  size: 35,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Itinéraire de la mission",
                      style: GoogleFonts.sourceSansPro(
                        fontWeight: FontWeight.bold,
                        color: MediplanColors.primary,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),

            //! Nom du patient
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidUser,
                    color: Colors.black,
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

            //! Horaires de la mission
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidClock,
                    color: Colors.black,
                    size: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Text(
                      "${DateFormat("HH:mm").format(mission.start)} - ${DateFormat("HH:mm").format(mission.end)}",
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

            //! Titre de la mission
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.syringe,
                    color: Colors.black,
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
                height: 400,
                child: const MissionMap(),
              ),
            ),

            const Spacer(),

            //! Accéder au compte rendu de la mission
            if (isMissionAvailable)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    backgroundColor: MediplanColors.secondary,
                    shadowColor: MediplanColors.quaternary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.fileMedical,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Compte rendu",
                          style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

            //! Bouton retour
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  backgroundColor: MediplanColors.danger,
                  shadowColor: MediplanColors.quaternary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidCircleXmark,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Fermer",
                        style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MissionMap extends StatefulWidget {
  const MissionMap({super.key});

  @override
  State<MissionMap> createState() => _MissionMapState();
}

class _MissionMapState extends State<MissionMap> {
  static const LatLng sourceLocation = LatLng(47.640520, 6.853650);
  static const LatLng destinationLocation = LatLng(47.638770, 6.862100);

  late GoogleMapController _googleMapController;
  Directions? _directions;
// LocationData? _currentLocation;

  void getItinerary() async {
    final directions = await DirectionsRepository().getDirections(
      origin: sourceLocation,
      destination: destinationLocation,
    );

    setState(() {
      _directions = directions;
    });
  }

  // void getCurrentLocation() {
  //   Location location = Location();
  //
  //   location.getLocation().then((LocationData location) {
  //     print(location?.longitude);
  //     // setState(() {
  //     //   _currentLocation = location;
  //     // });
  //   });
  // }

  @override
  void initState() {
    // getCurrentLocation();
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
                            const CameraPosition(
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
