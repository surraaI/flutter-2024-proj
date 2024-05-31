// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/application/auth/auth_state.dart';
import 'package:personal_health_tracker/application/health_records/health_records_providers.dart';
import 'package:personal_health_tracker/domain/health_record.dart';
import 'package:personal_health_tracker/presention/screens/data_table.dart';
import 'package:personal_health_tracker/presention/screens/progress_page.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController foodTypeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController exerciseMinutesController = TextEditingController();
  final TextEditingController waterIntakeController = TextEditingController();

  @override
  void dispose() {
    caloriesController.dispose();
    foodTypeController.dispose();
    weightController.dispose();
    heightController.dispose();
    exerciseMinutesController.dispose();
    waterIntakeController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      final healthRecord = HealthRecord(
        id: '', // Placeholder since ID will be assigned by MongoDB
        date: DateTime.now().toIso8601String(), // Use current date and time
        calories: int.parse(caloriesController.text),
        foodType: foodTypeController.text,
        weight: int.parse(weightController.text), // Ensure type is int
        height: int.parse(heightController.text), // Ensure type is int
        exerciseMinutes: int.parse(exerciseMinutesController.text),
        waterIntake: int.parse(waterIntakeController.text), // Ensure type is int
      );

      try {
        await ref.read(healthRecordProvider.notifier).submitHealthRecord(healthRecord); // Ensure this method returns Future<void>
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data submitted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ጎመን በጤና'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              authStateNotifier.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              const Text(
                'Welcome to Your Health Tracker',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Input health data',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: caloriesController,
                          decoration: const InputDecoration(
                            labelText: 'Calories Amount',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter calories amount';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: foodTypeController,
                          decoration: const InputDecoration(
                            labelText: 'Food Type',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter food type';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: weightController,
                          decoration: const InputDecoration(
                            labelText: 'Weight',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter weight';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: heightController,
                          decoration: const InputDecoration(
                            labelText: 'Height',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter height';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: exerciseMinutesController,
                          decoration: const InputDecoration(
                            labelText: 'Minutes of Exercise',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter minutes of exercise';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: waterIntakeController,
                          decoration: const InputDecoration(
                            labelText: 'Amount of Water Taken (in liters)',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter water intake';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _submitData,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DataTablePage()),
                  );
                },
                child: const Text('View Data Table'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HealthTrackerPage.withSampleData()),
                  );
                },
                child: const Text('View Progress Chart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
