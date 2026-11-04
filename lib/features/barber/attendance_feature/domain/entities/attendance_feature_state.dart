enum AttendanceFeatureState {
  none,
  pending,
  active,
  expired,
  suspended,
  unknown;

  static AttendanceFeatureState fromApi(String? value) =>
      switch (value?.toUpperCase()) {
        'NONE' || 'INACTIVE' || 'DISABLED' => AttendanceFeatureState.none,
        'PENDING' ||
        'REQUESTED' ||
        'PENDING_APPROVAL' => AttendanceFeatureState.pending,
        'ACTIVE' || 'ENABLED' => AttendanceFeatureState.active,
        'EXPIRED' || 'ENDED' => AttendanceFeatureState.expired,
        'SUSPENDED' ||
        'DEACTIVATED' ||
        'PAUSED' ||
        'STOPPED' ||
        'TERMINATED' ||
        'CANCELLED' ||
        'CANCELED' => AttendanceFeatureState.suspended,
        _ => AttendanceFeatureState.unknown,
      };
}
