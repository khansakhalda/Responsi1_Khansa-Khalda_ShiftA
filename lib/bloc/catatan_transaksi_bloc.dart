import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/catatan_transaksi.dart';

class CatatanTransaksiBloc {
  static Future<List<CatatanTransaksi>> getCatatanTransaksis() async {
    String apiUrl = ApiUrl.getAllCatatanTransaksi;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTransaksi = (jsonObj as Map<String, dynamic>)['data'];
    List<CatatanTransaksi> transaksis = [];
    for (var transaksi in listTransaksi) {
      transaksis.add(CatatanTransaksi.fromJson(transaksi));
    }
    return transaksis;
  }

  static Future addCatatanTransaksi({CatatanTransaksi? transaksi}) async {
    String apiUrl = ApiUrl.createCatatanTransaksi;

    var body = {
      "detail": transaksi!.detail,
      "amount": transaksi.amount.toString(),
      "category": transaksi.category
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateCatatanTransaksi(
      {required CatatanTransaksi transaksi}) async {
    String apiUrl = ApiUrl.updateCatatanTransaksi(transaksi.id!);
    print(apiUrl);

    var body = {
      "detail": transaksi.detail,
      "amount": transaksi.amount,
      "category": transaksi.category
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteCatatanTransaksi({int? id}) async {
    String apiUrl = ApiUrl.deleteCatatanTransaksi(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
