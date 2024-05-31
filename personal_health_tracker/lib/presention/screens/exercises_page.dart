// lib/presention/screens/exercise_form_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/application/auth/exercise_providers.dart';
import 'package:personal_health_tracker/domain/exercises.dart';

class ExerciseFormPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ExerciseFormPage> createState() => _ExerciseFormPageState();
}

class _ExerciseFormPageState extends ConsumerState<ExerciseFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController difficultyController = TextEditingController();

  @override
  void dispose() {
    typeController.dispose();
    durationController.dispose();
    difficultyController.dispose();
    super.dispose();
  }

  Future<void> _submitExercise() async {
    if (_formKey.currentState!.validate()) {
      final exercise = Exercise(
        id: '', 
        type: typeController.text,
        duration: int.parse(durationController.text),
        difficulty: difficultyController.text,
        date: DateTime.now(),
      );

      try {
        ref.read(exerciseProvider.notifier).addExercise(exercise);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Exercise submitted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit exercise')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(
                  labelText: 'Type of Exercise',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter type of exercise';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration (minutes)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter duration';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: difficultyController,
                decoration: const InputDecoration(
                  labelText: 'Difficulty',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter difficulty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitExercise,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
