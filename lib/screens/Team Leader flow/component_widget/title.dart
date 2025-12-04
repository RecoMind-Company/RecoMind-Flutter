import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class titleRecurring extends StatelessWidget {
  titleRecurring({super.key, required this.texttitle});
  String? texttitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.white,
                size: 30,
              )),
          SizedBox(
            width: 10,
          ),
          Text(
            texttitle!,
            style: TextStyle(fontSize: 26, color: Colors.white),
          )
        ],
      ),
    );
  }
}
