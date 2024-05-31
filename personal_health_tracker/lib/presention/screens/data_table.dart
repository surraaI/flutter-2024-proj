import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_health_tracker/presention/screens/provider/dataProvider.dart';

class DataTablePage extends ConsumerStatefulWidget {
  const DataTablePage({Key? key}) : super(key: key);

  @override
  ConsumerState<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends ConsumerState<DataTablePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(dataTableProvider.notifier).fetchData());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dataTableProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/');
          },
        ),
        title: const Text('Data Table'),
      ),
      body: state.data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      DataTable(
                        columnSpacing: 10.0,
                        columns: [
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Calories')),
                          DataColumn(label: Text('Weight')),
                          DataColumn(label: Text('Height')),
                          DataColumn(label: Text('Food Type')),
                          DataColumn(label: Text('Minutes of Exercise')),
                          DataColumn(label: Container(width: 100.0)),
                        ],
                        rows: state.data.map((e) {
                          return DataRow(cells: [
                            DataCell(Text(e.containsKey("date") ? e["date"].toString().substring(0, 10) : "")),
                            DataCell(Text(e.containsKey("caloriesAmount") ? e["caloriesAmount"].toString() : "")),
                            DataCell(Text(e.containsKey("weight") ? e["weight"].toString() : "")),
                            DataCell(Text(e.containsKey("height") ? e["height"].toString() : "")),
                            DataCell(Text(e.containsKey("foodType") ? e["foodType"].toString() : "")),
                            DataCell(Text(e.containsKey("minutesOfExercise") ? e["minutesOfExercise"].toString() : "")),
                            DataCell(Container(width: 100.0)),
                          ]);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
