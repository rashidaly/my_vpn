
import 'package:flutter/material.dart';
import 'package:vpn_app/custom/utils.dart';



class DropDownList extends StatefulWidget {
  const DropDownList({Key? key}) : super(key: key);

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  String? _mySelection;
  final List<Map> _myData = [
    {'name': 'Auto Select', 'image': 'assets/images/planet-earth.png'},
    {'name': 'USA', 'image': 'assets/images/united-states.png'},
    {'name': 'UK', 'image': 'assets/images/united-kingdom.png'},
    {'name': 'Singapore', 'image': 'assets/images/singapore.png'},
    {'name': 'Canada', 'image': 'assets/images/canada.png'}
  ];



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: bgColor,
                ),
                child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  isDense: true,
                  hint: const Text('Select Country',
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                  value: _mySelection,
                  style: const TextStyle(
                  color: Colors.white,
                ),
                  onChanged: (String? value) {
                    setState(() {
                      _mySelection = value;
                    });
                    print(_mySelection);
                  },
                  items: _myData.map((Map map) {
                    return DropdownMenuItem<String>(
                        value: map['name'].toString(),
                        child: Row(
                          children: [
                            Image.asset(
                              map['image'],
                              width: 25,
                            ),
                            SizedBox(width: 20),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(map['name'],

                              ),
                            )
                          ],
                        ));
                  }).toList(),
                ),
            ),
          ),
              ))
        ],
      ),
    );
  }
}
