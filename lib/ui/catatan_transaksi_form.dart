import 'package:flutter/material.dart';
import '../bloc/catatan_transaksi_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/catatan_transaksi.dart';
import 'catatan_transaksi_page.dart';

// ignore: must_be_immutable
class CatatanTransaksiForm extends StatefulWidget {
  CatatanTransaksi? catatanTransaksi;
  CatatanTransaksiForm({Key? key, this.catatanTransaksi}) : super(key: key);
  @override
  _CatatanTransaksiFormState createState() => _CatatanTransaksiFormState();
}

class _CatatanTransaksiFormState extends State<CatatanTransaksiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TRANSAKSI";
  String tombolSubmit = "SIMPAN";
  final _detailTextboxController = TextEditingController();
  final _amountTextboxController = TextEditingController();
  final _categoryTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.catatanTransaksi != null) {
      setState(() {
        judul = "UBAH TRANSAKSI";
        tombolSubmit = "UBAH";
        _detailTextboxController.text = widget.catatanTransaksi!.detail!;
        _amountTextboxController.text =
            widget.catatanTransaksi!.amount.toString();
        _categoryTextboxController.text = widget.catatanTransaksi!.category!;
      });
    } else {
      judul = "TAMBAH TRANSAKSI";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _detailTextField(),
                _amountTextField(),
                _categoryTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Detail Transaksi
  Widget _detailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Detail Transaksi"),
      keyboardType: TextInputType.text,
      controller: _detailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Detail transaksi harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Jumlah (Amount)
  Widget _amountTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jumlah"),
      keyboardType: TextInputType.number,
      controller: _amountTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Kategori
  Widget _categoryTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kategori"),
      keyboardType: TextInputType.text,
      controller: _categoryTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kategori harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.catatanTransaksi != null) {
                //kondisi update transaksi
                ubah();
              } else {
                //kondisi tambah transaksi
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    CatatanTransaksi createCatatanTransaksi = CatatanTransaksi(id: null);
    createCatatanTransaksi.detail = _detailTextboxController.text;
    createCatatanTransaksi.amount = int.parse(_amountTextboxController.text);
    createCatatanTransaksi.category = _categoryTextboxController.text;
    CatatanTransaksiBloc.addCatatanTransaksi(
            transaksi:
                createCatatanTransaksi // Ganti dari catatanTransaksi menjadi transaksi
            )
        .then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const CatatanTransaksiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    CatatanTransaksi updateCatatanTransaksi =
        CatatanTransaksi(id: widget.catatanTransaksi!.id!);
    updateCatatanTransaksi.detail = _detailTextboxController.text;
    updateCatatanTransaksi.amount = int.parse(_amountTextboxController.text);
    updateCatatanTransaksi.category = _categoryTextboxController.text;
    CatatanTransaksiBloc.updateCatatanTransaksi(
            transaksi:
                updateCatatanTransaksi // Ganti dari catatanTransaksi menjadi transaksi
            )
        .then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const CatatanTransaksiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
