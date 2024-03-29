// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:food_delivery_app/blocs/location/location_bloc.dart';
import 'package:food_delivery_app/blocs/place/place_bloc.dart';
import 'package:food_delivery_app/repositories/location/location_repository.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/restaurant_details.dart';
import 'package:food_delivery_app/widgets/location_search_box.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const LocationScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoading) {
            return Stack(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.maxFinite,
                    child: BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        if (state is LocationLoaded) {
                          print('Loaded');
                          Set<Marker> markers =
                              state.restaurants!.map((restaurant) {
                            return Marker(
                                markerId: MarkerId(restaurant.id),
                                infoWindow: InfoWindow(
                                  title: restaurant.name,
                                  snippet: restaurant.description,
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RestaurantDetailsScreen.routeName,
                                        arguments: restaurant);
                                  },
                                ),
                                position: LatLng(restaurant.address.lat,
                                    restaurant.address.lng));
                          }).toSet();
                          return GoogleMap(
                            onMapCreated: ((GoogleMapController controller) {
                              context
                                  .read<LocationBloc>()
                                  .add(LoadMap(controller: controller));
                            }),
                            myLocationEnabled: true,
                            //myLocationButtonEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target:
                                    LatLng(state.place.lat, state.place.lng),
                                zoom: 18),
                            markers: markers,
                          );
                        } else if (state is LocationLoading) {
                          print("Loading");
                          return Center(
                            child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor),
                          );
                        } else {
                          const Center(child: Text("Something went wrong"));
                        }
                        return const Text("Something went wrong");
                      },
                    )),
                Positioned(
                    top: 40,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          // SvgPicture.asset('assets/svgs/logo.svg', height: 50),
                          // const SizedBox(width: 10),
                          Expanded(
                              child: BlocProvider<AutocompleteBloc>(
                            create: (context) => AutocompleteBloc(
                                locationRepository:
                                    context.read<LocationRepository>()),
                            child: const Column(
                              children: [
                                LocationSearchBox(),
                                SearchBoxSuggestions()
                              ],
                            ),
                          )),
                        ],
                      ),
                    )),
                const SaveButton()
              ],
            );
          } else if (state is PlaceLoaded) {
            return Stack(
              children: [
                GoogleMap(
                    myLocationEnabled: true,
                    //myLocationButtonEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(state.place.lat, state.place.lng),
                        zoom: 18)),
                Positioned(
                    top: 40,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          // SvgPicture.asset('assets/logo.svg', height: 50),
                          // const SizedBox(width: 10),
                          Expanded(
                              child: BlocProvider<AutocompleteBloc>(
                            create: (context) => AutocompleteBloc(
                                locationRepository:
                                    context.read<LocationRepository>()),
                            child: const Column(
                              children: [
                                LocationSearchBox(),
                                SearchBoxSuggestions()
                              ],
                            ),
                          )),
                        ],
                      ),
                    )),
                const SaveButton()
              ],
            );
          }
          return const Text("Something went wrong");
        },
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 50,
        left: 20,
        right: 20,
        child: Padding(
          padding: const EdgeInsets.only(left: 90, right: 90),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ));
  }
}

class SearchBoxSuggestions extends StatefulWidget {
  const SearchBoxSuggestions({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBoxSuggestions> createState() => _SearchBoxSuggestionsState();
}

class _SearchBoxSuggestionsState extends State<SearchBoxSuggestions> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        if (state is AutocompleteLoading) {
          return const SizedBox();
        }
        if (state is AutocompleteLoaded) {
          print('AutocompleteLoaded for predictions');
          var length = state.autocomplete.length;
          print("itemCount: $length");
          return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: state.autocomplete.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.black.withOpacity(0.6),
                  child: ListTile(
                    title: Text(state.autocomplete[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white)),
                    onTap: () {
                      context.read<LocationBloc>().add(SearchLocation(
                          placeId: state.autocomplete[index].placeId));
                      context.read<AutocompleteBloc>().add(ClearAutocomplete());
                    },
                  ),
                );
              });
        }
        return const Text('Something went wrong');
      },
    );
  }
}
