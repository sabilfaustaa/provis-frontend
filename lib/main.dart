import 'package:digisehat/no_auth_guard.dart';
import 'package:digisehat/pages/home/diagnosa_pasien.dart';
import 'package:digisehat/pages/home/input_diagnosa_paien.dart';
import 'package:digisehat/pages/home/jadwal_konsultasi.dart';
import 'package:digisehat/pages/home/list_pesan.dart';
import 'package:digisehat/pages/home/notifikasi.dart';
import 'package:digisehat/pages/home/obat_pasien.dart';
import 'package:digisehat/pages/home/pesan.dart';
import 'package:digisehat/pages/home/riwayat_page.dart';
import 'package:digisehat/providers/doctor_provider.dart';
import 'package:digisehat/providers/hospital_provider.dart';
import 'package:digisehat/providers/konsultasi_provider.dart';
import 'package:digisehat/providers/medicine_provider.dart';
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
import 'package:digisehat/pages/home/rumah_sakit.dart';

// provider
import 'package:provider/provider.dart';
import 'package:digisehat/providers/auth_provider.dart';
import 'auth_guard.dart';

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
          ChangeNotifierProvider(create: (_) => DoctorProvider()),
          ChangeNotifierProvider(create: (_) => HospitalProvider()),
          ChangeNotifierProvider(create: (_) => KonsultasiProvider()),
          ChangeNotifierProvider(create: (_) => MedicineProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            // done consume :
            '/': (context) => SplashPage(),
            '/home': (context) => AuthGuard(child: HomePage()),
            '/sign-in': (context) => NoAuthGuard(child: SignInPage()),
            '/sign-up': (context) => NoAuthGuard(child: SignUpPage()),
            '/profile': (context) => AuthGuard(child: ProfilePage()),
            '/cari-dokter': (context) => AuthGuard(child: CariDokterPage()),
            '/detail-dokter': (context) => AuthGuard(
                  child: DetailDokterPage(
                    doctorId: ModalRoute.of(context)!.settings.arguments as int,
                  ),
                ),
            '/jadwal-konsultasi': (context) => AuthGuard(
                  child: JadwalKonsultasiPage(
                    scheduleId:
                        ModalRoute.of(context)!.settings.arguments as int,
                  ),
                ),

            '/forgot-password': (context) =>
                NoAuthGuard(child: ForgotPasswordPage()),
            '/pesan': (context) => AuthGuard(child: PesanPage()),
            '/list-pesan': (context) => AuthGuard(child: ListPesanPage()),
            '/input-diagnosa-pasien': (context) =>
                AuthGuard(child: InputDiagnosaPasienPage()),
            '/diagnosa-pasien': (context) =>
                AuthGuard(child: DiagnosaPasienPage()),
            '/riwayat': (context) => AuthGuard(child: RiwayatPage()),
            '/panduan-aplikasi': (context) =>
                AuthGuard(child: PanduanAplikasiPage()),
            '/panduan-obat': (context) => AuthGuard(child: PanduanObatPage()),
            '/panduan-fitur': (context) => AuthGuard(child: PanduanFiturPage()),
            '/obat-pasien': (context) => AuthGuard(child: MedicineListPage()),
            '/notifikasi': (context) => AuthGuard(child: NotifikasiPage()),
            '/rumah-sakit': (context) => AuthGuard(child: RumahSakitPage()),
          },
        ));
  }
}
