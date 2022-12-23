import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appbarMOney extends StatelessWidget {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 187, 187, 2),
            Color.fromARGB(255, 89, 99, 40),
          ],
        ),
        color: Color.fromARGB(255, 225, 214, 60),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(20),
        ),
      ),
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 10,
          ),
          Text(
            'MONEY MANAGER',
            style: GoogleFonts.lato(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 235, 235)),
          )
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
