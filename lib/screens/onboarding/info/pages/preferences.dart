import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walmart/FirestoreService/firestore_service.dart';
import 'package:walmart/screens/home/home_screen.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  final List<String> categories = [
    'Grocery',
    'Electronics',
    'Home & Kitchen',
    'Clothing',
    'Health & Beauty',
    'Toys & Games',
    'Sports & Outdoors',
    'Auto & Hardware',
  ];

  List<int> tapOrder = List.filled(8, 0);
  int currentTapCount = 0;

  bool get allItemsTapped => !tapOrder.contains(0);

  List<String> get orderedCategories {
    List<String> ordered = List.filled(8, '');
    for (int i = 0; i < tapOrder.length; i++) {
      if (tapOrder[i] != 0) {
        ordered[tapOrder[i] - 1] = categories[i];
      }
    }
    return ordered;
  }

  Future<void> saveOrderedCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('orderedCategories', orderedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.refresh),
              label: Text('Reset'),
              onPressed: () {
                setState(() {
                  tapOrder = List.filled(8, 0);
                  currentTapCount = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Text(
              'Please rank these item categories according to your interests',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: tapOrder[index] != 0 ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: tapOrder[index] != 0 ? Colors.blue : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        tapOrder[index] == 0 ? '' : '${tapOrder[index]}',
                        style: TextStyle(
                          fontSize: 18,
                          color: tapOrder[index] != 0 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  title: Text(categories[index]),
                  onTap: () {
                    setState(() {
                      if (tapOrder[index] == 0) {
                        currentTapCount++;
                        tapOrder[index] = currentTapCount;
                      }
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: allItemsTapped ? Colors.blue : Colors.grey,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: allItemsTapped
                    ? () async {
                        await saveOrderedCategories();
                         ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                        _submitPreferences();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      }
                    : null,
              ),
            ),
          ),
         ],
      ),
    );
  }
}

void _submitPreferences() async {
  FirestoreService _firestoreService= FirestoreService();
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid != null) {
    Map<String, dynamic> preferences = {
      'isPrefSelected': true,
      // Add other preferences here
    };

    await _firestoreService.updateUserPreferences(uid, preferences);

    // Navigate or provide feedback to the user after submitting preferences


  } else {
    // Handle the case where the user is not authenticated
    print("User is not authenticated");
  }
}



class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List<String> orderedCategories = [];

  @override
  void initState() {
    super.initState();
    _loadOrderedCategories();
  }

  Future<void> _loadOrderedCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      orderedCategories = prefs.getStringList('orderedCategories') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: orderedCategories.isNotEmpty
            ? ListView.builder(
                itemCount: orderedCategories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${index + 1}. ${orderedCategories[index]}'),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      
    );
  }
}
