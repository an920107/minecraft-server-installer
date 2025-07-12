import 'package:equatable/equatable.dart';

class ProgressViewModel with EquatableMixin {
  /// The value should between 0.0 and 1.0.
  final double value;
  final bool isInProgress;

  const ProgressViewModel({
    required this.value,
    required this.isInProgress,
  });

  const ProgressViewModel.zero() : this(value: 0.0, isInProgress: false);

  const ProgressViewModel.start() : this(value: 0.0, isInProgress: true);

  const ProgressViewModel.complete() : this(value: 1.0, isInProgress: false);

  @override
  List<Object?> get props => [
        value,
        isInProgress,
      ];

  ProgressViewModel copyWith({
    double? value,
    bool? isInProgress,
  }) =>
      ProgressViewModel(
        value: value ?? this.value,
        isInProgress: isInProgress ?? this.isInProgress,
      );
}
