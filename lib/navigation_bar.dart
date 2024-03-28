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
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Container(
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(
              icon: Icons.home,
              index: 0,
              isSelected: selectedIndex == 0,
              context: context,
            ),
            _buildTabItem(
              icon: Icons.message,
              index: 1,
              isSelected: selectedIndex == 1,
              context: context,
            ),
            SizedBox(width: 48), // Placeholder for the floating action button
            _buildTabItem(
              icon: Icons.list,
              index: 2,
              isSelected: selectedIndex == 2,
              context: context,
            ),
            _buildTabItem(
              icon: Icons.person,
              index: 3,
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
    required int index,
    required bool isSelected,
    required BuildContext context,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        size: isSelected ? 34 : 28,
      ),
      color: isSelected
          ? alertColor
          : lightColor, // Use alertColor for selected item
      onPressed: () => onItemSelected(index),
    );
  }
}
