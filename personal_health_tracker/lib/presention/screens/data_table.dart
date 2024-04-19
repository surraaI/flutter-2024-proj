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
              columnSpacing: 10.0, // Adjust the spacing between columns
              columns: [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Calories')),
                DataColumn(label: Text('Weight')),
                DataColumn(label: Text('Height')),
                DataColumn(label: Text('Food Type')),
                DataColumn(label: Text('Minutes of Exercise')),
                DataColumn(label: Text('Water Taken (in liters)')),
                DataColumn(label: Container(width: 100.0)),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('2022-04-01')),
                  DataCell(Text('2000')),
                  DataCell(Text('75 kg')),
                  DataCell(Text('175 cm')),
                  DataCell(Text('Protein shake')),
                  DataCell(Text('30')),
                  DataCell(Text('2')),
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