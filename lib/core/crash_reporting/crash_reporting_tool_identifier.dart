import 'package:equatable/equatable.dart';

class CrashReportingToolIdentifier extends Equatable {
  final String identifier;

  const CrashReportingToolIdentifier(this.identifier);

  @override
  List<Object?> get props => [identifier];
}
