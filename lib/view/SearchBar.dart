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
                        showSearch(context: context, delegate: RouteSearch());
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

class RouteSearch extends SearchDelegate<String> {
  final routes = [
    "Annapurna Base Camp Trek",
    "Mardi Himal Trek",
    "Poon Hill Trek",
    "Manaslu Circuit",
  ];
  final recentRoutes = [
    "Annapurna Base Camp Trek",
    "Mardi Himal Trek",
    "Poon Hill Trek",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    // throw UnimplementedError();
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some results base on the selection
    // throw UnimplementedError();
    return Card(
      color: Colors.teal,
      // shape: StadiumBorder(),
      child: Center(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    // throw UnimplementedError();
    final suggestionList = query.isEmpty
        ? recentRoutes
        : routes.where((r) => r.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.directions_walk),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
