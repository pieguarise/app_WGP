import 'package:flutter/material.dart';

class ListRadioMembers extends StatefulWidget {
  const ListRadioMembers({super.key});

  @override
  State<ListRadioMembers> createState() => _listRadioMembersState();
}

class _listRadioMembersState extends State<ListRadioMembers> {
  final List<String> _members = ['Nike', 'Lowa', 'Bottecchia'];
  final List<double> _membNum = [1, 2, 3];
  List<String> pathsImages = [
    'assets/nike.png',
    'assets/lowa.png',
    'assets/bottecchia.png',
  ];

  num? currentValue;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _members.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          minVerticalPadding: 0.5,
          title: Text(_members[index]),
          leading: Radio(
            fillColor: MaterialStateColor.resolveWith(
                (states) => const Color(0xFF89453C)),
            value: _membNum[index],
            groupValue: currentValue,
            
            onChanged: (val) {
              setState(() {
                currentValue = val;
              });
            },
          ),
          trailing: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.asset(
              pathsImages[index],
            ),
          ),
          visualDensity: const VisualDensity(horizontal: -2),
        );
      },
    );
  }
}
