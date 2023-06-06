// ignore_for_file: avoid_print, library_prefixes, depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/basket_model.dart';
import 'package:food_delivery_app/models/deliver_time_model.dart';
import 'package:food_delivery_app/models/menu_item_model.dart' as Item;
import 'package:food_delivery_app/models/voucher_model.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketLoading()) {
    on<StartBasket>(startBasket);
    on<AddItem>(addItem);
    on<RemoveItem>(removeItem);
    on<RemoveAllItem>(removeAllItem);
    on<ToggleSwitch>(toggleSwitch);
    on<AddVoucher>(addVoucher);
    on<SelectDeliveryTime>(selectDeliveryTime);
  }

  FutureOr<void> startBasket(
      StartBasket event, Emitter<BasketState> emit) async {
    emit(BasketLoading());

    try {
      print("About to emit BasketLoaded");
      await Future<void>.delayed(const Duration(seconds: 1));

      emit(BasketLoaded(basket: Basket()));
    } catch (e) {
      print("Error in startBasket : $e");
    }
  }

  FutureOr<void> addItem(AddItem event, Emitter<BasketState> emit) async {
    if (state is BasketLoaded) {
      try {
        final BasketLoaded currentState = state as BasketLoaded;
        final List<Item.MenuItem> updatedItems =
            List.from(currentState.basket.items);
        updatedItems.add(event.item);
        emit(BasketLoaded(
            basket: currentState.basket.copyWith(items: updatedItems)));
      } catch (e) {
        print("Error in addItem : $e");
      }
    }
  }

  FutureOr<void> removeItem(RemoveItem event, Emitter<BasketState> emit) {
    if (state is BasketLoaded) {
      try {
        final BasketLoaded currentState = state as BasketLoaded;
        final List<Item.MenuItem> updateItems =
            List.from(currentState.basket.items);
        updateItems.remove(event.item);
        emit(BasketLoaded(
            basket: currentState.basket.copyWith(items: updateItems)));
      } catch (e) {
        print("Error in removeItem : $e");
      }
    }
  }

  FutureOr<void> removeAllItem(RemoveAllItem event, Emitter<BasketState> emit) {
    if (state is BasketLoaded) {
      try {
        final BasketLoaded currentState = state as BasketLoaded;
        final List<Item.MenuItem> updateItems =
            List.from(currentState.basket.items);
        updateItems.removeWhere((item) => item == event.item);
        emit(BasketLoaded(
            basket: currentState.basket.copyWith(items: updateItems)));
      } catch (e) {
        print("Error is removeAllItem : $e");
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

  FutureOr<void> addVoucher(AddVoucher event, Emitter<BasketState> emit) {
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
