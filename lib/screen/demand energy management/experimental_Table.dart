import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:web_appllication/style.dart';

class ExperimentalTable extends StatefulWidget {
  const ExperimentalTable({super.key});

  @override
  State<ExperimentalTable> createState() => _ExperimentalTableState();
}

class _ExperimentalTableState extends State<ExperimentalTable> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final tableHeadingColor = Colors.blue;
  final tableRowColor = Colors.white;

  List<List<dynamic>> rows = [
    ['SrNo.', 'CityName', 'DepoName', 'Energy\nConsumed']
  ];
  List<dynamic> columnNames = [
    'SrNo.',
    'CityName',
    'DepoName',
    'Energy\nConsumed'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 400,
              width: 600,
              child: AnimatedList(
                key: _listKey,
                initialItemCount: rows.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: Container(
                      decoration:
                          BoxDecoration(color: index == 0 ? Colors.blue : null),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: List.generate(rows[0].length, (index2) {
                            return Container(
                                alignment: Alignment.center,
                                width: index2 == 0
                                    ? 60
                                    : index2 == 1
                                        ? 180
                                        : index2 == 2
                                            ? 200
                                            : index2 == 3
                                                ? 130
                                                : null,
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  rows[index][index2],
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: index == 0 ? white : black,
                                      fontWeight: FontWeight.bold),
                                ));
                          }),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 30, right: 20),
                child: const Divider())
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem();
        },
        child: Icon(Icons.abc),
      ),
    );
  }

  void addItem() async {
    int index = rows.length;
    rows.add(
      ['1', 'Row 2', 'Row 3', 'Row 4'],
    );
    _listKey.currentState!.insertItem(index);
  }

  Widget buildItem(List<dynamic> items, Animation<double> animation) {
    return Material(
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              return Container(
                color: Colors.green,
                height: 40,
                child:
                    Text(textAlign: TextAlign.center, items[index].toString()),
              );
            })),
      ),
    );
  }
}
