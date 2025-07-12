import 'package:equatable/equatable.dart';

class RangeViewModel with EquatableMixin {
  final int min;
  final int max;

  const RangeViewModel({
    required this.min,
    required this.max,
  });

  @override
  List<Object?> get props => [
        min,
        max,
      ];

  bool get isValid => min <= max;
}
