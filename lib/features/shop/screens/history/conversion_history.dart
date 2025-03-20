// import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
// import 'package:flutter/material.dart';

// class ConversionHistory extends StatelessWidget {
//   const ConversionHistory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TAppBar(title: Text('Conversion History'),centerTitle: true),
//       body: Center(
//         child: Column(
//           children: [
//             Card(
//               margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16)),
//               elevation: 3,
//               child: const Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     Icon(Icons.send, size: 30, color: Colors.blue),
//                     SizedBox(width: 10),
//                     Text("You have no transfers",
//                         style: TextStyle(fontSize: 16, color: Colors.grey)),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:eproject_currensee/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ConversionHistory extends StatelessWidget {
  const ConversionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    List<dynamic> history = box.read<List>('conversionHistory') ?? [];

    return Scaffold(
      appBar: TAppBar(title: const Text('Conversion History'), centerTitle: true),
      body: history.isEmpty
          ? const Center(
              child: Text(
                "No conversion history available",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.swap_horiz, color: Colors.blue),
                    title: Text("${item['amount']} ${item['from']} → ${item['convertedAmount']} ${item['to']}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text("Converted on: ${item['timestamp'].split('.')[0]}", style: const TextStyle(color: Colors.grey)),
                  ),
                );
              },
            ),
    );
  }
}
