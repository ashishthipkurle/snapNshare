import 'package:flutter/material.dart';

class UiPagination extends StatelessWidget {
  final int page;
  final int total;

  const UiPagination({Key? key, this.page = 1, this.total = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Page $page of $total');
  }
}

