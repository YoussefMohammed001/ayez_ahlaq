import '../../domain/entities/salary_deductions_page.dart';
import 'salary_deduction_model.dart';

class SalaryDeductionsPageModel extends SalaryDeductionsPage {
  const SalaryDeductionsPageModel({
    required super.items,
    required super.page,
    required super.totalPages,
  });

  factory SalaryDeductionsPageModel.fromJson(Map<String, dynamic> json) {
    final content = json['content'];

    return SalaryDeductionsPageModel(
      items: content is List
          ? content
                .whereType<Map<String, dynamic>>()
                .map(SalaryDeductionModel.fromJson)
                .toList()
          : const [],
      page: (json['page'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
