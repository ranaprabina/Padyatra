import 'package:flutter/material.dart';
import 'package:padyatra/models/search_route_model/search_route_data.dart';
import 'package:padyatra/presenter/search_route_presenter.dart';
import 'package:padyatra/screen/RouteDetails.dart';

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
          margin: EdgeInsets.symmetric(horizontal: 10),

          // Search Bar
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
                setState(
                  () {
                    print("Search box tapped");
                    showSearch(
                      context: context,
                      delegate: RouteSearch(
                        recentRouteList: routeNameList,
                      ),
                    );
                  },
                );
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
        routeNameList.add(routesName.routeName);
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

    final suggestionList = query.isEmpty
        ? recentRoutes
        : routes
            .where(
              (r) => r.toString().toLowerCase().contains(query),
            )
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            query = suggestionList[index].toString();
            // print("onTap Tapped");
            close(context, query);
            print("final searched result is");
            print(query);
            //TODO: Navigate to Route information screen
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    RouteDetailsScreen(searchedRouteName: query)));
          },
          leading: Icon(Icons.directions_walk),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    // throw UnimplementedError();
    final suggestionList = query.isEmpty
        ? recentRoutes
        : routes
            .where(
              (r) => r.toString().toLowerCase().contains(query),
            )
            .toList();

    return suggestionList.isEmpty
        ? Text(
            'No results Found..',
            style: TextStyle(
              fontSize: 20,
            ),
          )
        : ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = suggestionList[index].toString();
                  close(context, query);
                  //TODO: Navigate to Route information screen
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          RouteDetailsScreen(searchedRouteName: query)));
                  showResults(context);
                  print("onTap Tapped");
                  // close(context, query);
                  print(query);
                },
                title: RichText(
                  text: TextSpan(
                    text: suggestionList[index].substring(0, query.length),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                    children: [
                      TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
