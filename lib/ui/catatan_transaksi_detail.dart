import 'package:flutter/material.dart';
import '../bloc/catatan_transaksi_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/catatan_transaksi.dart';
import '/ui/catatan_transaksi_form.dart';
import 'catatan_transaksi_page.dart';

// ignore: must_be_immutable
class CatatanTransaksiDetail extends StatefulWidget {
  CatatanTransaksi? catatanTransaksi;

  CatatanTransaksiDetail({Key? key, this.catatanTransaksi}) : super(key: key);

  @override
  _CatatanTransaksiDetailState createState() => _CatatanTransaksiDetailState();
}

class _CatatanTransaksiDetailState extends State<CatatanTransaksiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan Transaksi'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Detail: ${widget.catatanTransaksi!.detail}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Jumlah: Rp. ${widget.catatanTransaksi!.amount}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Kategori: ${widget.catatanTransaksi!.category}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CatatanTransaksiForm(
                  catatanTransaksi: widget.catatanTransaksi!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor:
          Colors.orange, // Ubah warna latar belakang menjadi oranye
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(color: Colors.black), // Ubah warna teks menjadi hitam
      ),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text(
            "Ya",
            style: TextStyle(
                color: Colors.black), // Ubah warna teks tombol menjadi hitam
          ),
          onPressed: () {
            CatatanTransaksiBloc.deleteCatatanTransaksi(
                    id: widget.catatanTransaksi!.id!)
                .then(
                    (value) => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const CatatanTransaksiPage()))
                        }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text(
            "Batal",
            style: TextStyle(
                color: Colors.black), // Ubah warna teks tombol menjadi hitam
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
