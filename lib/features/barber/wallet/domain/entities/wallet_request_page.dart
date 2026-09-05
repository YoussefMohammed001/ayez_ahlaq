import 'package:equatable/equatable.dart';
import 'wallet_request.dart';

class WalletRequestPage extends Equatable {
  final List<WalletRequest> content;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  const WalletRequestPage({
    required this.content,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  bool get hasMore => page + 1 < totalPages;

  @override
  List<Object?> get props => [content, page, size, totalElements, totalPages];
}
