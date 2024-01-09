import '../../domain/entities/last_week.dart';

class LastWeekModel extends LastWeek {
  const LastWeekModel({
    required super.date,
    required super.value,
  });

  factory LastWeekModel.fromMap(String datee, int valuee) => LastWeekModel(
        date: datee,
        value: valuee,
      );

  Map<String, dynamic> toMap() => {
        'date': date,
        'value': value,
      };
}
