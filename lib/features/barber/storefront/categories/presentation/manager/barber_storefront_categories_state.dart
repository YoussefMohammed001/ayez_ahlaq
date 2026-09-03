import 'package:equatable/equatable.dart';
import '../../domain/entities/storefront_category.dart';

enum StorefrontCategoriesStatus { initial, loading, success, failure }

class BarberStorefrontCategoriesState extends Equatable {
  final StorefrontCategoriesStatus status;
  final List<StorefrontCategory> assignable;
  final List<StorefrontCategory> own;
  final String? errorMessage;
  final bool isSubmitting;

  const BarberStorefrontCategoriesState({
    this.status = StorefrontCategoriesStatus.initial,
    this.assignable = const [],
    this.own = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  List<StorefrontCategory> get globalCategories =>
      assignable.where((c) => c.global).toList();

  BarberStorefrontCategoriesState copyWith({
    StorefrontCategoriesStatus? status,
    List<StorefrontCategory>? assignable,
    List<StorefrontCategory>? own,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return BarberStorefrontCategoriesState(
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
