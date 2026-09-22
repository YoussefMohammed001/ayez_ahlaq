import '../../domain/entities/support_info.dart';

class SupportInfoModel extends SupportInfo {
  const SupportInfoModel({super.whatsappNumber, super.whatsappUrl});

  factory SupportInfoModel.fromJson(Map<String, dynamic> json) {
    return SupportInfoModel(
      whatsappNumber: json['whatsappNumber'] as String?,
      whatsappUrl: json['whatsappUrl'] as String?,
    );
  }
}
