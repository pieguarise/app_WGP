import 'package:app_calorie/models/coupon.dart';
import 'package:app_calorie/models/couponsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CouponsPage extends StatelessWidget {
  CouponsPage({Key? key}) : super(key: key);

  //static const CouponspageName = 'CouponsPage';

  @override
  Widget build(BuildContext context) {
    //print('${CouponsPage.CouponspageName} built');
    return ChangeNotifierProvider<CouponsList>(
      create: (context) => CouponsList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Coupons'),
        ),
        body: Consumer<CouponsList>(
                  builder: (context, totalCoupons, child) {
                  return ListView.builder(
        itemCount: totalCoupons.myCoupons.length,
        itemBuilder: (BuildContext context, int index) {
          return totalCoupons.myCoupons[index].coup;
        }
    
          );
        }
        )),
    );}
}

//build

  /*
  Widget coupons() => ListView.builder(
      itemCount: totalCoupons.myCoupons.length,
      itemBuilder: (BuildContext context, int index) {
        return Coupon(coup: coup)})

  Widget coupons() => ListView(children: const [
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
*/