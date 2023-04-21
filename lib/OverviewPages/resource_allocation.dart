import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_appllication/provider/text_provider.dart';

import '../components/loading_page.dart';
import '../style.dart';

class ResourceAllocation extends StatefulWidget {
  String? cityName;
  String? depoName;
  ResourceAllocation({super.key, this.cityName, this.depoName});

  @override
  State<ResourceAllocation> createState() => _ResourceAllocationState();
}

class _ResourceAllocationState extends State<ResourceAllocation> {
  TextEditingController? _textEditingController;
  TextEditingController? _textEditingController2,
      _textEditingController3,
      _textEditingController5,
      _textEditingController4,
      _textEditingController6,
      _textEditingController7,
      _textEditingController71,
      _textEditingController72,
      _textEditingController8,
      _textEditingController9,
      _textEditingController10,
      _textEditingController101,
      _textEditingController102,
      _textEditingController11,
      _textEditingController12;

  textprovider? _textprovider;
  String? data1,
      data2,
      data3,
      data4,
      data5,
      data6,
      data7,
      data71,
      data72,
      data8,
      data9,
      data10,
      data101,
      data102,
      data11,
      data12;

  @override
  void initState() {
    final textprovider _textprovider =
        Provider.of<textprovider>(context, listen: false);
    super.initState();
    _textEditingController =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController2 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController3 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController4 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController5 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController6 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController7 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController71 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController72 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController8 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController9 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController10 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController101 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController102 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController11 =
        TextEditingController(text: _textprovider.changedata);
    _textEditingController12 =
        TextEditingController(text: _textprovider.changedata);
  }

