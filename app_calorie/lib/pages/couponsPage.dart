import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CouponsPage extends StatefulWidget {
  CouponsPage({Key? key}) : super(key: key);

  //static const CouponspageName = 'CouponsPage';

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  @override
  Widget build(BuildContext context) {
    //print('${CouponsPage.CouponspageName} built');
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Coupons'),
      ),
      body: coupons(),
      );
  } 
 //build

Widget coupons() => ListView(children:  const [
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
}//CouponsPage