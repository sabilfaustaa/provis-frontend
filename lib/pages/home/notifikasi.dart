import 'package:digisehat/helpers.dart';
import 'package:digisehat/theme.dart';
// import 'package:digisehat/navigation_bar.dart';
// import 'package:digisehat/providers/doctor_provider.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => NotifikasiPageState();
}

class NotifikasiPageState extends State<NotifikasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: AssetImage('profile-home.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 6),
            DropdownButton(
              items: [
                DropdownMenuItem(
                  value: "profile",
                  child: Text("Profil"),
                  onTap: () {
                    redirectTo(context, "/profile");
                  },
                ),
                DropdownMenuItem(
                  value: "change_password",
                  child: Text("Ubah Password"),
                  onTap: () {
                    redirectTo(context, "/ubah-password");
                  },
                ),
              ],
              onChanged: (value) {},
              hint: Text("Hai, Defrizal", style: lightTextStyle),
              underline: Container(),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: secondaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notification_important, color: alertColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    // controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari apa yang kamu butuhkan....',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: khakiColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: alertColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search, color: lightColor),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildNotificationItem(
                      'Minum Obat',
                      'Sekarang!',
                      'Waktunya Minum obat Asiklovir !!',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String subTitle,
    String content,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10), // Mengubah padding vertikal
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: priceColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.vaccines, // Icon yang digunakan
                  color: secondaryColor, // Warna ikon
                ),
                SizedBox(width: 10), // Spacer antara ikon dan teks
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  subTitle,
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white, // Warna garis pemisah
              thickness: 1, // Ketebalan garis pemisah
              height: 20, // Jarak vertikal di sekitar garis
            ),
            Container(
              padding: EdgeInsets.all(8.0), // Padding di sekitar konten
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: alertColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