  @override
  void dispose() {
    _textEditingController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textprovider _textprovider = Provider.of<textprovider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.cityName} / ${widget.depoName} / Key Events '),
          backgroundColor: blue,
        ),
        body: const Scaffold(
          body: Center(
            child: Text(
              'Testing & Commissioning flow \n Under Process',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        )

        // StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection('ResourceAllocation')
        //       .snapshots(),
        //   builder: ((context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //           itemCount: snapshot.data!.docs.length,
        //           itemBuilder: (context, index) {
        //             return Consumer<textprovider>(
        //                 builder: (context, value, child) {
        //               return Column(
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.all(10.0),
        //                     child: Column(
        //                       children: [
        //                         Container(
        //                           width: 750,
        //                           padding: const EdgeInsets.all(0),
        //                           decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(10),
        //                               border: Border.all(color: blue),
        //                               color: blue),
        //                           child: Center(
        //                             child: TextField(
        //                               maxLines: 1,
        //                               textInputAction: TextInputAction.done,
        //                               minLines: 1,
        //                               autofocus: false,
        //                               textAlign: TextAlign.center,
        //                               style:
        //                                   TextStyle(color: white, fontSize: 20),
        //                               // onTap: (() => textprovider().editname()),
        //                               onChanged: (value) {
        //                                 value = textprovider().editname();
        //                                 data12 = value;
        //                               },
        //                               controller: _textEditingController12!
        //                                 ..text =
        //                                     'Head Bussiness Operation (Mr. R.K Singh)',
        //                             ),

        //                             // Text(
        //                             //   'Head Bussiness Operation (Mr. R.K Singh) ',
        //                             //   style: TextStyle(color: white, fontSize: 20),
        //                             // ),
        //                           ),
        //                         ),
        //                         Row(
        //                           children: [
        //                             Expanded(
        //                               child: Column(
        //                                 children: [
        //                                   const Icon(
        //                                       Icons.arrow_downward_outlined),
        //                                   Container(
        //                                     height: 75,
        //                                     width: 370,
        //                                     padding: const EdgeInsets.all(0),
        //                                     decoration: BoxDecoration(
        //                                         borderRadius:
        //                                             BorderRadius.circular(10),
        //                                         border: Border.all(color: blue),
        //                                         color: blue),
        //                                     child: Center(
        //                                       child: TextField(
        //                                         maxLines: 2,
        //                                         textInputAction:
        //                                             TextInputAction.done,
        //                                         minLines: 1,
        //                                         autofocus: false,
        //                                         textAlign: TextAlign.center,
        //                                         style: TextStyle(
        //                                             color: white, fontSize: 16),
        //                                         // onTap: (() => textprovider().editname()),

        //                                         onChanged: (value) {
        //                                           data1 =
        //                                               _textEditingController!
        //                                                   .text;
        //                                         },

        //                                         controller: _textEditingController!
        //                                           ..text =
        //                                               'GP Head  Bus Project and O & M Mr. Nilesh G Shivankar',
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   Container(
        //                                     height: 250,
        //                                     child: Row(
        //                                       mainAxisAlignment:
        //                                           MainAxisAlignment.spaceAround,
        //                                       children: [
        //                                         Expanded(
        //                                           child: Column(
        //                                             children: [
        //                                               Icon(Icons
        //                                                   .arrow_downward_outlined),
        //                                               Container(
        //                                                 height: 75,
        //                                                 width: 230,
        //                                                 decoration: BoxDecoration(
        //                                                     borderRadius:
        //                                                         BorderRadius
        //                                                             .circular(
        //                                                                 10),
        //                                                     border: Border.all(
        //                                                         color: blue),
        //                                                     color: blue),
        //                                                 child: Center(
        //                                                   child: TextField(
        //                                                     maxLines: 2,
        //                                                     textInputAction:
        //                                                         TextInputAction
        //                                                             .done,
        //                                                     minLines: 1,
        //                                                     autofocus: false,
        //                                                     textAlign: TextAlign
        //                                                         .center,

        //                                                     style: TextStyle(
        //                                                         color: white,
        //                                                         fontSize: 16),
        //                                                     // onTap: (() =>
        //                                                     //     textprovider().editname()),
        //                                                     onChanged:
        //                                                         ((value) {
        //                                                       value =
        //                                                           textprovider()
        //                                                               .editname();
        //                                                       data2 = value;
        //                                                     }),

        //                                                     controller:
        //                                                         _textEditingController2!
        //                                                           ..text =
        //                                                               'Lead - EV Bus project Mr. Sumit Swarup Sarkar',
        //                                                   ),

        //                                                   // Text(
        //                                                   //   'Lead - EV Bus project Mr. Sumit Swarup Sarkar',
        //                                                   //   textAlign: TextAlign.center,
        //                                                   //   style: TextStyle(
        //                                                   //       color: white, fontSize: 16),
        //                                                   // ),
        //                                                 ),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         ),
        //                                         Expanded(
        //                                           child: Column(
        //                                             children: [
        //                                               Icon(Icons
        //                                                   .arrow_downward_outlined),
        //                                               Container(
        //                                                 height: 75,
        //                                                 width: 230,
        //                                                 decoration: BoxDecoration(
        //                                                     borderRadius:
        //                                                         BorderRadius
        //                                                             .circular(
        //                                                                 10),
        //                                                     border: Border.all(
        //                                                         color: blue),
        //                                                     color: blue),
        //                                                 child: Center(
        //                                                   child: TextField(
        //                                                     maxLines: 2,
        //                                                     textInputAction:
        //                                                         TextInputAction
        //                                                             .done,
        //                                                     minLines: 1,
        //                                                     autofocus: false,
        //                                                     textAlign: TextAlign
        //                                                         .center,

        //                                                     style: TextStyle(
        //                                                         color: white,
        //                                                         fontSize: 16),
        //                                                     // onTap: (() =>
        //                                                     //     textprovider().editname()),
        //                                                     onChanged:
        //                                                         ((value) {
        //                                                       value =
        //                                                           textprovider()
        //                                                               .editname();
        //                                                       data3 = value;
        //                                                     }),

        //                                                     controller:
        //                                                         _textEditingController3!
        //                                                           ..text =
        //                                                               'Lead - EV Bus project Mr. Kapil',
        //                                                   ),
        //                                                   // Text(
        //                                                   //   'Lead - EV Bus project Mr. Kapil',
        //                                                   //   textAlign: TextAlign.center,
        //                                                   //   style: TextStyle(
        //                                                   //       color: white, fontSize: 16),
        //                                                   // ),
        //                                                 ),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         )
        //                                       ],
        //                                     ),
        //                                   )
        //                                 ],
        //                               ),
        //                             ),
        //                             Expanded(
        //                               child: Column(
        //                                 children: [
        //                                   Column(
        //                                     children: [
        //                                       Icon(Icons
        //                                           .arrow_downward_outlined),
        //                                       Container(
        //                                         height: 55,
        //                                         width: 600,
        //                                         padding: EdgeInsets.all(0),
        //                                         decoration: BoxDecoration(
        //                                             borderRadius:
        //                                                 BorderRadius.circular(
        //                                                     10),
        //                                             border:
        //                                                 Border.all(color: blue),
        //                                             color: blue),
        //                                         child: Center(
        //                                           child: TextField(
        //                                             maxLines: 2,
        //                                             textInputAction:
        //                                                 TextInputAction.done,
        //                                             minLines: 1,
        //                                             autofocus: false,
        //                                             textAlign: TextAlign.center,

        //                                             style: TextStyle(
        //                                                 color: white,
        //                                                 fontSize: 16),
        //                                             // onTap: (() =>
        //                                             //     textprovider().editname()),
        //                                             onChanged: ((value) {
        //                                               value = textprovider()
        //                                                   .editname();
        //                                               data4 = value;
        //                                             }),

        //                                             controller:
        //                                                 _textEditingController4!
        //                                                   ..text =
        //                                                       'Project Manager of ${widget.cityName} Ms. Priyanka Patra',
        //                                           ),
        //                                           // Text(
        //                                           //   'Project Manager Banglore Ms. Priyanka Patra',
        //                                           //   textAlign: TextAlign.center,
        //                                           //   style:
        //                                           //       TextStyle(color: white, fontSize: 16),
        //                                           // ),
        //                                         ),
        //                                       ),
        //                                       Row(
        //                                         mainAxisAlignment:
        //                                             MainAxisAlignment
        //                                                 .spaceAround,
        //                                         children: [
        //                                           Expanded(
        //                                             child: Column(
        //                                               children: [
        //                                                 Icon(Icons
        //                                                     .arrow_downward_outlined),
        //                                                 Container(
        //                                                   height: 55,
        //                                                   width: 180,
        //                                                   padding:
        //                                                       EdgeInsets.all(0),
        //                                                   decoration: BoxDecoration(
        //                                                       borderRadius:
        //                                                           BorderRadius
        //                                                               .circular(
        //                                                                   10),
        //                                                       border:
        //                                                           Border.all(
        //                                                               color:
        //                                                                   blue),
        //                                                       color: blue),
        //                                                   child: Center(
        //                                                     child: TextField(
        //                                                       maxLines: 2,
        //                                                       textInputAction:
        //                                                           TextInputAction
        //                                                               .done,
        //                                                       minLines: 1,
        //                                                       autofocus: false,
        //                                                       textAlign:
        //                                                           TextAlign
        //                                                               .center,

        //                                                       style: TextStyle(
        //                                                           color: white,
        //                                                           fontSize: 16),
        //                                                       // onTap: (() =>
        //                                                       //     textprovider().editname()),
        //                                                       onChanged:
        //                                                           ((value) {
        //                                                         value = textprovider()
        //                                                             .editname();
        //                                                         data5 = value;
        //                                                       }),

        //                                                       controller:
        //                                                           _textEditingController5!
        //                                                             ..text =
        //                                                                 'Electrical Engineer',
        //                                                     ),
        //                                                     // Text(
        //                                                     //   'Electrical Engineer',
        //                                                     //   textAlign: TextAlign.center,
        //                                                     //   style: TextStyle(
        //                                                     //       color: white, fontSize: 16),
        //                                                     // ),
        //                                                   ),
        //                                                 ),
        //                                                 Column(
        //                                                   children: [
        //                                                     Icon(Icons
        //                                                         .arrow_downward_outlined),
        //                                                     Container(
        //                                                       height: 55,
        //                                                       width: 180,
        //                                                       padding:
        //                                                           EdgeInsets
        //                                                               .all(0),
        //                                                       decoration: BoxDecoration(
        //                                                           borderRadius:
        //                                                               BorderRadius
        //                                                                   .circular(
        //                                                                       10),
        //                                                           border: Border
        //                                                               .all(
        //                                                                   color:
        //                                                                       blue),
        //                                                           color: blue),
        //                                                       child: Center(
        //                                                         child:
        //                                                             TextField(
        //                                                           maxLines: 2,
        //                                                           textInputAction:
        //                                                               TextInputAction
        //                                                                   .done,
        //                                                           minLines: 1,
        //                                                           autofocus:
        //                                                               false,
        //                                                           textAlign:
        //                                                               TextAlign
        //                                                                   .center,

        //                                                           style: TextStyle(
        //                                                               color:
        //                                                                   white,
        //                                                               fontSize:
        //                                                                   16),
        //                                                           // onTap: (() =>
        //                                                           //     textprovider().editname()),
        //                                                           onChanged:
        //                                                               ((value) {
        //                                                             value = textprovider()
        //                                                                 .editname();
        //                                                             data6 =
        //                                                                 value;
        //                                                           }),

        //                                                           controller:
        //                                                               _textEditingController6!
        //                                                                 ..text =
        //                                                                     'Electrical',
        //                                                         ),
        //                                                         //  Text(
        //                                                         //   'Electrical',
        //                                                         //   textAlign:
        //                                                         //       TextAlign.center,
        //                                                         //   style: TextStyle(
        //                                                         //       color: white,
        //                                                         //       fontSize: 16),
        //                                                         // ),
        //                                                       ),
        //                                                     ),
        //                                                   ],
        //                                                 ),
        //                                                 Column(
        //                                                   children: [
        //                                                     Icon(Icons
        //                                                         .arrow_downward_outlined),
        //                                                     Container(
        //                                                       height: 100,
        //                                                       padding:
        //                                                           EdgeInsets
        //                                                               .all(0),
        //                                                       decoration: BoxDecoration(
        //                                                           borderRadius:
        //                                                               BorderRadius
        //                                                                   .circular(
        //                                                                       10),
        //                                                           border: Border
        //                                                               .all(
        //                                                                   color:
        //                                                                       blue),
        //                                                           color: blue),
        //                                                       child: Center(
        //                                                         child: Column(
        //                                                           children: [
        //                                                             Flexible(
        //                                                               child:
        //                                                                   TextField(
        //                                                                 maxLines:
        //                                                                     1,
        //                                                                 textInputAction:
        //                                                                     TextInputAction.done,
        //                                                                 minLines:
        //                                                                     1,
        //                                                                 autofocus:
        //                                                                     false,
        //                                                                 textAlign:
        //                                                                     TextAlign.center,

        //                                                                 style: TextStyle(
        //                                                                     color:
        //                                                                         white,
        //                                                                     fontSize:
        //                                                                         16),
        //                                                                 // onTap: (() =>
        //                                                                 //     textprovider().editname()),
        //                                                                 onChanged:
        //                                                                     ((value) {
        //                                                                   value =
        //                                                                       textprovider().editname();
        //                                                                   data7 =
        //                                                                       value;
        //                                                                 }),

        //                                                                 controller: _textEditingController7!
        //                                                                   ..text =
        //                                                                       'Vendor Name : Bhavya',
        //                                                               ),
        //                                                             ),
        //                                                             // Row(
        //                                                             //   children: [
        //                                                             //     Text(
        //                                                             //       'Propritor Name:',
        //                                                             //       textAlign:
        //                                                             //           TextAlign.center,
        //                                                             //       style: TextStyle(
        //                                                             //           color: white,
        //                                                             //           fontSize: 16),
        //                                                             //     ),
        //                                                             //     Text(
        //                                                             //       ' Amir Khan',
        //                                                             //       textAlign:
        //                                                             //           TextAlign.center,
        //                                                             //       style: TextStyle(
        //                                                             //           color: white,
        //                                                             //           fontSize: 16),
        //                                                             //     ),
        //                                                             //   ],
        //                                                             // ),
        //                                                             Flexible(
        //                                                               child:
        //                                                                   TextField(
        //                                                                 maxLines:
        //                                                                     1,
        //                                                                 textInputAction:
        //                                                                     TextInputAction.done,
        //                                                                 minLines:
        //                                                                     1,
        //                                                                 autofocus:
        //                                                                     false,
        //                                                                 textAlign:
        //                                                                     TextAlign.center,

        //                                                                 style: TextStyle(
        //                                                                     color:
        //                                                                         white,
        //                                                                     fontSize:
        //                                                                         16),
        //                                                                 // onTap: (() =>
        //                                                                 //     textprovider().editname()),
        //                                                                 onChanged:
        //                                                                     ((value) {
        //                                                                   value =
        //                                                                       textprovider().editname();
        //                                                                   data71 =
        //                                                                       value;
        //                                                                 }),

        //                                                                 controller: _textEditingController71!
        //                                                                   ..text =
        //                                                                       'Vendor Name : Amir Khan',
        //                                                               ),
        //                                                             ),
        //                                                             Flexible(
        //                                                               child:
        //                                                                   TextField(
        //                                                                 maxLines:
        //                                                                     1,
        //                                                                 textInputAction:
        //                                                                     TextInputAction.done,
        //                                                                 minLines:
        //                                                                     1,
        //                                                                 autofocus:
        //                                                                     false,
        //                                                                 textAlign:
        //                                                                     TextAlign.center,

        //                                                                 style: TextStyle(
        //                                                                     color:
        //                                                                         white,
        //                                                                     fontSize:
        //                                                                         16),
        //                                                                 // onTap: (() =>
        //                                                                 //     textprovider().editname()),
        //                                                                 onChanged:
        //                                                                     ((value) {
        //                                                                   value =
        //                                                                       textprovider().editname();
        //                                                                   data72 =
        //                                                                       value;
        //                                                                 }),

        //                                                                 controller: _textEditingController72!
        //                                                                   ..text =
        //                                                                       'Vendor Name : 10',
        //                                                               ),
        //                                                               //  Row(
        //                                                               //   children: [
        //                                                               //     Text(
        //                                                               //       'Man Power Involved :',
        //                                                               //       textAlign:
        //                                                               //           TextAlign.center,
        //                                                               //       style: TextStyle(
        //                                                               //           color: white,
        //                                                               //           fontSize: 16),
        //                                                               //     ),
        //                                                               //     Text(
        //                                                               //       ' 10',
        //                                                               //       textAlign:
        //                                                               //           TextAlign.center,
        //                                                               //       style: TextStyle(
        //                                                               //           color: white,
        //                                                               //           fontSize: 16),
        //                                                               //     ),
        //                                                               //   ],
        //                                                               // ),
        //                                                             )
        //                                                           ],
        //                                                         ),
        //                                                       ),
        //                                                     ),
        //                                                   ],
        //                                                 )
        //                                               ],
        //                                             ),
        //                                           ),
        //                                           Padding(
        //                                               padding:
        //                                                   EdgeInsets.all(10)),
        //                                           Expanded(
        //                                             child: Column(
        //                                               children: [
        //                                                 Icon(Icons
        //                                                     .arrow_downward_outlined),
        //                                                 Container(
        //                                                   height: 55,
        //                                                   width: 180,
        //                                                   padding:
        //                                                       EdgeInsets.all(0),
        //                                                   decoration: BoxDecoration(
        //                                                       borderRadius:
        //                                                           BorderRadius
        //                                                               .circular(
        //                                                                   10),
        //                                                       border:
        //                                                           Border.all(
        //                                                               color:
        //                                                                   blue),
        //                                                       color: blue),
        //                                                   child: Center(
        //                                                     child: TextField(
        //                                                       maxLines: 2,
        //                                                       textInputAction:
        //                                                           TextInputAction
        //                                                               .done,
        //                                                       minLines: 1,
        //                                                       autofocus: false,
        //                                                       textAlign:
        //                                                           TextAlign
        //                                                               .center,

        //                                                       style: TextStyle(
        //                                                           color: white,
        //                                                           fontSize: 16),
        //                                                       // onTap: (() =>
        //                                                       //     textprovider().editname()),
        //                                                       onChanged:
        //                                                           ((value) {
        //                                                         value = textprovider()
        //                                                             .editname();
        //                                                         data8 = value;
        //                                                       }),

        //                                                       controller:
        //                                                           _textEditingController8!
        //                                                             ..text =
        //                                                                 'Civil Engineer',
        //                                                     ),

        //                                                     // Text(
        //                                                     //   'Civil Engineer',
        //                                                     //   textAlign: TextAlign.center,
        //                                                     //   style: TextStyle(
        //                                                     //       color: white, fontSize: 16),
        //                                                     // ),
        //                                                   ),
        //                                                 ),
        //                                                 Column(
        //                                                   children: [
        //                                                     Icon(Icons
        //                                                         .arrow_downward_outlined),
        //                                                     Container(
        //                                                       height: 55,
        //                                                       width: 180,
        //                                                       padding:
        //                                                           EdgeInsets
        //                                                               .all(0),
        //                                                       decoration: BoxDecoration(
        //                                                           borderRadius:
        //                                                               BorderRadius
        //                                                                   .circular(
        //                                                                       10),
        //                                                           border: Border
        //                                                               .all(
        //                                                                   color:
        //                                                                       blue),
        //                                                           color: blue),
        //                                                       child: Center(
        //                                                         child:
        //                                                             TextField(
        //                                                           maxLines: 2,
        //                                                           textInputAction:
        //                                                               TextInputAction
        //                                                                   .done,
        //                                                           minLines: 1,
        //                                                           autofocus:
        //                                                               false,
        //                                                           textAlign:
        //                                                               TextAlign
        //                                                                   .center,

        //                                                           style: TextStyle(
        //                                                               color:
        //                                                                   white,
        //                                                               fontSize:
        //                                                                   16),
        //                                                           // onTap: (() =>
        //                                                           //     textprovider().editname()),
        //                                                           onChanged:
        //                                                               ((value) {
        //                                                             value = textprovider()
        //                                                                 .editname();
        //                                                             data9 =
        //                                                                 value;
        //                                                           }),

        //                                                           controller:
        //                                                               _textEditingController9!
        //                                                                 ..text =
        //                                                                     'Civil',
        //                                                         ),

        //                                                         // Text(
        //                                                         //   'Civil',
        //                                                         //   textAlign:
        //                                                         //       TextAlign.center,
        //                                                         //   style: TextStyle(
        //                                                         //       color: white,
        //                                                         //       fontSize: 16),
        //                                                         // ),
        //                                                       ),
        //                                                     ),
        //                                                   ],
        //                                                 ),
        //                                                 Column(
        //                                                   children: [
        //                                                     Icon(Icons
        //                                                         .arrow_downward_outlined),
        //                                                     Container(
        //                                                       height: 100,
        //                                                       padding:
        //                                                           EdgeInsets
        //                                                               .all(0),
        //                                                       decoration: BoxDecoration(
        //                                                           borderRadius:
        //                                                               BorderRadius
        //                                                                   .circular(
        //                                                                       10),
        //                                                           border: Border
        //                                                               .all(
        //                                                                   color:
        //                                                                       blue),
        //                                                           color: blue),
        //                                                       child: Center(
        //                                                         child: Column(
        //                                                           children: [
        //                                                             Flexible(
        //                                                               child:
        //                                                                   TextField(
        //                                                                 maxLines:
        //                                                                     1,
        //                                                                 textInputAction:
        //                                                                     TextInputAction.done,
        //                                                                 minLines:
        //                                                                     1,
        //                                                                 autofocus:
        //                                                                     false,
        //                                                                 textAlign:
        //                                                                     TextAlign.center,

        //                                                                 style: TextStyle(
        //                                                                     color:
        //                                                                         white,
        //                                                                     fontSize:
        //                                                                         16),
        //                                                                 // onTap: (() =>
        //                                                                 //     textprovider().editname()),
        //                                                                 onChanged:
        //                                                                     ((value) {
        //                                                                   value =
        //                                                                       textprovider().editname();
        //                                                                   data10 =
        //                                                                       value;
        //                                                                 }),

        //                                                                 controller: _textEditingController10!
        //                                                                   ..text =
        //                                                                       'Vendor Name: Bhavya ',
        //                                                               ),
        //                                                             ),
        //                                                             Flexible(
        //                                                               child:
        //                                                                   TextField(
        //                                                                 maxLines:
        //                                                                     1,
        //                                                                 textInputAction:
        //                                                                     TextInputAction.done,
        //                                                                 minLines:
        //                                                                     1,
        //                                                                 autofocus:
        //                                                                     false,
        //                                                                 textAlign:
        //                                                                     TextAlign.center,

        //                                                                 style: TextStyle(
        //                                                                     color:
        //                                                                         white,
        //                                                                     fontSize:
        //                                                                         16),
        //                                                                 // onTap: (() =>
        //                                                                 //     textprovider().editname()),
        //                                                                 onChanged:
        //                                                                     ((value) {
        //                                                                   value =
        //                                                                       textprovider().editname();
        //                                                                   data101 =
        //                                                                       value;
        //                                                                 }),

        //                                                                 controller: _textEditingController101!
        //                                                                   ..text =
        //                                                                       'Vendor Name : Amir Khan',
        //                                                               ),
        //                                                             ),
        //                                                             Flexible(
        //                                                               child:
        //                                                                   TextField(
        //                                                                 maxLines:
        //                                                                     1,
        //                                                                 textInputAction:
        //                                                                     TextInputAction.done,
        //                                                                 minLines:
        //                                                                     1,
        //                                                                 autofocus:
        //                                                                     false,
        //                                                                 textAlign:
        //                                                                     TextAlign.center,

        //                                                                 style: TextStyle(
        //                                                                     color:
        //                                                                         white,
        //                                                                     fontSize:
        //                                                                         16),
        //                                                                 // onTap: (() =>
        //                                                                 //     textprovider().editname()),
        //                                                                 onChanged:
        //                                                                     ((value) {
        //                                                                   value =
        //                                                                       textprovider().editname();
        //                                                                   data102 =
        //                                                                       value;
        //                                                                 }),

        //                                                                 controller: _textEditingController102!
        //                                                                   ..text =
        //                                                                       'Vendor Name : 10',
        //                                                               ),
        //                                                             ),
        //                                                           ],
        //                                                         ),
        //                                                       ),
        //                                                     ),
        //                                                   ],
        //                                                 )
        //                                               ],
        //                                             ),
        //                                           ),
        //                                           Expanded(
        //                                             child: Container(
        //                                               height: 270,
        //                                               child: Column(
        //                                                 children: [
        //                                                   Icon(Icons
        //                                                       .arrow_downward_outlined),
        //                                                   Container(
        //                                                     height: 55,
        //                                                     width: 180,
        //                                                     padding:
        //                                                         EdgeInsets.all(
        //                                                             0),
        //                                                     decoration: BoxDecoration(
        //                                                         borderRadius:
        //                                                             BorderRadius
        //                                                                 .circular(
        //                                                                     10),
        //                                                         border:
        //                                                             Border.all(
        //                                                                 color:
        //                                                                     blue),
        //                                                         color: blue),
        //                                                     child: Center(
        //                                                       child: TextField(
        //                                                         maxLines: 2,
        //                                                         textInputAction:
        //                                                             TextInputAction
        //                                                                 .done,
        //                                                         minLines: 1,
        //                                                         autofocus:
        //                                                             false,
        //                                                         textAlign:
        //                                                             TextAlign
        //                                                                 .center,

        //                                                         style: TextStyle(
        //                                                             color:
        //                                                                 white,
        //                                                             fontSize:
        //                                                                 16),
        //                                                         // onTap: (() =>
        //                                                         //     textprovider().editname()),
        //                                                         onChanged:
        //                                                             ((value) {
        //                                                           // value =
        //                                                           //     textprovider().editname();
        //                                                           data11 =
        //                                                               value;
        //                                                         }),

        //                                                         controller:
        //                                                             _textEditingController11!
        //                                                               ..text =
        //                                                                   'Quality & safety Engineer',
        //                                                       ),
        //                                                       // Text(
        //                                                       //   'Quality & safety Engineer',
        //                                                       //   textAlign: TextAlign.center,
        //                                                       //   style: TextStyle(
        //                                                       //       color: white, fontSize: 16),
        //                                                       // ),
        //                                                     ),
        //                                                   ),
        //                                                 ],
        //                                               ),
        //                                             ),
        //                                           )
        //                                         ],
        //                                       )
        //                                     ],
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.only(top: 100),
        //                           child: Center(
        //                             child: ElevatedButton(
        //                               onPressed: () async {
        //                                 await FirebaseFirestore.instance
        //                                     .collection('ResourceAllocation')
        //                                     .doc(widget.depoName)
        //                                     .set({
        //                                   'data1': _textEditingController!.text,
        //                                   'data2':
        //                                       _textEditingController2!.text,
        //                                   'data3':
        //                                       _textEditingController3!.text,
        //                                   'data4':
        //                                       _textEditingController4!.text,
        //                                   'data5':
        //                                       _textEditingController5!.text,
        //                                   'data6':
        //                                       _textEditingController6!.text,
        //                                   'data7':
        //                                       _textEditingController7!.text,
        //                                   'data71':
        //                                       _textEditingController71!.text,
        //                                   'data72':
        //                                       _textEditingController72!.text,
        //                                   'data8':
        //                                       _textEditingController8!.text,
        //                                   'data9':
        //                                       _textEditingController9!.text,
        //                                   'data10':
        //                                       _textEditingController10!.text,
        //                                   'data101':
        //                                       _textEditingController101!.text,
        //                                   'data102':
        //                                       _textEditingController102!.text,
        //                                   'data11':
        //                                       _textEditingController11!.text,
        //                                   'data12':
        //                                       _textEditingController12!.text,
        //                                 });
        //                               },
        //                               child: const Text(
        //                                 'Sync',
        //                                 style: TextStyle(fontSize: 18),
        //                               ),
        //                             ),
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               );
        //             });
        //           }

        //           // Text(snapshot.data!.docs[index]['data12']);

        //           );
        //     }
        //     return LoadingPage();
        //   }),
        // )

        // cards(),
        );
  }

  cards() {
    return Consumer<textprovider>(builder: (context, value, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: 750,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: blue),
                      color: blue),
                  child: Center(
                    child: TextField(
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      minLines: 1,
                      autofocus: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: white, fontSize: 20),
                      // onTap: (() => textprovider().editname()),
                      onChanged: (value) {
                        value = textprovider().editname();
                        data12 = value;
                      },
                      controller: _textEditingController12!
                        ..text = 'Head Bussiness Operation (Mr. R.K Singh)',
                    ),

                    // Text(
                    //   'Head Bussiness Operation (Mr. R.K Singh) ',
                    //   style: TextStyle(color: white, fontSize: 20),
                    // ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Icon(Icons.arrow_downward_outlined),
                          Container(
                            height: 75,
                            width: 370,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: blue),
                                color: blue),
                            child: Center(
                              child: TextField(
                                maxLines: 2,
                                textInputAction: TextInputAction.done,
                                minLines: 1,
                                autofocus: false,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: white, fontSize: 16),
                                // onTap: (() => textprovider().editname()),

                                onChanged: (value) {
                                  data1 = _textEditingController!.text;
                                },

                                controller: _textEditingController!
                                  ..text =
                                      'GP Head  Bus Project and O & M Mr. Nilesh G Shivankar',
                              ),
                            ),
                          ),
                          Container(
                            height: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(Icons.arrow_downward_outlined),
                                      Container(
                                        height: 75,
                                        width: 230,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(color: blue),
                                            color: blue),
                                        child: Center(
                                          child: TextField(
                                            maxLines: 2,
                                            textInputAction:
                                                TextInputAction.done,
                                            minLines: 1,
                                            autofocus: false,
                                            textAlign: TextAlign.center,

                                            style: TextStyle(
                                                color: white, fontSize: 16),
                                            // onTap: (() =>
                                            //     textprovider().editname()),
                                            onChanged: ((value) {
                                              value = textprovider().editname();
                                              data2 = value;
                                            }),

                                            controller: _textEditingController2!
                                              ..text =
                                                  'Lead - EV Bus project Mr. Sumit Swarup Sarkar',
                                          ),

                                          // Text(
                                          //   'Lead - EV Bus project Mr. Sumit Swarup Sarkar',
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       color: white, fontSize: 16),
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Icon(Icons.arrow_downward_outlined),
                                      Container(
                                        height: 75,
                                        width: 230,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(color: blue),
                                            color: blue),
                                        child: Center(
                                          child: TextField(
                                            maxLines: 2,
                                            textInputAction:
                                                TextInputAction.done,
                                            minLines: 1,
                                            autofocus: false,
                                            textAlign: TextAlign.center,

                                            style: TextStyle(
                                                color: white, fontSize: 16),
                                            // onTap: (() =>
                                            //     textprovider().editname()),
                                            onChanged: ((value) {
                                              value = textprovider().editname();
                                              data3 = value;
                                            }),

                                            controller: _textEditingController3!
                                              ..text =
                                                  'Lead - EV Bus project Mr. Kapil',
                                          ),
                                          // Text(
                                          //   'Lead - EV Bus project Mr. Kapil',
                                          //   textAlign: TextAlign.center,
                                          //   style: TextStyle(
                                          //       color: white, fontSize: 16),
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Icon(Icons.arrow_downward_outlined),
                              Container(
                                height: 55,
                                width: 600,
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: blue),
                                    color: blue),
                                child: Center(
                                  child: TextField(
                                    maxLines: 2,
                                    textInputAction: TextInputAction.done,
                                    minLines: 1,
                                    autofocus: false,
                                    textAlign: TextAlign.center,

                                    style:
                                        TextStyle(color: white, fontSize: 16),
                                    // onTap: (() =>
                                    //     textprovider().editname()),
                                    onChanged: ((value) {
                                      value = textprovider().editname();
                                      data4 = value;
                                    }),

                                    controller: _textEditingController4!
                                      ..text =
                                          'Project Manager of ${widget.cityName} Ms. Priyanka Patra',
                                  ),
                                  // Text(
                                  //   'Project Manager Banglore Ms. Priyanka Patra',
                                  //   textAlign: TextAlign.center,
                                  //   style:
                                  //       TextStyle(color: white, fontSize: 16),
                                  // ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Icon(Icons.arrow_downward_outlined),
                                        Container(
                                          height: 55,
                                          width: 180,
                                          padding: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(color: blue),
                                              color: blue),
                                          child: Center(
                                            child: TextField(
                                              maxLines: 2,
                                              textInputAction:
                                                  TextInputAction.done,
                                              minLines: 1,
                                              autofocus: false,
                                              textAlign: TextAlign.center,

                                              style: TextStyle(
                                                  color: white, fontSize: 16),
                                              // onTap: (() =>
                                              //     textprovider().editname()),
                                              onChanged: ((value) {
                                                value =
                                                    textprovider().editname();
                                                data5 = value;
                                              }),

                                              controller:
                                                  _textEditingController5!
                                                    ..text =
                                                        'Electrical Engineer',
                                            ),
                                            // Text(
                                            //   'Electrical Engineer',
                                            //   textAlign: TextAlign.center,
                                            //   style: TextStyle(
                                            //       color: white, fontSize: 16),
                                            // ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.arrow_downward_outlined),
                                            Container(
                                              height: 55,
                                              width: 180,
                                              padding: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border:
                                                      Border.all(color: blue),
                                                  color: blue),
                                              child: Center(
                                                child: TextField(
                                                  maxLines: 2,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  minLines: 1,
                                                  autofocus: false,
                                                  textAlign: TextAlign.center,

                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 16),
                                                  // onTap: (() =>
                                                  //     textprovider().editname()),
                                                  onChanged: ((value) {
                                                    value = textprovider()
                                                        .editname();
                                                    data6 = value;
                                                  }),

                                                  controller:
                                                      _textEditingController6!
                                                        ..text = 'Electrical',
                                                ),
                                                //  Text(
                                                //   'Electrical',
                                                //   textAlign:
                                                //       TextAlign.center,
                                                //   style: TextStyle(
                                                //       color: white,
                                                //       fontSize: 16),
                                                // ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.arrow_downward_outlined),
                                            Container(
                                              height: 100,
                                              padding: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border:
                                                      Border.all(color: blue),
                                                  color: blue),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Flexible(
                                                      child: TextField(
                                                        maxLines: 1,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        minLines: 1,
                                                        autofocus: false,
                                                        textAlign:
                                                            TextAlign.center,

                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16),
                                                        // onTap: (() =>
                                                        //     textprovider().editname()),
                                                        onChanged: ((value) {
                                                          value = textprovider()
                                                              .editname();
                                                          data7 = value;
                                                        }),

                                                        controller:
                                                            _textEditingController7!
                                                              ..text =
                                                                  'Vendor Name : Bhavya',
                                                      ),
                                                    ),
                                                    // Row(
                                                    //   children: [
                                                    //     Text(
                                                    //       'Propritor Name:',
                                                    //       textAlign:
                                                    //           TextAlign.center,
                                                    //       style: TextStyle(
                                                    //           color: white,
                                                    //           fontSize: 16),
                                                    //     ),
                                                    //     Text(
                                                    //       ' Amir Khan',
                                                    //       textAlign:
                                                    //           TextAlign.center,
                                                    //       style: TextStyle(
                                                    //           color: white,
                                                    //           fontSize: 16),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    Flexible(
                                                      child: TextField(
                                                        maxLines: 1,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        minLines: 1,
                                                        autofocus: false,
                                                        textAlign:
                                                            TextAlign.center,

                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16),
                                                        // onTap: (() =>
                                                        //     textprovider().editname()),
                                                        onChanged: ((value) {
                                                          value = textprovider()
                                                              .editname();
                                                          data71 = value;
                                                        }),

                                                        controller:
                                                            _textEditingController71!
                                                              ..text =
                                                                  'Vendor Name : Amir Khan',
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: TextField(
                                                        maxLines: 1,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        minLines: 1,
                                                        autofocus: false,
                                                        textAlign:
                                                            TextAlign.center,

                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16),
                                                        // onTap: (() =>
                                                        //     textprovider().editname()),
                                                        onChanged: ((value) {
                                                          value = textprovider()
                                                              .editname();
                                                          data72 = value;
                                                        }),

                                                        controller:
                                                            _textEditingController72!
                                                              ..text =
                                                                  'Vendor Name : 10',
                                                      ),
                                                      //  Row(
                                                      //   children: [
                                                      //     Text(
                                                      //       'Man Power Involved :',
                                                      //       textAlign:
                                                      //           TextAlign.center,
                                                      //       style: TextStyle(
                                                      //           color: white,
                                                      //           fontSize: 16),
                                                      //     ),
                                                      //     Text(
                                                      //       ' 10',
                                                      //       textAlign:
                                                      //           TextAlign.center,
                                                      //       style: TextStyle(
                                                      //           color: white,
                                                      //           fontSize: 16),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(10)),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Icon(Icons.arrow_downward_outlined),
                                        Container(
                                          height: 55,
                                          width: 180,
                                          padding: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(color: blue),
                                              color: blue),
                                          child: Center(
                                            child: TextField(
                                              maxLines: 2,
                                              textInputAction:
                                                  TextInputAction.done,
                                              minLines: 1,
                                              autofocus: false,
                                              textAlign: TextAlign.center,

                                              style: TextStyle(
                                                  color: white, fontSize: 16),
                                              // onTap: (() =>
                                              //     textprovider().editname()),
                                              onChanged: ((value) {
                                                value =
                                                    textprovider().editname();
                                                data8 = value;
                                              }),

                                              controller:
                                                  _textEditingController8!
                                                    ..text = 'Civil Engineer',
                                            ),

                                            // Text(
                                            //   'Civil Engineer',
                                            //   textAlign: TextAlign.center,
                                            //   style: TextStyle(
                                            //       color: white, fontSize: 16),
                                            // ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.arrow_downward_outlined),
                                            Container(
                                              height: 55,
                                              width: 180,
                                              padding: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border:
                                                      Border.all(color: blue),
                                                  color: blue),
                                              child: Center(
                                                child: TextField(
                                                  maxLines: 2,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  minLines: 1,
                                                  autofocus: false,
                                                  textAlign: TextAlign.center,

                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 16),
                                                  // onTap: (() =>
                                                  //     textprovider().editname()),
                                                  onChanged: ((value) {
                                                    value = textprovider()
                                                        .editname();
                                                    data9 = value;
                                                  }),

                                                  controller:
                                                      _textEditingController9!
                                                        ..text = 'Civil',
                                                ),

                                                // Text(
                                                //   'Civil',
                                                //   textAlign:
                                                //       TextAlign.center,
                                                //   style: TextStyle(
                                                //       color: white,
                                                //       fontSize: 16),
                                                // ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.arrow_downward_outlined),
                                            Container(
                                              height: 100,
                                              padding: EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border:
                                                      Border.all(color: blue),
                                                  color: blue),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Flexible(
                                                      child: TextField(
                                                        maxLines: 1,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        minLines: 1,
                                                        autofocus: false,
                                                        textAlign:
                                                            TextAlign.center,

                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16),
                                                        // onTap: (() =>
                                                        //     textprovider().editname()),
                                                        onChanged: ((value) {
                                                          value = textprovider()
                                                              .editname();
                                                          data10 = value;
                                                        }),

                                                        controller:
                                                            _textEditingController10!
                                                              ..text =
                                                                  'Vendor Name: Bhavya ',
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: TextField(
                                                        maxLines: 1,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        minLines: 1,
                                                        autofocus: false,
                                                        textAlign:
                                                            TextAlign.center,

                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16),
                                                        // onTap: (() =>
                                                        //     textprovider().editname()),
                                                        onChanged: ((value) {
                                                          value = textprovider()
                                                              .editname();
                                                          data101 = value;
                                                        }),

                                                        controller:
                                                            _textEditingController101!
                                                              ..text =
                                                                  'Vendor Name : Amir Khan',
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: TextField(
                                                        maxLines: 1,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        minLines: 1,
                                                        autofocus: false,
                                                        textAlign:
                                                            TextAlign.center,

                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 16),
                                                        // onTap: (() =>
                                                        //     textprovider().editname()),
                                                        onChanged: ((value) {
                                                          value = textprovider()
                                                              .editname();
                                                          data102 = value;
                                                        }),

                                                        controller:
                                                            _textEditingController102!
                                                              ..text =
                                                                  'Vendor Name : 10',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 270,
                                      child: Column(
                                        children: [
                                          Icon(Icons.arrow_downward_outlined),
                                          Container(
                                            height: 55,
                                            width: 180,
                                            padding: EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(color: blue),
                                                color: blue),
                                            child: Center(
                                              child: TextField(
                                                maxLines: 2,
                                                textInputAction:
                                                    TextInputAction.done,
                                                minLines: 1,
                                                autofocus: false,
                                                textAlign: TextAlign.center,

                                                style: TextStyle(
                                                    color: white, fontSize: 16),
                                                // onTap: (() =>
                                                //     textprovider().editname()),
                                                onChanged: ((value) {
                                                  // value =
                                                  //     textprovider().editname();
                                                  data11 = value;
                                                }),

                                                controller:
                                                    _textEditingController11!
                                                      ..text =
                                                          'Quality & safety Engineer',
                                              ),
                                              // Text(
                                              //   'Quality & safety Engineer',
                                              //   textAlign: TextAlign.center,
                                              //   style: TextStyle(
                                              //       color: white, fontSize: 16),
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('ResourceAllocation')
                            .doc(widget.depoName)
                            .set({
                          'data1': _textEditingController!.text,
                          'data2': _textEditingController2!.text,
                          'data3': _textEditingController3!.text,
                          'data4': _textEditingController4!.text,
                          'data5': _textEditingController5!.text,
                          'data6': _textEditingController6!.text,
                          'data7': _textEditingController7!.text,
                          'data71': _textEditingController71!.text,
                          'data72': _textEditingController72!.text,
                          'data8': _textEditingController8!.text,
                          'data9': _textEditingController9!.text,
                          'data10': _textEditingController10!.text,
                          'data101': _textEditingController101!.text,
                          'data102': _textEditingController102!.text,
                          'data11': _textEditingController11!.text,
                          'data12': _textEditingController12!.text,
                        });
                      },
                      child: const Text(
                        'Sync',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  resourceCard() {
    return Column(children: [
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Text('data'),
          Icon(Icons.horizontal_rule),
          Text('data'),
        ]),
      )
    ]);
  }
}
