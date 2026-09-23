import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/getRoomResources.dart';
import 'package:notehive/Screens/resourceDetails.dart';
import 'package:notehive/Structures/resourcesStructure.dart';
import '../widgets/leadingbackButton.dart';

class PendingApprovalScreen extends StatefulWidget {
  final String roomId;
  PendingApprovalScreen({super.key, required this.roomId});

  @override
  State<PendingApprovalScreen> createState() => _PendingApprovalScreenState();
}

class _PendingApprovalScreenState extends State<PendingApprovalScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: LeadingBackButton(context),
        title: Text(
          'Pending Approvals',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getResourcesNeedsApproval(roomId: widget.roomId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No pending approvals.'));
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 16);
            },
            itemBuilder: (context, index) {
              Resource item = Resource.fromMap(
                snapshot.data!.docs[index].data() as Map<String, dynamic>,
              );
              return PendingApprovalCard(
                title: item.title,
                subtitle: item.description,
                category: item.category,
                author: item.authorName,
                status: item.approved ? 'approved' : 'pending',
                onPreview: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ResourceDetailsScreen(resource: item, resourceId: snapshot.data!.docs[index].id)));
                },
                onApprove: () async {
                  await FirebaseFirestore.instance
                      .collection('Resources')
                      .doc(snapshot.data!.docs[index].id)
                      .update({'Approved': true});
                  setState(() {

                  });
                },
                onReject: () async {
                  await FirebaseFirestore.instance
                      .collection('Resources')
                      .doc(snapshot.data!.docs[index].id)
                      .delete();
                  setState(() {

                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _ApprovalItemData {
  String title;
  String unit;
  String subtitle;
  String category;
  String author;
  String status;

  _ApprovalItemData({
    required this.title,
    required this.unit,
    required this.subtitle,
    required this.category,
    required this.author,
    required this.status,
  });
}

// Single Box / Card class for all approval items following project structure
class PendingApprovalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String category;
  final String author;
  final String status;
  final VoidCallback? onPreview;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  PendingApprovalCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.author,
    this.status = 'pending',
    this.onPreview,
    this.onApprove,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF352E60).withOpacity(0.12),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF1A1730), width: 1.5),
                ),
                child: Icon(Icons.subject, color: Color(0xFF1A1730), size: 24),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1730),
                              fontFamily: 'paragraph',
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8A889A),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFF3F2F8),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xFF352E60).withOpacity(0.08),
                            ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF352E60),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'by $author',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF352E60).withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 42,
                  child: OutlinedButton(
                    onPressed: onPreview,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Color(0xFF352E60).withOpacity(0.12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1730),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: SizedBox(height: 42, child: _buildApproveButton()),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: SizedBox(height: 42, child: _buildRejectButton()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApproveButton() {
    if (status == 'approved') {
      return ElevatedButton(
        onPressed: onApprove,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF22C55E),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Approved ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(Icons.done_all, color: Colors.white, size: 18),
          ],
        ),
      );
    } else if (status == 'rejected') {
      return ElevatedButton(
        onPressed: onApprove,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8474F0).withOpacity(0.3),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Approve ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(Icons.check, color: Colors.white, size: 18),
          ],
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onApprove,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF7C66FF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Approve ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(Icons.check, color: Colors.white, size: 18),
          ],
        ),
      );
    }
  }

  Widget _buildRejectButton() {
    if (status == 'rejected') {
      return ElevatedButton(
        onPressed: onReject,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF3B5C),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rejected ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(Icons.close, color: Colors.white, size: 18),
          ],
        ),
      );
    } else if (status == 'approved') {
      return ElevatedButton(
        onPressed: onReject,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFCE8EB).withOpacity(0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reject ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE55D73).withOpacity(0.4),
              ),
            ),
            Icon(
              Icons.close,
              color: Color(0xFFE55D73).withOpacity(0.4),
              size: 18,
            ),
          ],
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onReject,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFCE8EB),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reject ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE55D73),
              ),
            ),
            Icon(Icons.close, color: Color(0xFFE55D73), size: 18),
          ],
        ),
      );
    }
  }
}
