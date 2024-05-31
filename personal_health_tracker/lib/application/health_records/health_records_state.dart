// health_record_state.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:personal_health_tracker/domain/health_record.dart';


class HealthRecordState extends StateNotifier<HealthRecord?> {
  HealthRecordState() : super(null);

  Future<void> submitHealthRecord(HealthRecord record) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/health-records/createrecord'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(record.toJson()),
    );

    if (response.statusCode == 200) {
      state = record;
    } else {
      throw Exception('Failed to submit health record');
    }
  }
}
