import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../style.dart';

class DateRange extends StatelessWidget {
  const DateRange({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: blue)),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('choose Date'),
                          content: SizedBox(
                            width: 400,
                            height: 500,
                            child: SfDateRangePicker(
                              view: DateRangePickerView.month,
                              showTodayButton: false,
                              showActionButtons: true,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs args) {
                                if (args.value is PickerDateRange) {
                                  // rangestartDate = args.value.startDate;
                                }
                              },
                              onSubmit: (value) {
                                // setState(() {
                                //   startdate =
                                //       DateTime.parse(value.toString());
                                // });
                                Navigator.pop(context);
                              },
                              onCancel: () {},
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.today)),
                Text(DateFormat.yMMMd().format(DateTime.now()))
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 250,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: blue)),
            child:
                Center(child: Text(DateFormat.yMMMd().format(DateTime.now()))),
          )
        ],
      ),
    );
  }
}
