// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/autocomplete/autocomplete_bloc.dart';

class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("LocationSearchBox build");
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        if (state is AutocompleteLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AutocompleteLoaded) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(32),
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your Location',
                    suffixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.only(
                        top: 20, bottom: 5, right: 5, left: 15),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(color: Colors.white))),
                onChanged: (value) {
                  BlocProvider.of<AutocompleteBloc>(context)
                      .add(LoadAutocomplete(searchInput: value));
                  print("onChanged called");
                },
              ),
            ),
          );
        }
        return const Text("Something went wrong");
      },
    );
  }
}
