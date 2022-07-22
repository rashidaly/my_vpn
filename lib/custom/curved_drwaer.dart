import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn_app/custom/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Animation Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Playground(title: 'Curved Drawer Demo'),
    );
  }
}

class Playground extends StatefulWidget {
  Playground({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  int index = 0;
  double leftWidth = 75.0;
  int leftTextColor = 1;
  int leftBackgroundColor = 0;
  double rightWidth = 75.0;
  int rightTextColor = 1;
  int rightBackgroundColor = 0;
/*  final List<Color> colorPallete = <Color>[
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.blueAccent,
    Colors.red,
    Colors.redAccent,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.lime,
    Colors.green
  ];*/
  final List<DrawerItem> _drawerItems = <DrawerItem>[
    const DrawerItem(icon: Icon(Icons.settings
    ), label: "Settings"),
    const DrawerItem(icon: Icon(Icons.info_outline), label: "About Us"),
    const DrawerItem(icon: Icon(Icons.star_rate), label: "Rate Us",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return  CurvedDrawer(


      index: index,

      width: leftWidth,
      color: bgColor,
      //colorPallete[leftBackgroundColor],
      buttonBackgroundColor: bgColor,
      labelColor: Colors.white,//colorPallete[leftTextColor],
      items: _drawerItems,
      onTap: (newIndex) {
        setState(() {
          index = newIndex;
        });
      },
    );
  }
}