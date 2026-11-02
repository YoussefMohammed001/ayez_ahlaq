import 'package:equatable/equatable.dart';

class BookingSlotWindow extends Equatable {
  final String from;
  final String to;
  final int minutes;
  final bool fits;

  const BookingSlotWindow({
    required this.from,
    required this.to,
    required this.minutes,
    required this.fits,
  });

  @override
  List<Object?> get props => [from, to, minutes, fits];
}
