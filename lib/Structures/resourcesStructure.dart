import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String name;
  final String imageUrl;
  final String comment;
  final DateTime time;

  Comment({
    required this.name,
    required this.imageUrl,
    required this.comment,
    required this.time,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      name: map["Author"] ?? '',
      imageUrl: map["ImageUrl"] ?? ' ',
      comment: map["Comment"] ?? '',
      time: (map["time"] as Timestamp).toDate(),
    );
  }
}

class Resource {
  final String roomID;
  final String title;
  final String category;
  final String description;
  final String resourceUrl;
  final String authorName;
  final String authorSchoolName;
  final int downloads;
  final int views;
  final DateTime time;
  final bool approved;
  List<Comment> comments=[];
  Resource({
    required this.approved,
    required this.roomID,
    required this.title,
    required this.category,
    required this.description,
    required this.resourceUrl,
    required this.authorName,
    required this.authorSchoolName,
    required this.downloads,
    required this.views,
    required this.time,
    //required this.comments,
  });
  factory Resource.fromMap(Map<String, dynamic> data) {
    return Resource(
      approved: data['Approved'],
      roomID: data['RoomID'],
      time: (data['time'] as Timestamp).toDate(),
      title: data['Title'],
      category: data['Category'],
      description: data['Description'],
      resourceUrl: data['ResourceUrl'],
      authorName: data['AuthorName'],
      authorSchoolName: data['AuthorSchoolName'],
      downloads: data['Downloads'],
      views: data['Veiws'],
    );
  }
  Resource toMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Resource(
      approved: data['Approved'],
      roomID: data['RoomID'],
      time: (data['time'] as Timestamp).toDate(),
      title: data['Title'],
      category: data['Category'],
      description: data['Description'],
      resourceUrl: data['ResourceUrl'],
      authorName: data['AuthorName'],
      authorSchoolName: data['AuthorSchoolName'],
      downloads: data['Downloads'],
      views: data['Veiws'],
    );
  }
}
