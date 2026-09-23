import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/auth_services.dart';
import 'package:notehive/FirebaseOperations/getMyUploads.dart';
import 'package:notehive/Screens/resourceDetails.dart';
import 'package:notehive/Structures/resourcesStructure.dart';
import '../widgets/cards.dart';

class MyUploads extends StatefulWidget {
  const MyUploads({super.key});

  @override
  State<MyUploads> createState() => _MyUploadsState();
}

class _MyUploadsState extends State<MyUploads> {
  @override
  Widget build(BuildContext context) {
    String uid = AuthServices.instance.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SafeArea(
        child: FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
          future: getMyUploads(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No uploads found.'));
            }
            var docs = snapshot.data!.reversed.toList();
            return ListView.separated(
              padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
              itemCount: docs.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                var data = docs[index].data()!;
                return MyUploadsCard(
                  title: data['Title'] ?? '',
                  subtitle: data['Description'] != null &&
                          data['Description'].toString().isNotEmpty
                      ? data['Description']
                      : (data['Category'] ?? ''),
                  method: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResourceDetailsScreen(
                          resource: Resource.fromMap(data),
                          resourceId: docs[index].id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 70,
      titleSpacing: 10,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton.outlined(
          iconSize: 30,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.chevron_left),
          style: IconButton.styleFrom(
            foregroundColor: Color(0xFF1A1730),
            shape: const CircleBorder(),
          ),
        ),
      ),
      title: Text(
        'My Uploads',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1A1730),
        ),
      ),
    );
  }
}
