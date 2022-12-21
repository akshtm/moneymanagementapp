import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Screen_Transaction extends StatelessWidget {
  const Screen_Transaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx, index) {
          return const Card(
              child: ListTile(
            leading: CircleAvatar(
                radius: 50,
                child: Text(
                  '12\ndec',
                  textAlign: TextAlign.center,
                )),
            title: Text('10000'),
            subtitle: Text('Travel'),
          ));
        },
        separatorBuilder: (ctx, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: 10);
  }
}
