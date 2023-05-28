import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:food_delivery_app/widgets/location_search_box.dart';
//import 'package:food_delivery_app/screens/home_screen.dart';
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
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.maxFinite,
              child: BlocBuilder<GeolocationBloc, GeolocationState>(
                builder: (context, state) {
                  if (state is GeolocationLoaded) {
                    print('Loaded');
                    return GoogleMap(
                        onMapCreated: ((controller) {
                          context
                              .read<GeolocationBloc>()
                              .add(LoadGeolocation(controller: controller));
                        }),
                        myLocationEnabled: true,
                        //myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(state.lat, state.lng), zoom: 18));
                  } else if (state is GeolocationLoading) {
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
              child: Container(
                height: 100,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/logo.svg', height: 50),
                    const SizedBox(width: 10),
                    const Expanded(child: LocationSearchBox()),
                  ],
                ),
              )),
          Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
