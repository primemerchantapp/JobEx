import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class JobApplication {
  final String id; // Unique ID for the application
  final String jobId;
  final String userId;
  final String firstName;
  final String lastName;
  final String contactNumber;
  final String coverLetter;
  final String additionalDetails;
  final String resumePath;
  final DateTime timestamp;
  final String status;

  JobApplication({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.contactNumber,
    required this.coverLetter,
    required this.additionalDetails,
    required this.resumePath,
    required this.timestamp,
    required this.status,
  });
}

class JobApplications with ChangeNotifier {
  List<JobApplication> _applications = [];

  List<JobApplication> get applications {
    return [..._applications];
  }

  Future<void> fetchApplicationsForJob(String jobId) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('applications')
          .where('jobId', isEqualTo: jobId)
          .get();

      _applications = snapshot.docs.map((doc) {
        return JobApplication(
          id: doc.id,
          jobId:
              doc['jobId'] ?? '', // Ensure defaults in case of missing fields
          userId: doc['userId'] ?? '',
          firstName: doc['firstName'] ?? '',
          lastName: doc['lastName'] ?? '',
          contactNumber: doc['contactNumber'] ?? '',
          coverLetter: doc['coverLetter'] ?? '',
          additionalDetails: doc['additionalDetails'] ?? '',
          resumePath: doc['resumePath'] ?? '',
          timestamp: (doc['timestamp'] as Timestamp).toDate(),
          status: doc['status'] ?? 'pending', // Default status if missing
        );
      }).toList();

      notifyListeners();
    } catch (error) {
      debugPrint('Error fetching applications: $error'); // Improved logging
      // Optionally, handle specific error types, e.g., network issues
      if (error is FirebaseException && error.code == 'not-found') {
        debugPrint('No applications found for the given job ID.');
      }
      rethrow; // Re-throw to handle it elsewhere in the app
    }
  }

  // Add a new application to Firestore
  Future<void> addApplication({
    required String jobId,
    required String userId,
    required String firstName,
    required String lastName,
    required String contactNumber,
    required String coverLetter,
    required String additionalDetails,
    required String resumePath,
  }) async {
    try {
      final newApplication = JobApplication(
        id: '', // Firestore will generate this automatically
        jobId: jobId,
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        contactNumber: contactNumber,
        coverLetter: coverLetter,
        additionalDetails: additionalDetails,
        resumePath: resumePath,
        timestamp: DateTime.now(),
        status: 'pending',
      );

      final docRef =
          await FirebaseFirestore.instance.collection('applications').add({
        'jobId': newApplication.jobId,
        'userId': newApplication.userId,
        'firstName': newApplication.firstName,
        'lastName': newApplication.lastName,
        'contactNumber': newApplication.contactNumber,
        'coverLetter': newApplication.coverLetter,
        'additionalDetails': newApplication.additionalDetails,
        'resumePath': newApplication.resumePath,
        'timestamp': newApplication.timestamp,
        'status': newApplication.status,
      });

      // Update the local list with the new application
      _applications.add(
        JobApplication(
          id: docRef.id,
          jobId: newApplication.jobId,
          userId: newApplication.userId,
          firstName: newApplication.firstName,
          lastName: newApplication.lastName,
          contactNumber: newApplication.contactNumber,
          coverLetter: newApplication.coverLetter,
          additionalDetails: newApplication.additionalDetails,
          resumePath: newApplication.resumePath,
          timestamp: newApplication.timestamp,
          status: newApplication.status,
        ),
      );

      notifyListeners();
    } catch (error) {
      print('Error adding application: $error');
      rethrow;
    }
  }

  // Update the status of an application (accept/reject)
  Future<void> updateApplicationStatus(
      String applicationId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('applications')
          .doc(applicationId)
          .update({
        'status': status,
      });

      // Update the local list
      final index = _applications.indexWhere((app) => app.id == applicationId);
      if (index != -1) {
        _applications[index] = JobApplication(
          id: _applications[index].id,
          jobId: _applications[index].jobId,
          userId: _applications[index].userId,
          firstName: _applications[index].firstName,
          lastName: _applications[index].lastName,
          contactNumber: _applications[index].contactNumber,
          coverLetter: _applications[index].coverLetter,
          additionalDetails: _applications[index].additionalDetails,
          resumePath: _applications[index].resumePath,
          timestamp: _applications[index].timestamp,
          status: status,
        );
        notifyListeners();
      }
    } catch (error) {
      print('Error updating application status: $error');
      rethrow;
    }
  }

  Future<void> acceptApplication(String applicationId) async {
    return updateApplicationStatus(applicationId, 'accepted');
  }

  // Reject an application
  Future<void> rejectApplication(String applicationId) async {
    return updateApplicationStatus(applicationId, 'rejected');
  }

  // Fetch the applications for a specific user
  Future<void> fetchApplicationsForUser(String userId) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('applications')
          .where('userId', isEqualTo: userId)
          .get();

      _applications = snapshot.docs.map((doc) {
        return JobApplication(
          id: doc.id,
          jobId: doc['jobId'],
          userId: doc['userId'],
          firstName: doc['firstName'],
          lastName: doc['lastName'],
          contactNumber: doc['contactNumber'],
          coverLetter: doc['coverLetter'],
          additionalDetails: doc['additionalDetails'],
          resumePath: doc['resumePath'],
          timestamp: (doc['timestamp'] as Timestamp).toDate(),
          status: doc['status'],
        );
      }).toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching user applications: $error');
      rethrow;
    }
  }
}
