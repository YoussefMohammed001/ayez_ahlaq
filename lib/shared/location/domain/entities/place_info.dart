import 'package:equatable/equatable.dart';

class PlaceInfo extends Equatable {
  final String name;
  final String city;
  final String fullAddress;

  const PlaceInfo({this.name = '', this.city = '', this.fullAddress = ''});

  static const empty = PlaceInfo();

  bool get isEmpty => name.isEmpty && fullAddress.isEmpty;

  @override
  List<Object?> get props => [name, city, fullAddress];
}
