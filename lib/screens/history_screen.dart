import 'package:clone_zoom/constants/colors.dart';
import 'package:clone_zoom/resources/firebase_methods.dart';
import 'package:clone_zoom/widgets/meeting_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final Stream<QuerySnapshot> _meetingsStream = firestore
      .collection('zoom_users')
      .doc(firebaseAuth.currentUser!.uid)
      .collection('meetings')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meetings History'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: _meetingsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No meeting to view',
                style: TextStyle(
                  fontSize: 22,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final meetingData = snapshot.data!.docs[index];

              return MeetingListTile(
                meetingId: meetingData['meetingId'],
                meetingName: meetingData['meetingName'],
                createdAt: meetingData['createdAt'].toDate(),
              );
            },
          );
        },
      ),
    );
  }
}
