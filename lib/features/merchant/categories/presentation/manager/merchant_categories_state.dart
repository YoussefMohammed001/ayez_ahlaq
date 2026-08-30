import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_category.dart';

enum CategoriesStatus { initial, loading, success, failure }

class MerchantCategoriesState extends Equatable {
  final CategoriesStatus status;
  final List<MerchantCategory> assignable;
  final List<MerchantCategory> own;
  final String? errorMessage;
  final bool isSubmitting;

  const MerchantCategoriesState({
    this.status = CategoriesStatus.initial,
    this.assignable = const [],
    this.own = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  List<MerchantCategory> get globalCategories =>
      assignable.where((c) => c.global).toList();

  MerchantCategoriesState copyWith({
    CategoriesStatus? status,
    List<MerchantCategory>? assignable,
    List<MerchantCategory>? own,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MerchantCategoriesState(
      status: status ?? this.status,
      assignable: assignable ?? this.assignable,
      own: own ?? this.own,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    assignable,
    own,
    errorMessage,
    isSubmitting,
  ];
}
