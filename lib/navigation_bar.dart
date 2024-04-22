import 'package:flutter/material.dart';
import 'package:digisehat/theme.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: primaryColor,
      notchMargin: 6.0,
      child: Container(
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(
              icon: Icons.home,
              label: 'Beranda',
              index: 0,
              isSelected: selectedIndex == 0,
              context: context,
            ),
            _buildTabItem(
              icon: Icons.message,
              index: 1,
              label: 'Pesan',
              isSelected: selectedIndex == 1,
              context: context,
            ),
            SizedBox(width: 48),
            _buildTabItem(
              icon: Icons.list,
              index: 2,
              label: 'Transaksi',
              isSelected: selectedIndex == 2,
              context: context,
            ),
            _buildTabItem(
              icon: Icons.person,
              index: 3,
              label: 'Profil',
              isSelected: selectedIndex == 3,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required IconData icon,
    required String label, // Tambahkan parameter label
    required int index,
    required bool isSelected,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, '/pesan');
            break;
          case 2:
            Navigator.pushNamed(context, '/list');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isSelected ? 34 : 28,
            color: isSelected ? alertColor : lightColor,
          ),
          SizedBox(height: 4), // Jarak antara ikon dan label
          Text(
            label,
            style: TextStyle(
              color: isSelected ? alertColor : lightColor,
              fontSize: 12, // Sesuaikan ukuran font sesuai kebutuhan
            ),
          ),
        ],
      ),
    );
  }
}
