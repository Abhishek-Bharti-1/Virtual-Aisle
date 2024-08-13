// import 'package:flutter/material.dart';

// class VisitStoreScreen extends StatefulWidget {
//   const VisitStoreScreen({super.key});
//   @override
//   State<VisitStoreScreen> createState() => _VisitStoreScreenState();
// }

// class _VisitStoreScreenState extends State<VisitStoreScreen> {
//   //String? selectedAddress;
//   final List<String> addresses = [
//     '12/1 Indiranagar Main Rd, Indiranagar, Bangalore 560038',
//     '45 Residency Rd, Shanthala Nagar, Ashok Nagar, Bangalore 560025',
//     '789 Koramangala 4th Block, Koramangala, Bangalore 560034',
//     '101 MG Road, Shanthala Nagar, Ashok Nagar, Bangalore 560001',
//     '202 Brigade Rd, Shanthala Nagar, Ashok Nagar, Bangalore 560025',
//     '34 Lavelle Rd, Ashok Nagar, Bangalore 560001',
//     '567 Cunningham Rd, Vasanth Nagar, Bangalore 560052',
//     '89 Church St, Shanthala Nagar, Ashok Nagar, Bangalore 560001',
//     '23 Vittal Mallya Rd, KG Halli, D\' Souza Layout, Bangalore 560001',
//     '456 100 Feet Rd, HAL 2nd Stage, Indiranagar, Bangalore 560038',
//   ];

// //  import 'package:flutter/material.dart';

// // class VisitStoreScreen extends StatefulWidget {
// //   const VisitStoreScreen({super.key});

// //   @override
// //   State<VisitStoreScreen> createState() => _VisitStoreScreenState();
// // }

// // class _VisitStoreScreenState extends State<VisitStoreScreen> {
//   final TextEditingController _searchController = TextEditingController();
// //   final List<String> addresses = [
// //     '123 Main St, Anytown, USA',
// //     '456 Elm St, Somewhere City, USA',
// //     '789 Oak Ave, Another Place, USA',
// //     '101 Pine Rd, Newville, USA',
// //     '202 Maple Dr, Old Town, USA',
// //   ];
//   List<String> filteredAddresses = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredAddresses = addresses;
//   }

//   void _filterAddresses(String query) {
//     setState(() {
//       filteredAddresses = addresses
//           .where(
//               (address) => address.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   void _navigateToQRScanPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => QRScanPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           Stack(
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.79,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [

//                   Container(
//                     margin: EdgeInsets.only(top: 40),
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: TextField(
//                       controller: _searchController,
//                       decoration: InputDecoration(
//                         hintText: "Search a store near you....",
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.search),
//                           onPressed: () =>
//                               _filterAddresses(_searchController.text),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       onChanged: _filterAddresses,
//                     ),
//                   ),
//                   Expa(
//                     child: ListView.builder(
//                       itemCount: filteredAddresses.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(filteredAddresses[index]),
//                           onTap: _navigateToQRScanPage,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class QRScanPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Scan QR Code',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement QR code scanning functionality here
//                 print('QR code scanning initiated');
//               },
//               child: Text('Start Scanning'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:walmart/screens/home/pages/enter_shopping_list.dart';
import 'package:walmart/screens/home/pages/model/walmart_data.dart';

class VisitStoreScreen extends StatefulWidget {
  const VisitStoreScreen({super.key});

  @override
  State<VisitStoreScreen> createState() => _VisitStoreScreenState();
}

class _VisitStoreScreenState extends State<VisitStoreScreen> {
  

  final List<BuildingAddress> addresses = buildingAddresses1;

  List<BuildingAddress> filteredAddresses = [];

  @override
  void initState() {
    super.initState();
    filteredAddresses = addresses;
  }

  void _filterAddresses(String query) {
  setState(() {
    if (query.isEmpty) {
      filteredAddresses = buildingAddresses1;
    } else {
      filteredAddresses = buildingAddresses1
          .where((buildingAddress) =>
              buildingAddress.name.toLowerCase().contains(query.toLowerCase()) ||
              buildingAddress.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    // var snackBar = SnackBar(content: Text("Yay Profile!"));
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 40, left: 12, right: 12),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        height: kTextTabBarHeight,
                        child: TextField(
                          onChanged: _filterAddresses,
                          decoration: InputDecoration(
                              hintText: "Search a store near you...."),
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(snackBar);
                        },
                        child: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredAddresses.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {
                     Navigator.push(
            context,
                     MaterialPageRoute(
              builder: (context) => SelectOptionsScreen(buildingAddress: filteredAddresses[index],),
            ),),
                  },
                  child: Container(
                    color: Colors.white,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/wallmart.jpg', // Replace with your image path
                              width: 140,
                              height: 180,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 200,
                                    child: Text(
                                      "Walmart ${filteredAddresses[index].name}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    )),
                                    SizedBox(height: 25,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on_sharp,color: Colors.black54,),
                                    Container(
                                        width: 200,
                                        child: Text(
                                          filteredAddresses[index].address,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 15),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
