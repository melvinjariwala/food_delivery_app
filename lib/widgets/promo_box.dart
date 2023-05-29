import 'package:flutter/material.dart';

class PromotionBox extends StatelessWidget {
  const PromotionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(right: 5.0),
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Theme.of(context).primaryColor,
            image: const DecorationImage(
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmF8tAuwyKYTtVZg1ecbob6AP7CRJBYQFBcQ"),
                fit: BoxFit.cover)),
      ),
      Container(
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
                "FREE delivery on first order",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(height: 12),
              Text(
                "FREE delivery on orders above \$10",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
