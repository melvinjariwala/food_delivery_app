// ignore_for_file: avoid_print, library_prefixes, depend_on_referenced_packages, unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/blocs/voucher/voucher_bloc.dart';
import 'package:food_delivery_app/models/basket_model.dart';
import 'package:food_delivery_app/models/deliver_time_model.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/models/voucher_model.dart';
import 'package:food_delivery_app/repositories/basket/basket_repository.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final VoucherBloc _voucherBloc;
  late StreamSubscription _voucherSubscription;
  final BasketRepository _basketRepository;
  BasketBloc(
      {required VoucherBloc voucherBloc,
      required BasketRepository basketRepository})
      : _voucherBloc = voucherBloc,
        _basketRepository = basketRepository,
        super(BasketLoading()) {
    on<StartBasket>(startBasket);
    on<AddProduct>(addProduct);
    on<RemoveProduct>(removeProduct);
    on<RemoveAllProduct>(removeAllProduct);
    on<ToggleSwitch>(toggleSwitch);
    on<ApplyVoucher>(applyVoucher);
    on<SelectDeliveryTime>(selectDeliveryTime);

    _voucherSubscription = _voucherBloc.stream.listen((state) {
      if (state is VoucherSelected) {
        add(ApplyVoucher(state.voucher));
      }
    });
  }

  FutureOr<void> startBasket(
      StartBasket event, Emitter<BasketState> emit) async {
    Basket basket = await _basketRepository.getBasket();
    emit(BasketLoading());

    try {
      print("About to emit BasketLoaded");
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(BasketLoaded(basket: basket));
    } catch (e) {
      print("Error in startBasket : $e");
    }
  }

  FutureOr<void> addProduct(AddProduct event, Emitter<BasketState> emit) async {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        Basket basket = state.basket.copyWith(
            products: List.from(state.basket.products)..add(event.product));
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
      } catch (e) {
        print("Error in addProduct : $e");
      }
    }
  }

  FutureOr<void> removeProduct(RemoveProduct event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        Basket basket = state.basket.copyWith(
            products: List.from(state.basket.products)..add(event.product));
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
      } catch (e) {
        print("Error in removeProduct : $e");
      }
    }
  }

  FutureOr<void> removeAllProduct(
      RemoveAllProduct event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        Basket basket = state.basket.copyWith(
            products: List.from(state.basket.products)
              ..removeWhere((product) => product == event.product));
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
      } catch (e) {
        print("Error is removeAllProduct : $e");
      }
    }
  }

  FutureOr<void> toggleSwitch(ToggleSwitch event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        Basket basket = state.basket.copyWith(cutlery: !state.basket.cutlery);
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
      } catch (e) {
        print("Error is toggleSwitch : $e");
      }
    }
  }

  FutureOr<void> applyVoucher(ApplyVoucher event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        Basket basket = state.basket.copyWith(voucher: event.voucher);
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
      } catch (e) {
        print("Error in addVoucher : $e");
      }
    }
  }

  FutureOr<void> selectDeliveryTime(
      SelectDeliveryTime event, Emitter<BasketState> emit) {
    final state = this.state;
    if (state is BasketLoaded) {
      try {
        Basket basket = state.basket.copyWith(deliveryTime: event.deliveryTime);
        _basketRepository.saveBasket(basket);
        emit(BasketLoaded(basket: basket));
      } catch (e) {
        print("Error in selectDeliveryTime : $e");
      }
    }
  }
}
