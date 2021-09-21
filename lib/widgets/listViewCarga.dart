// @dart=2.9
import 'package:flutter/material.dart';

import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListViewBuilder<T> extends StatelessWidget {
  final List<T> lista;
  final ItemWidgetBuilder<T> itemBuilder;
  const ListViewBuilder({Key key, this.lista, this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lista.isEmpty) {
      return EmptyContent(
        title: ":(",
        message: "No hay elemntos agregados",
      );
    } else {
      return _buildList(lista);
    }
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        height: 0.5,
        thickness: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
    );
  }
}
