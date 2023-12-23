import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/provider/demandEnergyProvider.dart';
import 'package:web_appllication/screen/demand%20energy%20management/demand%20energy%20management/bar_graph.dart';
import 'package:web_appllication/screen/demand%20energy%20management/demand%20energy%20management/demand_table.dart';

class DemandEnergyScreen extends StatefulWidget {
  const DemandEnergyScreen({super.key});

  @override
  State<DemandEnergyScreen> createState() => _DemandEnergyScreenState();
}

class _DemandEnergyScreenState extends State<DemandEnergyScreen> {
  List<String> serialNums = [];
  List<dynamic> energyConsumedList = [];
  //Data table columns & rows
  List<String> columns = [
    'Sr.No.',
    'CityName',
    'Depot',
    'Energy Consumed\n(in kW)'
  ];

  List<List<dynamic>> rows = [
    [1, 'Delhi', 'Nehru Place', '1500'],
    [2, 'Delhi', 'Sukhdev Vihar', '2500'],
    [3, 'Delhi', 'KalKaji', '2400'],
    [4, 'Delhi', 'Subhash Place', '2300'],
    [5, 'Delhi', 'Wazirpur', '2550'],
    [6, 'Delhi', 'Rohini-1', '2500'],
  ];

  List<String> quaterlyMonths = ['Mar', 'Jun', 'Sep', 'Dec'];

  final currentDate = DateTime.now();
  final currentDay = DateFormat.yMMMMd().format(DateTime.now());
  final currentYear = DateTime.now().year;

  dynamic currentMonth;

  @override
  Widget build(BuildContext context) {
    currentMonth = DateFormat('MMMM').format(currentDate);
    print(currentMonth);
    print(currentDay);

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: DemandTable(
                callBackFunction: getCurrentDayData,
                columns: columns,
                rows: rows,
                energyConsumedList: energyConsumedList,
                serialNums: serialNums),
          ),
          const SizedBox(
            width: 20,
          ),
          const Expanded(
            child: BarGraphScreen(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(Provider.of<DemandEnergyProvider>(context, listen: false)
              .selectedDepo);
        },
        child: Icon(Icons.ad_units),
      ),
    );
  }

  Future<void> getCurrentDayData() async {
    try {
      print('Callback Called');
      final selectedDepoName =
          Provider.of<DemandEnergyProvider>(context, listen: false)
              .selectedDepo;
      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('EnergyManagementTable')
          .doc(selectedDepoName)
          .collection('Year')
          .doc(currentYear.toString())
          .collection('Months')
          .doc(currentMonth)
          .collection('Date')
          .doc(currentDay)
          .collection('UserId');

      QuerySnapshot querySnapshot = await collectionReference.get();

      List<dynamic> allUsers =
          querySnapshot.docs.map((userid) => userid.id).toList();
      for (int i = 0; i < allUsers.length; i++) {
        DocumentSnapshot daySnap =
            await collectionReference.doc(allUsers[i]).get();
        Map<String, dynamic> mapData = daySnap.data() as Map<String, dynamic>;
        serialNums.add(mapData['srNo']);
        energyConsumedList.add(mapData['enrgyConsumed']);
      }
    } catch (_) {
      print('Error Occured');
    }
  }
}
