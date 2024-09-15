import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/donation_controller.dart';
import '../models/blood_type.dart'; // Assuming you moved the enum to its own file

class BloodRequest extends StatefulWidget {
  const BloodRequest({super.key});

  @override
  _BloodRequestState createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  final DonationController donationController = Get.put(DonationController());
  final TextEditingController locationController = TextEditingController();

  BloodType? selectedBloodType; // Store the selected blood type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donation Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blood Type Dropdown
              DropdownButtonFormField<BloodType>(
                value: selectedBloodType,
                hint: const Text('إختر نوع الدم'),
                decoration: InputDecoration(
                  labelText: 'نوع الدم',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: BloodType.values.map((BloodType bloodType) {
                  return DropdownMenuItem<BloodType>(
                    value: bloodType,
                    child: Text(bloodType.displayName),
                  );
                }).toList(),
                onChanged: (BloodType? newValue) {
                  setState(() {
                    selectedBloodType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Location Input Field
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'الموقع',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Add Donation Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedBloodType != null &&
                        locationController.text.isNotEmpty) {
                      donationController.addDonation({
                        'bloodType': selectedBloodType!.displayName,
                        'location': locationController.text.trim(),
                        'createdAt': DateTime.now(),
                        'active': true,
                      });
                      Get.snackbar(
                          'تم', 'تمت إضافة طلب الدم بنجاح!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white);
                    } else {
                      Get.snackbar('خطأ', 'الرجاء ملء كل الحقول',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      const Text('إضافة الطلب', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
