import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/data/models/attendance_feature_requests_page_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/data/models/attendance_feature_status_model.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_request_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance_feature/domain/entities/attendance_feature_state.dart';

const _owner = {
  'enabled': false,
  'state': 'NONE',
  'owner': true,
  'message': 'ميزة الحضور والانصراف غير مفعّلة — يمكنك طلب التفعيل',
  'price': 10,
  'startDate': null,
  'endDate': null,
  'daysLeft': null,
  'autoRenew': false,
  'canRequest': true,
  'pendingRequest': null,
};

const _request = {
  'id': 1,
  'shopId': 3,
  'shopName': "Men's Club",
  'ownerName': "Men's Club",
  'ownerPhone': '+201008451421',
  'price': 10,
  'status': 'PENDING',
  'decisionNote': null,
  'decidedByName': null,
  'decidedAt': null,
  'createdAt': '2026-11-04T08:07:45',
};

void main() {
  test('a shop that never subscribed can request the feature', () {
    final status = AttendanceFeatureStatusModel.fromJson(_owner);

    expect(status.enabled, false);
    expect(status.state, AttendanceFeatureState.none);
    expect(status.owner, true);
    expect(status.canRequest, true);
    expect(status.price, 10);
    expect(status.isPending, false);
    expect(status.isExpired, false);
    expect(status.pendingRequest, isNull);
    expect(status.endDate, isNull);
  });

  test('the owner sees the pending request and cannot request again', () {
    final status = AttendanceFeatureStatusModel.fromJson({
      ..._owner,
      'state': 'PENDING',
      'canRequest': false,
      'pendingRequest': _request,
    });

    expect(status.isPending, true);
    expect(status.canRequest, false);
    expect(status.pendingRequest!.id, 1);
    expect(status.pendingRequest!.status, AttendanceFeatureRequestStatus.pending);
    expect(status.pendingRequest!.createdAt!.minute, 7);
  });

  test('a team member sees pending from the state alone', () {
    final status = AttendanceFeatureStatusModel.fromJson({
      ..._owner,
      'state': 'PENDING',
      'owner': false,
      'canRequest': false,
      'message': 'ميزة الحضور والانصراف قيد التفعيل — تواصل مع صاحب المحل',
    });

    expect(status.owner, false);
    expect(status.pendingRequest, isNull);
    expect(status.isPending, true);
  });

  test('an active subscription keeps its dates and counts the days', () {
    final status = AttendanceFeatureStatusModel.fromJson({
      ..._owner,
      'enabled': true,
      'state': 'ACTIVE',
      'canRequest': false,
      'startDate': '2026-11-04',
      'endDate': '2026-11-09',
      'daysLeft': 5,
      'autoRenew': true,
    });

    expect(status.enabled, true);
    expect(status.isPending, false);
    expect(status.endDate!.day, 9);
    expect(status.daysLeft, 5);
    expect(status.isEndingSoon, true);
    expect(status.autoRenew, true);
  });

  test('an active subscription far from its end is not ending soon', () {
    final status = AttendanceFeatureStatusModel.fromJson({
      ..._owner,
      'enabled': true,
      'state': 'ACTIVE',
      'daysLeft': 20,
    });

    expect(status.isEndingSoon, false);
  });

  test('an expired subscription is locked and flagged as expired', () {
    final status = AttendanceFeatureStatusModel.fromJson({
      ..._owner,
      'state': 'EXPIRED',
    });

    expect(status.enabled, false);
    expect(status.isExpired, true);
  });

  test('an unknown state never unlocks the feature', () {
    final status = AttendanceFeatureStatusModel.fromJson({
      ..._owner,
      'state': 'SOMETHING_NEW',
    });

    expect(status.state, AttendanceFeatureState.unknown);
    expect(status.enabled, false);
  });

  test('a request history parses every status', () {
    final page = AttendanceFeatureRequestsPageModel.fromJson({
      'content': [
        {..._request, 'id': 4, 'status': 'APPROVED', 'decidedAt': '2026-11-04T09:00:00'},
        {..._request, 'id': 3, 'status': 'REJECTED', 'decisionNote': 'غير مكتمل'},
        {..._request, 'id': 2, 'status': 'CANCELLED', 'decidedAt': '2026-11-04T08:07:48'},
        {..._request, 'id': 1, 'status': 'PENDING'},
        {..._request, 'id': 0, 'status': 'ARCHIVED'},
      ],
      'page': 0,
      'size': 20,
      'totalElements': 5,
      'totalPages': 1,
    });

    final statuses = page.requests.map((r) => r.status).toList();

    expect(statuses, [
      AttendanceFeatureRequestStatus.approved,
      AttendanceFeatureRequestStatus.rejected,
      AttendanceFeatureRequestStatus.cancelled,
      AttendanceFeatureRequestStatus.pending,
      AttendanceFeatureRequestStatus.unknown,
    ]);
    expect(page.requests[1].note, 'غير مكتمل');
    expect(page.requests[0].decidedAt, isNotNull);
    expect(page.hasMore, false);
  });
}
