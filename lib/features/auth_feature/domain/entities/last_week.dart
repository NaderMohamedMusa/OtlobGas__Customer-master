import 'package:equatable/equatable.dart';

class LastWeek extends Equatable {
  
  final String date;
  final int value;

  const LastWeek({
    required this.date,
    required this.value,
  });

  @override
  List<Object?> get props => [
        date,
        value,
      ];
}
