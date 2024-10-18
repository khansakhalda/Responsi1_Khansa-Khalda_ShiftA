class CatatanTransaksi {
  int? id;
  String? detail;
  int? amount;
  String? category;

  CatatanTransaksi({this.id, this.detail, this.amount, this.category});

  factory CatatanTransaksi.fromJson(Map<String, dynamic> obj) {
    return CatatanTransaksi(
      id: obj['id'],
      detail: obj['detail'],
      amount: obj['amount'],
      category: obj['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'detail': detail,
      'amount': amount,
      'category': category,
    };
  }
}
