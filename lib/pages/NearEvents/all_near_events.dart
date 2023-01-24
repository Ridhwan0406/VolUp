import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/NearEvents/dummy_events.dart';
import 'package:flutter_application_1/pages/NearEvents/map_view.dart';
import 'package:flutter_application_1/pages/NearEvents/navigation_screen.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/route/routing_page.dart';
import 'package:flutter_application_1/widgets/build_drawer.dart';
import 'package:geolocator/geolocator.dart';

class AllNearEvents extends StatefulWidget {
  const AllNearEvents({Key? key}) : super(key: key);

  @override
  _AllNearEventsState createState() => _AllNearEventsState();
}

class _AllNearEventsState extends State<AllNearEvents> {
  Position? _currentUserPosition;
  double? distanceImMeter = 0.0;
  // Data data = Data();

  Future _getTheDistance() async {
    _currentUserPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // for (int i = 0; i < data.allnearevents.length; i++) {
    //   double storelat = data.allnearevents[i]['lat'];
    //   double storelng = data.allnearevents[i]['lng'];

    //   distanceImMeter = await Geolocator.distanceBetween(
    //     _currentUserPosition!.latitude,
    //     _currentUserPosition!.longitude,
    //     storelat,
    //     storelng,
    //   );
    //   var distance = distanceImMeter?.round().toInt();

    //   data.allnearevents[i]['distance'] = (distance! / 1000);
    //   setState(() {});
    // }
  }

  @override
  void initState() {
    _getTheDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: BuildDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1f9f13),
        title: Text("All Volunteer Events Near you"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),

        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('zTest_Jangan_buang_lagi').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasError) {
              return Text('Error: ${streamSnapshot.error}');
            }
            if (!streamSnapshot.hasData) {
              return CircularProgressIndicator();
            }
            return GridView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              double storelat = streamSnapshot.data!.docs[index]['latitude'];
              double storelng = streamSnapshot.data!.docs[index]['longitude'];

              // distanceImMeter = Geolocator.distanceBetween(
              //   _currentUserPosition!.latitude,
              //   _currentUserPosition!.longitude,
              //   storelat,
              //   storelng,
              // );
              
              var distance = distanceImMeter?.round().toInt();
              
              if (distance! <= 5000) {
                return GestureDetector(
                  onTap: () {
                    RoutingPage.goTonext(
                      context: context,
                      navigateTo: NavigationScreen(
                        storelat,
                        storelng

                        // double.parse(streamSnapshot.data!.docs[index]['latitude']),
                        // double.parse(streamSnapshot.data!.docs[index]['longitude'])
                      
                        // streamSnapshot.data!.docs[index]['latitude'],
                        // streamSnapshot.data!.docs[index]['longitude']
                    ),
                  );
                },
                
              child: Container(
                color: Color(0xff1f9f13),
                height: height * 0.9,
                width: width * 0.3,
                child: Column(
                  children: [
                    Container(
                      height: height * 0.12,
                        width: width,
                      child: Image.network(
                        streamSnapshot.data!.docs[index]['image'],
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      streamSnapshot.data!.docs[index]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Icon(Icons.location_on),
                    //     Text(
                    //       "${streamSnapshot.data!.docs[index]['distance'].round()} KM Away",
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        }
      );
    },
    )
      ),
    );
  }
}