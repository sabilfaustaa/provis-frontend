import 'package:flutter/material.dart';
import 'package:digisehat/theme.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemSelected(index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/list-pesan');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/riwayat');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

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
              isSelected: _selectedIndex == 0,
            ),
            SizedBox(width: 5),
            _buildTabItem(
              icon: Icons.message,
              index: 1,
              label: 'Pesan',
              isSelected: _selectedIndex == 1,
            ),
            SizedBox(width: 110),
            _buildTabItem(
              icon: Icons.list,
              index: 2,
              label: 'Riwayat',
              isSelected: _selectedIndex == 2,
            ),
            SizedBox(width: 5),
            _buildTabItem(
              icon: Icons.person,
              index: 3,
              label: 'Profil',
              isSelected: _selectedIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isSelected ? 34 : 28,
            color: isSelected ? alertColor : lightColor,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? alertColor : lightColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
