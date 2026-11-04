enum AttendanceFeatureRequestStatus {
  pending,
  approved,
  rejected,
  cancelled,
  unknown;

  static AttendanceFeatureRequestStatus fromApi(String? value) =>
      switch (value?.toUpperCase()) {
        'PENDING' => AttendanceFeatureRequestStatus.pending,
        'APPROVED' || 'ACCEPTED' => AttendanceFeatureRequestStatus.approved,
        'REJECTED' || 'DECLINED' => AttendanceFeatureRequestStatus.rejected,
        'CANCELLED' ||
        'CANCELED' ||
        'WITHDRAWN' => AttendanceFeatureRequestStatus.cancelled,
        _ => AttendanceFeatureRequestStatus.unknown,
      };
}
