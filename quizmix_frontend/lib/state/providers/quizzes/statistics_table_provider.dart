import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CurrentPageNotifier extends StateNotifier<int> {
  CurrentPageNotifier() : super(0);

  void increment() {
    state++;
  }

  void decrement() {
    if (state > 0) {
      state--;
    }
  }

  void resetToDefault() {
    state = 0;
  }
}

final currentPageProvider =
    StateNotifierProvider<CurrentPageNotifier, int>((ref) {
  return CurrentPageNotifier();
});

class DataRowsNotifier extends StateNotifier<List<DataRow>> {
  DataRowsNotifier() : super(<DataRow>[]);

  void updateDataRows(List<DataRow> newRows) {
    state = newRows;
  }
}

final dataRowsProvider =
    StateNotifierProvider<DataRowsNotifier, List<DataRow>>((ref) {
  return DataRowsNotifier();
});

class DataColumnsNotifier extends StateNotifier<List<DataColumn>> {
  DataColumnsNotifier() : super(<DataColumn>[]);

  void updateDataColumns(List<DataColumn> newColumns) {
    state = newColumns;
  }
}

final dataColumnsProvider =
    StateNotifierProvider<DataColumnsNotifier, List<DataColumn>>((ref) {
  return DataColumnsNotifier();
});