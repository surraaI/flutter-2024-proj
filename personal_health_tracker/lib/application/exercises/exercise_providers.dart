// lib/application/exercise/exercise_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/domain/exercises.dart';


class ExerciseNotifier extends StateNotifier<List<Exercise>> {
  ExerciseNotifier() : super([]);

  void addExercise(Exercise exercise) {
    state = [...state, exercise];
  }

  void removeExercise(String id) {
    state = state.where((exercise) => exercise.id != id).toList();
  }


}

final exerciseProvider = StateNotifierProvider<ExerciseNotifier, List<Exercise>>((ref) {
  return ExerciseNotifier();
});
