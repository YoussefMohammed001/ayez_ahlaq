import 'package:equatable/equatable.dart';

class SupportInfo extends Equatable {
  final String? whatsappNumber;
  final String? whatsappUrl;

  const SupportInfo({this.whatsappNumber, this.whatsappUrl});

  bool get hasWhatsapp => whatsappUrl != null && whatsappUrl!.isNotEmpty;

  @override
  List<Object?> get props => [whatsappNumber, whatsappUrl];
}
