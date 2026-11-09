import 'package:equatable/equatable.dart';

class MemberCommission extends Equatable {
  final bool enabled;
  final double? percent;

  const MemberCommission({required this.enabled, required this.percent});

  const MemberCommission.off() : enabled = false, percent = null;

  @override
  List<Object?> get props => [enabled, percent];
}
