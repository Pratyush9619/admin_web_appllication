import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animated Table'),
        ),
        body: AnimatedTable(),
      ),
    );
  }
}

class AnimatedTable extends StatefulWidget {
  @override
  _AnimatedTableState createState() => _AnimatedTableState();
}

class _AnimatedTableState extends State<AnimatedTable> {
  List<String> items = ['Row 1', 'Row 2', 'Row 3'];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) {
                return buildItem(items[index], animation);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  addItem();
                },
                child: const Text('Add Row'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  removeItem();
                },
                child: const Text('Remove Row'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildItem(String item, Animation<double> animation) {
    return Material(
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: ListTile(
          title: Text(item),
        ),
      ),
    );
  }

  void addItem() {
    int index = items.length;
    items.add('Row ${index + 1}');
    _listKey.currentState!.insertItem(index);
  }

  void removeItem() {
    int index = items.length - 1;
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => buildItem(items[index], animation),
    );
    items.removeAt(index);
  }
}
