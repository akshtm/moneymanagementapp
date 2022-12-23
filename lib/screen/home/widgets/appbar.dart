import 'package:flutter/material.dart';

class appbarMOney extends StatelessWidget {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      decoration: BoxDecoration(color: Colors.grey),
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 10,
          ),
          Text('MONEY MANAGER')
        ],
      ),
    );

    // AppBar(
    //     actions: [
    //       Row(
    //         children: [
    //           IconButton(
    //               onPressed: () {}, icon: Icon(Icons.currency_rupee_sharp))
    //         ],
    //       )
    //     ],
    //     backgroundColor: Color.fromARGB(255, 17, 119, 147),
    //     title: Container(
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             height: height / 30,
    //           ),
    //           Text('MONEY MANAGER'),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //           ),
    //         ],
    //       ),
    //     ));
  }
}
