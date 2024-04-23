import 'package:digisehat/pages/home/diagnosa_pasien.dart';
import 'package:digisehat/pages/home/input_diagnosa_paien.dart';
import 'package:digisehat/pages/home/jadwal_konsultasi.dart';
import 'package:digisehat/pages/home/list_pesan.dart';
import 'package:digisehat/pages/home/notifikasi.dart';
import 'package:digisehat/pages/home/obat_pasien.dart';
import 'package:digisehat/pages/home/pesan.dart';
import 'package:digisehat/pages/home/riwayat_konsultasi.dart';
import 'package:digisehat/pages/home/riwayat_transaksi.dart';
import 'package:flutter/material.dart';
import 'package:digisehat/pages/sign_in.dart';
import 'package:digisehat/pages/sign_up.dart';
import 'package:digisehat/pages/forgot_password.dart';
import 'package:digisehat/pages/splash.dart';
import 'package:digisehat/pages/home/home.dart';
import 'package:digisehat/pages/home/profile.dart';
import 'package:digisehat/pages/home/cari_dokter.dart';
import 'package:digisehat/pages/home/detail_dokter.dart';
import 'package:digisehat/pages/home/panduan_aplikasi.dart';
import 'package:digisehat/pages/home/panduan_obat.dart';
import 'package:digisehat/pages/home/panduan_fitur.dart';
// import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // untuk debug :
        // '/': (context) => RiwayatKonsultasiPage(),

        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(), // done
        '/sign-in': (context) => SignInPage(), // done
        '/forgot-password': (context) => ForgotPasswordPage(), // done
        '/sign-up': (context) => SignUpPage(), // done

        '/profile': (context) => ProfilePage(), // done
        '/cari-dokter': (context) => CariDokterPage(), // done
        '/detail-dokter': (context) => DetailDokterPage(), // done
        '/jadwal-konsultasi': (context) => JadwalKonsultasiPage(), // done
        '/pesan': (context) => PesanPage(), // done
        '/list-pesan': (context) => ListPesanPage(), // done
        '/input-diagnosa-pasien': (context) =>
            InputDiagnosaPasienPage(), // done
        '/diagnosa-pasien': (context) => DiagnosaPasienPage(), // done
        '/riwayat-transaksi': (context) => RiwayatTransaksiPage(), // done
        '/riwayat-konsultasi': (context) => RiwayatKonsultasiPage(), // done

        '/panduan-aplikasi': (context) => PanduanAplikasiPage(),
        '/panduan-obat': (context) => PanduanObatPage(),
        '/panduan-fitur': (context) => PanduanFiturPage(),

        '/obat-pasien': (context) => ObatPasienPage(),
        '/notifikasi': (context) => NotifikasiPage(),
      },
    );
  }
}
