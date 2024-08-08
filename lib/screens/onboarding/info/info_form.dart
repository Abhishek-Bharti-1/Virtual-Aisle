import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:walmart/screens/onboarding/info/pages/preferences.dart';

class InfoForm extends StatefulWidget {
  const InfoForm({super.key});

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _states = [
    'Select State',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  String? _name;
  DateTime? _dob;
  String? _address;
  String? _gender;
  String? _state;
  String? _pinCode;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit
                                .fitHeight, // Change this to BoxFit.fill, BoxFit.contain, etc. as needed
                          )
                        : null,
                  ),
                  child: _image == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.blue,
                        )
                      : null,
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                controller: TextEditingController(
                    text: _dob != null
                        ? _dob!.toLocal().toString().split(' ')[0]
                        : ''),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dob ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != _dob) {
                    setState(() {
                      _dob = pickedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _address = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Gender'),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Male'),
                      leading: Radio<String>(
                        value: 'Male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Female'),
                      leading: Radio<String>(
                        value: 'Female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _state,
                hint: Text('Select State'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _state = value;
                  });
                },
                items: _states.map((state) {
                  return DropdownMenuItem(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value == 'Select State') {
                    return 'Please select a state';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'PIN Code',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _pinCode = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your PIN code';
                  } else if (value.length != 6) {
                    return 'PIN code must be 6 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // ElevatedButton(
                
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.blue,
              //       foregroundColor: Colors.white,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(24),
              //       ),
              //       padding: EdgeInsets.all(12)),
              //   child: Text(
              //     'Next',
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),

              Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Process the data here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Preferences()),
                    );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Processing Data')),
                    // );
                }},
              ),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
