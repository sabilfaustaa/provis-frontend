import 'package:digisehat/pages/home/diagnosa_pasien.dart';
import 'package:digisehat/pages/home/jadwal_konsultasi.dart';
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
        '/': (context) => HomePage(),

        // '/': (context) => SplashPage(),
        '/home': (context) => HomePage(), // fiksasi konten
        '/sign-in': (context) => SignInPage(), // done
        '/forgot-password': (context) => ForgotPasswordPage(), // done
        '/sign-up': (context) => SignUpPage(), // done

        '/profile': (context) => ProfilePage(), // fiksasi konten
        '/cari-dokter': (context) => CariDokterPage(), // fiksasi konten
        '/detail-dokter': (context) => DetailDokterPage(), // fiksasi konten
        '/jadwal-konsultasi': (context) =>
            JadwalKonsultasiPage(), // fiksasi konten
        '/diagnosa-pasien': (context) => DiagnosaPasienPage(), // done

        '/obat-pasien': (context) => ObatPasienPage(),
        '/notifikasi': (context) => NotifikasiPage(),
        '/riwayat-konsultasi': (context) => RiwayatKonsultasiPage(),
        '/riwayat-transaksi': (context) => RiwayatTransaksiPage(),
        '/pesan': (context) => PesanPage(),
      },
    );
  }
}
