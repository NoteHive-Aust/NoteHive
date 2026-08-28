import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notehive/widgets/leadingTitleAndTailButton.dart';
import 'package:notehive/widgets/listTileForBrowseRoom.dart';

class Joinroom extends StatefulWidget {
  const Joinroom({super.key});

  @override
  State<Joinroom> createState() => _JoinroomState();
}

class _JoinroomState extends State<Joinroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Join Room')),
      body: Padding(
        padding: EdgeInsets.only(top: 40,left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      'Enter Room Code',
                      style: TextStyle(
                        fontFamily: 'Heading',
                        fontSize: 20,
                        wordSpacing: 2,
                        color: Color(0xff1A1730),
                        //letterSpacing: ,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Ask your Admin for Room Joining Code',
                      style: TextStyle(
                        fontFamily: 'paragraph',
                        fontSize: 14,
                        wordSpacing: 2,
                        color: Color(0xff352E60),
                        //letterSpacing: ,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

          
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 60,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xff352E60).withOpacity(0.1))
                ),
                child: TextField(
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Enter 6 Digit Code',
                      visualDensity: VisualDensity.compact,
                    )
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFF8474F0),
                    padding:  EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    'Join Room',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(

                children: [
                  Expanded(child: Divider()),
                  Text('  or  ',style: TextStyle(
                      fontFamily: 'paragraph'
                  ),),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFF352E60),
                    padding:  EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_outlined,size: 20,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text(
                        'Scan QR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40,),
              LeadingTitleAndTailButton(context: context,title: 'Browse Public Rooms',buttonText: 'See All',method: Navigator.of(context).pop),
              ListView.separated(
                shrinkWrap: true,
                // /padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return listTileforBrowseRoom(context: context,title: 'Data Structure | 1205',member: 15);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
