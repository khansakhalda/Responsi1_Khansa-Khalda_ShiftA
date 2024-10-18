import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/catatan_transaksi_bloc.dart';
import '/model/catatan_transaksi.dart';
import '/ui/catatan_transaksi_detail.dart';
import '/ui/catatan_transaksi_form.dart';
import 'login_page.dart';

class CatatanTransaksiPage extends StatefulWidget {
  const CatatanTransaksiPage({Key? key}) : super(key: key);

  @override
  _CatatanTransaksiPageState createState() => _CatatanTransaksiPageState();
}

class _CatatanTransaksiPageState extends State<CatatanTransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Catatan Transaksi'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CatatanTransaksiForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.indigo,
        child: ListView(
          children: [
            ListTile(
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.logout, color: Colors.white),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: CatatanTransaksiBloc.getCatatanTransaksis(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListCatatanTransaksi(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListCatatanTransaksi extends StatelessWidget {
  final List? list;

  const ListCatatanTransaksi({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemCatatanTransaksi(
            catatanTransaksi: list![i],
          );
        });
  }
}

class ItemCatatanTransaksi extends StatelessWidget {
  final CatatanTransaksi catatanTransaksi;

  const ItemCatatanTransaksi({Key? key, required this.catatanTransaksi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CatatanTransaksiDetail(
                      catatanTransaksi: catatanTransaksi,
                    )));
      },
      child: Card(
        color: Colors.green,
        child: ListTile(
          title: Text(catatanTransaksi.detail!),
          subtitle:
              Text('${catatanTransaksi.amount} - ${catatanTransaksi.category}'),
        ),
      ),
    );
  }
}
