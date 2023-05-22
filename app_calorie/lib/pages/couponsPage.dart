import 'package:app_calorie/models/coupon.dart';
import 'package:app_calorie/models/couponsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CouponsPage extends StatelessWidget {
  int? val;
  CouponsPage({Key? key, this.val}) : super(key: key);

  //static const CouponspageName = 'CouponsPage';

  @override
  Widget build(BuildContext context) {
    //print('${CouponsPage.CouponspageName} built');
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Coupons'),
        ),
        body: Consumer<CouponsList>(builder: (context, totalCoupons, child) {
          return ListView.builder(
              itemCount: totalCoupons.myCoupons.length,
              itemBuilder: (BuildContext context, int index) {
                //return totalCoupons.myCoupons[index].coup;
                return ListTile(
                  leading: (totalCoupons.myCoupons[index].immagine),
                  title: Text(totalCoupons.myCoupons[index].title),
                  subtitle: Text(totalCoupons.myCoupons[index].description),     
                  onTap: () => Provider.of<CouponsList>(context, listen: false).deleteCoupon(index)
    
                );
              });
        }));
  }
}
