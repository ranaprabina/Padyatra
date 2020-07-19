import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // TextEditingController editingController = TextEditingController();

  Widget build(BuildContext context) {
    //list of items in the list view
    // final List<String> items = <String>['A', 'B', 'c', 'D', 'E'];
    // final List<TrekkingRoutes> _allTrekkingRoutes =
    //     TrekkingRoutes.allTrekkingRoutes();
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Container(
          // Search Bar
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {},
              // controller: editingController,
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  contentPadding: EdgeInsets.all(1),
                  labelText: "Enter Trekking Route or Trial",
                  hintText: "Search",
                  suffixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 0),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.black,
                      onPressed: () {
                        print("Search Button clicked");
                      },
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
          ),
        ),

        // Container containing Text 'You might like this'
        // Container(
        //   width: double.infinity,
        //   margin: EdgeInsets.fromLTRB(12, 10, 0, 0),
        //   child: Text(
        //     'You might like this',
        //     textAlign: TextAlign.start,
        //     style: TextStyle(
        //       fontFamily: 'Roboto',
        //       fontWeight: FontWeight.w400,
        //       fontSize: 22,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
