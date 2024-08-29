import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Job {
  final String id;
  final String title;
  final String description;
  final String requirements;
  final String location;
  final double salary;
  final String category;
  final String employerId;
  final String employerName; // Added employerName field
  final String rate;
  final String imageUrl;
  final DateTime timestamp;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.requirements,
    required this.location,
    required this.salary,
    required this.category,
    required this.employerId,
    required this.employerName,
    required this.rate,
    required this.imageUrl,
    required this.timestamp,
  });
}

class Jobs with ChangeNotifier {
  List<Job> _jobs = [];

  List<Job> get jobs {
    return [..._jobs];
  }

  // Listen to jobs collection changes
  void listenToJobs() {
    FirebaseFirestore.instance
        .collection('jobs')
        .snapshots()
        .listen((snapshot) {
      _jobs = snapshot.docs.map((doc) {
        return Job(
          id: doc.id,
          title: doc.get('title'),
          description: doc.get('description'),
          requirements: doc.get('requirements'),
          location: doc.get('location'),
          salary: doc.get('salary'),
          category: doc.get('category'),
          employerId: doc.get('employerId'),
          employerName: doc.get('employerName'),
          rate: doc.get('rate'),
          imageUrl: doc.get('imageUrl'),
          timestamp: (doc.get('timestamp') as Timestamp).toDate(),
        );
      }).toList();
      notifyListeners();
    });
  }

  // Fetch jobs posted by a specific employer
  Future<void> fetchJobsByEmployer(String employerId) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('jobs')
          .where('employerId', isEqualTo: employerId) // Filter by employerId
          .get();

      _jobs = snapshot.docs.map((doc) {
        return Job(
          id: doc.id,
          title: doc.get('title'),
          description: doc.get('description'),
          requirements: doc.get('requirements'),
          location: doc.get('location'),
          salary: doc.get('salary'),
          category: doc.get('category'),
          employerId: doc.get('employerId'),
          employerName: doc.get('employerName'),
          rate: doc.get('rate'),
          imageUrl: doc.get('imageUrl'),
          timestamp: (doc.get('timestamp') as Timestamp).toDate(),
        );
      }).toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching jobs by employer: $error');
      throw Exception('Could not fetch jobs for this employer: $error');
    }
  }

  // Fetch jobs once
  Future<void> fetchJobs(BuildContext context) async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('jobs').get();

      _jobs = snapshot.docs.map((doc) {
        return Job(
          id: doc.id,
          title: doc.get('title'),
          description: doc.get('description'),
          requirements: doc.get('requirements'),
          location: doc.get('location'),
          salary: doc.get('salary'),
          category: doc.get('category'),
          employerId: doc.get('employerId'),
          employerName: doc.get('employerName'), // Fetch employerName
          rate: doc.get('rate'),
          imageUrl: doc.get('imageUrl'),
          timestamp: (doc.get('timestamp') as Timestamp).toDate(),
        );
      }).toList();

      notifyListeners();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching jobs: $error'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> deleteJob(String jobId) async {
    try {
      await FirebaseFirestore.instance.collection('jobs').doc(jobId).delete();

      _jobs.removeWhere((job) => job.id == jobId);
      notifyListeners();
      print('Job deleted successfully: $jobId');
    } catch (error) {
      print('Error deleting job: $error');
      throw Exception('Could not delete the job: $error');
    }
  }

  // Add new job
  Future<void> addJob(Job job) async {
    try {
      final docRef = await FirebaseFirestore.instance.collection('jobs').add({
        'title': job.title,
        'description': job.description,
        'requirements': job.requirements,
        'location': job.location,
        'salary': job.salary,
        'category': job.category,
        'employerId': job.employerId,
        'employerName': job.employerName, // Include employerName when adding
        'rate': job.rate,
        'imageUrl': job.imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Add the job locally as well
      _jobs.add(
        Job(
          id: docRef.id,
          title: job.title,
          description: job.description,
          requirements: job.requirements,
          location: job.location,
          salary: job.salary,
          category: job.category,
          employerId: job.employerId,
          employerName: job.employerName, // Add locally
          rate: job.rate,
          imageUrl: job.imageUrl,
          timestamp: job.timestamp,
        ),
      );

      notifyListeners();
    } catch (error) {
      print('Error adding job: $error');
      rethrow;
    }
  }

  // Find job by ID
  Job findById(String id) {
    return _jobs.firstWhere((job) => job.id == id);
  }

  List<Job> findByEmployer(String id) {
    return _jobs.where((job) => job.employerId == id).toList();
  }

  List<Job> getJobsByCategory(String categoryId) {
    return _jobs.where((job) => job.category == categoryId).toList();
  }
}
