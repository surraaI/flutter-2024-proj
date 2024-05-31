import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a simple state class
class DataTableState {
  final List<Map<String, dynamic>> data;
  DataTableState({required this.data});
}

// Define a provider for the state
final dataTableProvider = StateNotifierProvider<DataTableNotifier, DataTableState>((ref) {
  return DataTableNotifier();
});

// Define the state notifier
class DataTableNotifier extends StateNotifier<DataTableState> {
  DataTableNotifier() : super(DataTableState(data: []));

  Future<void> fetchData() async {
    // Simulate a data fetch. Replace with your actual data fetch logic.
    await Future.delayed(Duration(seconds: 1));
    final fetchedData = [
      {
        "date": "2022-06-01",
        "caloriesAmount": 2000,
        "weight": 70,
        "height": 175,
        "foodType": "Vegetarian",
        "minutesOfExercise": 30
      },
      // Add more data as needed
    ];
    state = DataTableState(data: fetchedData);
  }
}
