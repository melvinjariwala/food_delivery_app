// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/voucher_model.dart';
import 'package:food_delivery_app/repositories/voucher/voucher_repository.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final VoucherRespository _voucherRespository;
  StreamSubscription? _voucherSubscription;
  VoucherBloc({required VoucherRespository voucherRespository})
      : _voucherRespository = voucherRespository,
        super(VoucherLoading()) {
    on<LoadVouchers>(loadVouchers);
    on<UpdateVouchers>(updateVouchers);
    on<SelectVouchers>(selectVouchers);
  }

  FutureOr<void> loadVouchers(LoadVouchers event, Emitter<VoucherState> emit) {
    _voucherSubscription?.cancel();
    _voucherSubscription = _voucherRespository.getVouchers().listen((vouchers) {
      add(UpdateVouchers(vouchers: vouchers));
    });
  }

  FutureOr<void> updateVouchers(
      UpdateVouchers event, Emitter<VoucherState> emit) {
    emit(VoucherLoaded(vouchers: event.vouchers));
  }

  FutureOr<void> selectVouchers(
      SelectVouchers event, Emitter<VoucherState> emit) {
    emit(VoucherSelected(voucher: event.voucher));
  }
}
