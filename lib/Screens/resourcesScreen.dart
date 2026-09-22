import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/getRoomResources.dart';
import 'package:notehive/Structures/resourcesStructure.dart';
import 'package:notehive/Structures/roomStructure.dart';
import 'package:notehive/widgets/leadingbackButton.dart';
import 'package:notehive/widgets/listTileForResources.dart';

class ResourcesScreen extends StatefulWidget {
  final String? filtered;
  final Room room;
  final String roomId;
  const ResourcesScreen({super.key, this.filtered,required this.room, required this.roomId,});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  late String filteredBy;
  @override
  void initState() {
    if (widget.filtered != null && widget.filtered!='All') {
      filteredBy = "${widget.filtered}";
    } else {
      filteredBy = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: filteredBy==""?Text('Resources'):Text("Resources - ${filteredBy}"),
        leading: LeadingBackButton(context),
        leadingWidth: 70,
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),
            style: IconButton.styleFrom(
              backgroundColor: Color(0xff8474F0),
              foregroundColor: Colors.white,
            ),
            onSelected: (String value) {
              setState(() {
                if(value.toString()!='All'){
                filteredBy=value.toString();}else{
                  filteredBy="";
                }
              });

            },
            itemBuilder: (BuildContext context) {
              return widget.room.categories.map((dynamic choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: FutureBuilder(
            future: filteredBy !=""? getRoomResourcesFiltered(roomId: widget.roomId, filter: filteredBy):getRoomResources(roomId: widget.roomId),
            
            builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          print(snapshot.data!.docs.length);
          return  ListView.separated(
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            //padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
            itemCount: snapshot.data!.docs.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return ResourcesListTile(
                context: context,
                resource: Resource.fromMap(
                  snapshot.data!.docs[index].data()
                  as Map<String, dynamic>,
                ), resourceID: snapshot.data!.docs[index].id,
              );
            },
          );
        })
        

       ),
    );
  }
}
