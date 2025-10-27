import 'package:flutter/material.dart';

class UiTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;

  const UiTable({Key? key, required this.columns, required this.rows}) : super(key: key);

  @override
  Widget build(BuildContext context) => DataTable(columns: columns, rows: rows);
}

