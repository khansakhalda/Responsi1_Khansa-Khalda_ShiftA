class ApiUrl {
  // Base URL untuk catatan transaksi
  static const String baseUrlCatatanTransaksi =
      'http://103.196.155.42/api/keuangan';

  // Base URL untuk registrasi dan login
  static const String baseUrlAuth = 'http://103.196.155.42/api';

  static const String registrasi = baseUrlAuth + '/registrasi';
  static const String login = baseUrlAuth + '/login';

  // Endpoint untuk mengambil semua catatan transaksi
  static const String getAllCatatanTransaksi =
      baseUrlCatatanTransaksi + '/catatan_transaksi';

  // Endpoint untuk membuat catatan transaksi baru
  static const String createCatatanTransaksi =
      baseUrlCatatanTransaksi + '/catatan_transaksi';

  // Endpoint untuk memperbarui catatan transaksi berdasarkan ID
  static String updateCatatanTransaksi(int id) {
    return baseUrlCatatanTransaksi +
        '/catatan_transaksi/' +
        id.toString() +
        '/update';
  }

  // Endpoint untuk menampilkan satu catatan transaksi berdasarkan ID
  static String showCatatanTransaksi(int id) {
    return baseUrlCatatanTransaksi + '/catatan_transaksi/' + id.toString();
  }

  // Endpoint untuk menghapus catatan transaksi berdasarkan ID
  static String deleteCatatanTransaksi(int id) {
    return baseUrlCatatanTransaksi +
        '/catatan_transaksi/' +
        id.toString() +
        '/delete';
  }
}
