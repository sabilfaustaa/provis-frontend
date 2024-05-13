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

// provider
import 'package:provider/provider.dart';
import 'package:digisehat/providers/auth_provider.dart';
// import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            // untuk debug :
            // '/': (context) => RiwayatKonsultasiPage(),

            '/': (context) => SplashPage(),
            '/home': (context) => HomePage(),
            '/sign-in': (context) => SignInPage(),
            '/forgot-password': (context) => ForgotPasswordPage(),
            '/sign-up': (context) => SignUpPage(),

            '/profile': (context) => ProfilePage(),
            '/cari-dokter': (context) => CariDokterPage(),
            '/detail-dokter': (context) => DetailDokterPage(),
            '/jadwal-konsultasi': (context) => JadwalKonsultasiPage(),
            '/pesan': (context) => PesanPage(),
            '/list-pesan': (context) => ListPesanPage(),
            '/input-diagnosa-pasien': (context) => InputDiagnosaPasienPage(),
            '/diagnosa-pasien': (context) => DiagnosaPasienPage(),
            '/riwayat-transaksi': (context) => RiwayatTransaksiPage(),
            '/riwayat-konsultasi': (context) => RiwayatKonsultasiPage(),

            '/panduan-aplikasi': (context) => PanduanAplikasiPage(),
            '/panduan-obat': (context) => PanduanObatPage(),
            '/panduan-fitur': (context) => PanduanFiturPage(),

            '/obat-pasien': (context) => ObatPasienPage(),
            '/notifikasi': (context) => NotifikasiPage(),
          },
        ));
  }
}
