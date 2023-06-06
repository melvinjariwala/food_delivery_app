import 'package:food_delivery_app/models/voucher_model.dart';

abstract class BaseVoucherRespository {
  Future<bool> searchVoucher(String code);
  Stream<List<Voucher>> getVouchers();
}
