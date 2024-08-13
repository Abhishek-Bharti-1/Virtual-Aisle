import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:walmart/screens/home/pages/model/walmart_data.dart';
import 'package:walmart/screens/home/pages/qr_scanner.dart';

class SelectOptionsScreen extends StatefulWidget {
  final BuildingAddress buildingAddress;

  const SelectOptionsScreen({Key? key, required this.buildingAddress})
      : super(key: key);
  @override
  _SelectOptionsScreenState createState() => _SelectOptionsScreenState();
}

class _SelectOptionsScreenState extends State<SelectOptionsScreen> {
  List<String> options = [
    'Grocery',
    'Electronics',
    'Home & Kitchen',
    'Clothing',
    'Health & Beauty',
    'Toys & Games',
    'Sports & Outdoors',
    'Auto & Hardware',
  ];

  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Walmart ${widget.buildingAddress.name}"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/wallmart.jpg",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "${widget.buildingAddress.address}",
                style: const TextStyle(fontSize: 18, color: Colors.black),
              )),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)),
            child: const Text(
              "Get Directions",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await EasyLauncher.url(
                  url:
                      "https://www.google.com/maps/search/${widget.buildingAddress.address}");
            },
          ),
          SizedBox(
            height: 12,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Text(
                "Select the categories of items you want to buy",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              )),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // This creates two columns
              childAspectRatio:
                  2.8, // Adjust aspect ratio for better look (optional)
              mainAxisSpacing: 4, // Spacing between rows
              crossAxisSpacing: 3, // Spacing between columns
              children: List.generate(options.length, (index) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(24),
                    color: selectedOptions.contains(options[index])
                        ? Colors.blue[200]
                        : Colors.white,
                  ),
                  child: CheckboxListTile(
                    checkboxShape: CircleBorder(eccentricity: 0.5),
                    activeColor: Colors.blue,
                    title: Text(options[index]),
                    value: selectedOptions.contains(options[index]),
                    selectedTileColor: Colors.blue,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedOptions.add(options[index]);
                        } else {
                          selectedOptions.remove(options[index]);
                        }
                      });
                    },
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: selectedOptions.isNotEmpty
                      ? WidgetStatePropertyAll(Colors.blue)
                      : WidgetStatePropertyAll(Colors.grey)),
              child: const Text(
                "Proceed",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (selectedOptions.isNotEmpty) {
                  if(!selectedOptions.contains('Checkout counter')) selectedOptions.add('Checkout counter');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ResultScreen(selectedOptions: selectedOptions, buildingAddress: widget.buildingAddress,),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final List<String> selectedOptions;
  final BuildingAddress buildingAddress;

  const ResultScreen({Key? key, required this.selectedOptions,required this.buildingAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  List<String> selectedOptions2 = selectedOptions;
  selectedOptions2.remove("Checkout counter");
    return Scaffold(
      appBar: AppBar(
        title: Text('${buildingAddress.name}'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Text(
                "Scan QR Code at the entrance of the store to proceed to be assited by AR in your shopping",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              )),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                  itemCount: selectedOptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${index+1}.  ${selectedOptions[index]}"),
                    );
                  },
                ),
              ),
            ],
          ),
          // Position the button at the bottom
          Positioned(
            bottom: 20.0, // Adjust spacing from bottom as needed
            left: 20.0, // Adjust horizontal spacing as needed
            right: 20.0, // Adjust horizontal spacing as needed
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40.0, // Account for paddings
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:WidgetStatePropertyAll(Colors.blue),
                ),
                child: const Text(
                  "Scan QR Code",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QRScannerScreen()
                    ),
                  );// Your button functionality here
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

