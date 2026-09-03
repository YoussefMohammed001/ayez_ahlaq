import 'package:equatable/equatable.dart';

class BarberInvite extends Equatable {
  final String code;
  final String url;
  final int favoriteCount;

  const BarberInvite({
    required this.code,
    required this.url,
    required this.favoriteCount,
  });

  @override
  List<Object?> get props => [code, url, favoriteCount];
}
