// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/filters/filters_bloc.dart';

class CustomCategoryFilter extends StatelessWidget {
  const CustomCategoryFilter({super.key});

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
          print(
              "CategoryFIlter Length : ${state.filter.categoryFilters.length}");
          print("CategoryFIlters : ${state.filter.categoryFilters}");
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.filter.categoryFilters.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.filter.categoryFilters[index].category.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                        height: 25,
                        child: Checkbox(
                            //checkColor: Theme.of(context).primaryColor,
                            fillColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor.withAlpha(200)),
                            value: state.filter.categoryFilters[index].value,
                            onChanged: (bool? newValue) {
                              context.read<FiltersBloc>().add(
                                  CategoryFilterUpdated(
                                      categoryFilter: state
                                          .filter.categoryFilters[index]
                                          .copyWith(
                                              value: !state
                                                  .filter
                                                  .categoryFilters[index]
                                                  .value)));
                            }))
                  ],
                ),
              );
            },
          );
        }
        return const Center(child: Text("Something Went Wrong!"));
      },
    );
  }
}
