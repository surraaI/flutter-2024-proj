// health_record_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_health_tracker/application/health_records/health_records_state.dart';
import 'package:personal_health_tracker/domain/health_record.dart';


final healthRecordProvider = StateNotifierProvider<HealthRecordState, HealthRecord?>((ref) {
  return HealthRecordState();
});
