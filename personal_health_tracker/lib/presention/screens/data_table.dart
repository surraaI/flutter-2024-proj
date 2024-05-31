import 'package:flutter/material.dart';

class DataTablePage extends StatelessWidget {
  const DataTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Table'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18.0),
            child: DataTable(
              columnSpacing: 10.0, 
              columns: [
                const DataColumn(label: Text('Date')),
                const DataColumn(label: Text('Calories')),
                const DataColumn(label: Text('Weight')),
                const DataColumn(label: Text('Height')),
                const DataColumn(label: Text('Food Type')),
                const DataColumn(label: Text('Minutes of Exercise')),
                const DataColumn(label: Text('Water Taken (in liters)')),
                DataColumn(label: Container(width: 100.0)),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text('2022-04-01')),
                  const DataCell(Text('2000')),
                  const DataCell(Text('75 kg')),
                  const DataCell(Text('175 cm')),
                  const DataCell(Text('Protein shake')),
                  const DataCell(Text('30')),
                  const DataCell(Text('2')),
                  DataCell(Container(width: 100.0)),
                ]),
          
                // Add more rows with data as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}