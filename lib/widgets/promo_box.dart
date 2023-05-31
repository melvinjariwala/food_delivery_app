import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/promo_model.dart';

class PromotionBox extends StatelessWidget {
  final Promo promo;
  const PromotionBox({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(right: 5.0),
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
                image: NetworkImage(promo.imgUrl), fit: BoxFit.cover)),
      ),
      ClipPath(
        clipper: PromoCustomClipper(),
        child: Container(
          margin: const EdgeInsets.only(right: 5.0),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 125),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promo.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(height: 21),
                Text(
                  promo.description,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}

class PromoCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(225, size.height);
    path.lineTo(300, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
