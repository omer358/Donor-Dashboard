import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to fetch all donors as a stream
  Stream<List<Map<String, dynamic>>> getAllDonors() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Optionally include document ID if needed
        return data;
      }).toList();
    });
  }

  Future<void> addDonation(Map<String, dynamic> donationData) async {
    await _firestore.collection('donationRequests').add(donationData);
  }

  // Method to fetch all blood donation requests including document IDs
  Stream<List<Map<String, dynamic>>> getBloodRequests() {
    return _firestore.collection('donationRequests').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Add the document ID to the data
        return data;
      }).toList();
    });
  }

  // Method to update donation request status
  Future<void> updateDonationRequest(String id, bool active) async {
    await _firestore.collection('donationRequests').doc(id).update({'active': active});
  }

  Future<void> deleteDonationRequest(String id) async {
    await _firestore.collection('donationRequests').doc(id).delete();
  }

}
