import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/medicine_provider.dart';
import '../../models/medicine.dart';
// import 'medicine_detail_page.dart';

class MedicineListPage extends StatelessWidget {
  const MedicineListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Obat'),
      ),
      body: Consumer<MedicineProvider>(
        builder: (context, medicineProvider, child) {
          if (medicineProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (medicineProvider.errorMessage != null) {
            return Center(child: Text('Error: ${medicineProvider.errorMessage}'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: medicineProvider.medicines.length,
              itemBuilder: (ctx, index) {
                final medicine = medicineProvider.medicines[index];
                return GestureDetector(
                  // onTap: () {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => MedicineDetailPage(medicine: medicine),
                  //     ),
                  //   );
                  // },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicine.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Produsen: ${medicine.manufacturer}'),
                          SizedBox(height: 10),
                          Text('Dosis: ${medicine.dosage}'),
                          SizedBox(height: 10),
                          Text('Harga: ${medicine.price}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
