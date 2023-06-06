import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/voucher_model.dart';
import 'package:food_delivery_app/repositories/voucher/base_voucher_repository.dart';

class VoucherRespository extends BaseVoucherRespository {
  final FirebaseFirestore _firebaseFirestore;

  VoucherRespository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Voucher>> getVouchers() {
    return _firebaseFirestore
        .collection('vouchers')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Voucher.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<bool> searchVoucher(String code) async {
    final voucher = await _firebaseFirestore
        .collection('vouchers')
        .where('code', isEqualTo: code)
        .get();
    return voucher.docs.isNotEmpty;
  }
}
