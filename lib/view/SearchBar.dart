import 'package:flutter/material.dart';
import 'package:padyatra/models/search_route_model/search_route_data.dart';
import 'package:padyatra/presenter/search_route_presenter.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    implements SearchRouteListViewContract {
  SearchRouteListPresenter _presenter;
  List<SearchRoute> _searchRoute;
  bool _isLoading;
  List routeNameList = [];
  String searchingRoute;
  _SearchBarState() {
    _presenter = new SearchRouteListPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadRoutesName();
  }

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
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                contentPadding: EdgeInsets.all(1),
                // labelText: "Enter Trekking Route or Trial",
                hintText: "Enter Trekking Route or Trial",
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  print("Search box tapped");
                  showSearch(
                    context: context,
                    delegate: RouteSearch(
                      recentRouteList: routeNameList,
                    ),
                  );
                });
              },
              readOnly: true,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onLoadSearchRouteComplete(List<SearchRoute> items) {
    // TODO: implement onLoadSearchRouteComplete
    setState(() {
      _searchRoute = items;
      _isLoading = false;
      print("Routes to be searched are");
      for (int i = 0; i < _searchRoute.length; i++) {
        final SearchRoute routesName = _searchRoute[i];
        // print(_searchRoute[i]);
        print(routesName.routeName);
        routeNameList.add(routesName.routeName.toLowerCase());
      }
    });
  }

  @override
  void onLoadSeachRouteError() {
    // TODO: implement onLoadSeachRouteError
  }
}

class RouteSearch extends SearchDelegate<String> {
  List routes = [];
  List recentRoutes = [
    "Annapurna Base Camp Trek",
    "Mardi Himal Trek",
    "Poon Hill Trek",
  ];

  String searchingRoute;
  RouteSearch({List recentRouteList}) {
    routes = recentRouteList;
  }

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
      color: Colors.amber,
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
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showResults(context);
            print("onTap Tapped");
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
        );
      },
    );
  }
}
