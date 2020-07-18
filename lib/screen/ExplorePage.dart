import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:padyatra/view/RecentlyAddedCarousel.dart';

import 'package:padyatra/view/Route_Carousel.dart';
import 'package:padyatra/view/SearchBar.dart';
import 'package:padyatra/view/Nearby_Carousel.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //The arrow_back icon in the appbar to return to
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  print('Icon is pressed');
                },
              );
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'पदयात्रा',
            style: TextStyle(
              color: Hexcolor('#4e718d'),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ExploreBody(),
      ),
    );
  }
}

class ExploreBody extends StatefulWidget {
  @override
  _ExploreBodyState createState() => _ExploreBodyState();
}

class _ExploreBodyState extends State<ExploreBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            SearchBar(),
            RouteCarousel(),
            Nearby(),
            RecentlyAdded(),
            

            ///add more as you wish
          ]),
        )
      ],
    );
  }
}

// class ExploreBody extends StatefulWidget {
//   @override
//   _ExploreBodyState createState() => _ExploreBodyState();
// }

// class _ExploreBodyState extends State<ExploreBody> {
//   // TextEditingController editingController = TextEditingController();

//   Widget build(BuildContext context) {
//     //list of items in the list view
//     // final List<String> items = <String>['A', 'B', 'c', 'D', 'E'];
//     // final List<TrekkingRoutes> _allTrekkingRoutes =
//     //     TrekkingRoutes.allTrekkingRoutes();
//     return Column(
//       children: <Widget>[
//         SizedBox(
//           height: 10.0,
//         ),
//         Container(
//           // Search Bar
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) {},
//               // controller: editingController,
//               decoration: InputDecoration(
//                   fillColor: Colors.grey.shade200,
//                   filled: true,
//                   contentPadding: EdgeInsets.all(1),
//                   labelText: "Enter Trekking Route or Trial",
//                   hintText: "Search",
//                   suffixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)))),
//             ),
//           ),
//         ),

//         // Container containing Text 'You might like this'
//         // Container(
//         //   width: double.infinity,
//         //   margin: EdgeInsets.fromLTRB(12, 10, 0, 0),
//         //   child: Text(
//         //     'You might like this',
//         //     textAlign: TextAlign.start,
//         //     style: TextStyle(
//         //       fontFamily: 'Roboto',
//         //       fontWeight: FontWeight.w400,
//         //       fontSize: 22,
//         //     ),
//         //   ),
//         // ),
//         RouteCarousel(),
//         RecentlyAdded(),
//         YourFav(),
//       ],
//     );
//   }
// }
