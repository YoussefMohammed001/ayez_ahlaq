import 'package:equatable/equatable.dart';
import '../../domain/entities/shop_haircut_style.dart';

enum ShopHaircutStylesStatus { initial, loading, success, failure }

class ShopHaircutStylesState extends Equatable {
  final ShopHaircutStylesStatus status;
  final List<ShopHaircutStyle> styles;
  final String? errorMessage;
  final bool isSubmitting;

  const ShopHaircutStylesState({
    this.status = ShopHaircutStylesStatus.initial,
    this.styles = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  ShopHaircutStyle? styleById(int? id) =>
      styles.where((s) => s.id == id).firstOrNull;

  ShopHaircutStylesState copyWith({
    ShopHaircutStylesStatus? status,
    List<ShopHaircutStyle>? styles,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return ShopHaircutStylesState(
      status: status ?? this.status,
      styles: styles ?? this.styles,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, styles, errorMessage, isSubmitting];
}
