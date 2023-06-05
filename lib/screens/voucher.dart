import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/basket/basket_bloc.dart';
import 'package:food_delivery_app/models/voucher_model.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});
  static const String routeName = '/voucher';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const VoucherScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Voucher", style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).primaryColor,
        leading: const BackButton(color: Colors.black),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {},
              child: const Text("Apply", style: TextStyle(color: Colors.black)))
        ])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Enter voucher",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).primaryColorDark)),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Voucher Code",
                        contentPadding: const EdgeInsets.all(10.0)),
                  )),
                ],
              ),
            ),
            Text("Your voucherss",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).primaryColorDark)),
            ListView.builder(
                shrinkWrap: true,
                itemCount: Voucher.vouchers.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "1x",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: Theme.of(context).primaryColorDark),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                            child: Text(
                          Voucher.vouchers[index].code,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                        BlocBuilder<BasketBloc, BasketState>(
                          builder: (context, state) {
                            return TextButton(
                                onPressed: () {
                                  context
                                      .read<BasketBloc>()
                                      .add(AddVoucher(Voucher.vouchers[index]));
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Apply",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                ));
                          },
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
