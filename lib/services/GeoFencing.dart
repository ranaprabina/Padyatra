import 'dart:async';

import 'package:geofence_flutter/geofence_flutter.dart';

StreamSubscription<GeofenceEvent> geoFenceEventStream;
String geoFenceEvent;

class GeoFencing {
  bool startGeofencing(String latitude, String longitude) {
    Geofence.startGeofenceService(
      pointedLatitude: latitude,
      pointedLongitude: longitude,
      radiusMeter: "100",
      eventPeriodInSeconds: 5,
    );
    if (geoFenceEventStream == null) {
      geoFenceEventStream =
          Geofence.getGeofenceStream().listen((GeofenceEvent event) {
        geoFenceEvent = event.toString();
      });
    }
    if (geoFenceEventStream != null && geoFenceEvent != "GeofenceEvent.enter") {
      return false;
    } else {
      return true;
    }
  }

  bool stopGeoFencing() {
    if (geoFenceEventStream != null && geoFenceEvent == "GeofenceEvent.enter") {
      Geofence.stopGeofenceService();
      geoFenceEventStream.cancel();
      return true;
    } else {
      try {
        Geofence.stopGeofenceService();
        geoFenceEventStream.cancel();
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }
  }

  dispose() {
    Geofence.stopGeofenceService();
    geoFenceEventStream.cancel();
  }
}
