// ignore_for_file: avoid_print, library_prefixes, depend_on_referenced_packages, unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/blocs/voucher/voucher_bloc.dart';
import 'package:food_delivery_app/models/basket_model.dart';
import 'package:food_delivery_app/models/deliver_time_model.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/models/voucher_model.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final VoucherBloc _voucherBloc;
  late StreamSubscription _voucherSubscription;
  BasketBloc({required VoucherBloc voucherBloc})
      : _voucherBloc = voucherBloc,
        super(BasketLoading()) {
    on<StartBasket>(startBasket);
    on<AddProduct>(addProduct);
    on<RemoveProduct>(removeProduct);
    on<RemoveAllProduct>(removeAllProduct);
    on<ToggleSwitch>(toggleSwitch);
    on<ApplyVoucher>(applyVoucher);
    on<SelectDeliveryTime>(selectDeliveryTime);

    _voucherSubscription = voucherBloc.stream.listen((state) {
      if (state is VoucherSelected) {
        add(ApplyVoucher(state.voucher));
      }
    });
  }

  FutureOr<void> startBasket(
      StartBasket event, Emitter<BasketState> emit) async {
    emit(BasketLoading());

    try {
      print("About to emit BasketLoaded");
      await Future<void>.delayed(const Duration(seconds: 1));

      emit(const BasketLoaded(basket: Basket()));
    } catch (e) {
      print("Error in startBasket : $e");
    }
  }

  FutureOr<void> addProduct(AddProduct event, Emitter<BasketState> emit) async {
    if (state is BasketLoaded) {
      try {
        final BasketLoaded currentState = state as BasketLoaded;
        final List<Product> updatedProducts =
            List.from(currentState.basket.products);
        updatedProducts.add(event.product);
        emit(BasketLoaded(
            basket: currentState.basket.copyWith(products: updatedProducts)));
      } catch (e) {
        print("Error in addProduct : $e");
      }
    }
  }

  FutureOr<void> removeProduct(RemoveProduct event, Emitter<BasketState> emit) {
    if (state is BasketLoaded) {
      try {
        final BasketLoaded currentState = state as BasketLoaded;
        final List<Product> updateProducts =
            List.from(currentState.basket.products);
        updateProducts.remove(event.product);
        emit(BasketLoaded(
            basket: currentState.basket.copyWith(products: updateProducts)));
      } catch (e) {
        print("Error in removeProduct : $e");
      }
    }
  }

  FutureOr<void> removeAllProduct(
      RemoveAllProduct event, Emitter<BasketState> emit) {
    if (state is BasketLoaded) {
      try {
        final BasketLoaded currentState = state as BasketLoaded;
        final List<Product> updateProducts =
            List.from(currentState.basket.products);
        updateProducts.removeWhere((product) => product == event.product);
        emit(BasketLoaded(
            basket: currentState.basket.copyWith(products: updateProducts)));
      } catch (e) {
        print("Error is removeAllProduct : $e");
      }
    }
  }

  FutureOr<void> toggleSwitch(ToggleSwitch event, Emitter<BasketState> emit) {
    if (state is BasketLoaded) {
      try {
        final BasketLoaded currentState = state as BasketLoaded;
        emit(BasketLoaded(
            basket: currentState.basket
                .copyWith(cutlery: !currentState.basket.cutlery)));
      } catch (e) {
        print("Error is toggleSwitch : $e");
      }
    }
  }

  FutureOr<void> applyVoucher(ApplyVoucher event, Emitter<BasketState> emit) {
    if (state is BasketLoaded) {
      try {
        final BasketLoaded currentState = state as BasketLoaded;
        emit(BasketLoaded(
            basket: currentState.basket.copyWith(voucher: event.voucher)));
      } catch (e) {
        print("Error in addVoucher : $e");
      }
    }
  }

  FutureOr<void> selectDeliveryTime(
      SelectDeliveryTime event, Emitter<BasketState> emit) {
    if (state is BasketLoaded) {
      try {
        final BasketLoaded currentState = state as BasketLoaded;
        emit(BasketLoaded(
            basket: currentState.basket
                .copyWith(deliveryTime: event.deliveryTime)));
      } catch (e) {
        print("Error in selectDeliveryTime : $e");
      }
    }
  }
}
