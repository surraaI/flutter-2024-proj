
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/application/exercises/exercise_providers.dart';
import 'package:personal_health_tracker/presention/screens/exercises_page.dart';

class ExerciseListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercises = ref.watch(exerciseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      body: exercises.isEmpty
          ? Center(child: Text('No exercises found'))
          : ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return ListTile(
                  title: Text(exercise.type),
                  subtitle: Text('${exercise.duration} minutes - ${exercise.difficulty}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      ref.read(exerciseProvider.notifier).deleteExercise(exercise.id);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExerciseFormPage()),
          );
        },
      ),
    );
  }
}
