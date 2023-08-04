// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/filters/filters_bloc.dart';

class CustomPriceFilter extends StatelessWidget {
  const CustomPriceFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) {
        if (state is FiltersLoading) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor));
        }
        if (state is FiltersLoaded) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: state.filter.priceFilters
                  .asMap()
                  .entries
                  .map((price) => InkWell(
                        onTap: () {
                          context.read<FiltersBloc>().add(PriceFilterUpdated(
                              priceFilter: state.filter.priceFilters[price.key]
                                  .copyWith(
                                      value: !state.filter
                                          .priceFilters[price.key].value)));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: state.filter.priceFilters[price.key].value
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withAlpha(100)
                                  : Colors.white),
                          child: Text(
                              state.filter.priceFilters[price.key].price.price,
                              style: Theme.of(context).textTheme.headline5),
                        ),
                      ))
                  .toList());
        }
        return const Center(child: Text("Something Went Wrong!"));
      },
    );
  }
}
