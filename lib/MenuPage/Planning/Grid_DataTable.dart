import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:web_appllication/MenuPage/Planning/datasource/employee_datasouce.dart';
import 'package:web_appllication/MenuPage/Planning/model/employee.dart';
import 'package:web_appllication/style.dart';

void main() {
  runApp(StatutoryAproval());
}

/// The application that contains datagrid on it.

/// The home page of the application which hosts the datagrid.
class StatutoryAproval extends StatefulWidget {
  /// Creates the home page.
  const StatutoryAproval({Key? key}) : super(key: key);

  @override
  _StatutoryAprovalState createState() => _StatutoryAprovalState();
}

class _StatutoryAprovalState extends State<StatutoryAproval> {
  late EmployeeDataSource _employeeDataSource;
  List<Employee> _employees = <Employee>[];
  late DataGridController _dataGridController;

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
    _dataGridController = DataGridController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfDataGrid(
        source: _employeeDataSource,
        allowEditing: true,
        selectionMode: SelectionMode.single,
        navigationMode: GridNavigationMode.cell,
        columnWidthMode: ColumnWidthMode.fill,
        controller: _dataGridController,
        onQueryRowHeight: (details) {
          return details.rowIndex == 0 ? 60.0 : 49.0;
        },
        columns: [
          GridColumn(
            columnName: 'srNo',
            allowEditing: false,
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'S No',
                overflow: TextOverflow.values.first,
                //    textAlign: TextAlign.center,
              ),
            ),
          ),
          GridColumn(
            columnName: 'approval',
            allowEditing: false,
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'Detail of approval',
                overflow: TextOverflow.values.first,
              ),
            ),
          ),
          GridColumn(
            columnName: 'weightage',
            allowEditing: true,
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'weightage',
                overflow: TextOverflow.values.first,
              ),
            ),
          ),
          GridColumn(
            columnName: 'applicability',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'Applicability',
                overflow: TextOverflow.values.first,
              ),
            ),
          ),
          GridColumn(
            columnName: 'authority',
            label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'Approving Authority',
                overflow: TextOverflow.values.first,
              ),
            ),
          ),
          GridColumn(
            columnName: 'currentStatusPerc',
            allowEditing: false,
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'current Status in % for Approval',
                overflow: TextOverflow.values.first,
              ),
            ),
          ),
          GridColumn(
            columnName: 'Overallweightage',
            allowEditing: true,
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'Overall Weightage',
                overflow: TextOverflow.values.first,
              ),
            ),
          ),
          GridColumn(
            columnName: 'currentStatus',
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'Current Status',
                overflow: TextOverflow.values.first,
              ),
            ),
          ),
          GridColumn(
            columnName: 'listDocument',
            allowEditing: false,
            label: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                'List Of Document Required',
                overflow: TextOverflow.values.first,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(1, 'Environment Clearance', 10, 'Yes', 'JKPCC', '10%', 1,
          'In Progress', 'Traffic Plan'),
      Employee(2, 'Environment Clearance', 10, 'Yes', 'JKPCC', '10%', 1,
          'In Progress', 'Traffic Plan'),
      Employee(3, 'Environment Clearance', 10, 'Yes', 'JKPCC', '10%', 1,
          'In Progress', 'Traffic Plan'),
      Employee(4, 'Environment Clearance', 10, 'Yes', 'JKPCC', '10%', 1,
          'In Progress', 'Traffic Plan'),
    ];
  }
}
