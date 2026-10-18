enum LocationAvailability {
  available,
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  unavailable;

  bool get isAvailable => this == LocationAvailability.available;

  bool get needsDeviceSettings =>
      this == LocationAvailability.serviceDisabled ||
      this == LocationAvailability.permissionDeniedForever;
}
