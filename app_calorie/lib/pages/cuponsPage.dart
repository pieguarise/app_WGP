import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CuponsPage extends StatefulWidget {
  CuponsPage({Key? key}) : super(key: key);

  //static const CuponspageName = 'CuponsPage';

  @override
  State<CuponsPage> createState() => _CuponsPageState();
}

class _CuponsPageState extends State<CuponsPage> {
  @override
  Widget build(BuildContext context) {
    //print('${CuponsPage.CuponspageName} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cupons'),
      ),
      body: cupons(),
      );
  } 
 //build

Widget cupons() => ListView(children:  const [
        ListTile(
          leading: Icon(Icons.card_giftcard),
          title: Text('Nike: 25%'),
          subtitle: Text('To be used within 30 days'),
          iconColor: Color.fromARGB(255, 230, 81, 1),
          //onTap:() {},
        ),
        ListTile(
          leading: Icon(Icons.card_giftcard),
          title: Text('Nike: 25%'),
          subtitle: Text('To be used within 30 days'),
          iconColor: Color.fromARGB(255, 230, 81, 1),
          //onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.card_giftcard),
          title: Text('Lowa: 10%'),
          subtitle: Text('To be used within 15 days'),
          iconColor: Color.fromARGB(255, 230, 81, 1),
          //onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.card_giftcard),
          title: Text('Nike: 25% '),
          subtitle: Text('To be used within 30 days'),
          iconColor: Color.fromARGB(255, 230, 81, 1),
          //onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.card_giftcard),
          title: Text('Nike: 25% '),
          subtitle: Text('To be used within 30 days'),
          iconColor: Color.fromARGB(255, 230, 81, 1),
          //onTap: () {},
        )
      ]);
}//CuponsPage