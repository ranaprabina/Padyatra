import 'package:flutter/material.dart';
import 'package:padyatra/Animation.dart';
import 'package:padyatra/models/search_route_model/search_route_data.dart';
import 'package:padyatra/presenter/search_route_presenter.dart';
import 'package:padyatra/screen/RouteDetails.dart';
import 'package:padyatra/services/SearchedRoute.dart';

class SearchBar extends StatefulWidget {
  final userId;
  const SearchBar({Key key, this.userId}) : super(key: key);
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
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        FadeAnimation1(
          1.4,
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
                          routeNameList: routeNameList,
                          userId: widget.userId,
                        ),
                      );
                    },
                  );
                },
                readOnly: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onLoadSearchRouteComplete(List<SearchRoute> items) {
    setState(() {
      _searchRoute = items;
      _isLoading = false;
      print("Routes to be searched are");
      for (int i = 0; i < _searchRoute.length; i++) {
        final SearchRoute routesName = _searchRoute[i];
        print(routesName.routeName);
        routeNameList.add(routesName.routeName);
      }
    });
  }

  @override
  void onLoadSeachRouteError() {}
}

class RouteSearch extends SearchDelegate<String> {
  List routes = [];
  List<String> lastSearchedRoutes = [];
  String id;

  RouteSearch({List routeNameList, userId}) {
    routes = routeNameList;
    id = userId;
    lastSearchedRoute();
  }

  lastSearchedRoute() async {
    lastSearchedRoutes = await UserSearchHistory().getSearchHistory();
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
    // show some results based on the selection
    // throw UnimplementedError();

    final suggestionList = query.isEmpty
        ? lastSearchedRoutes
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
            close(context, query);
            UserSearchHistory().storeUserSearchHistory(query);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RouteDetailsScreen(
                      searchedRouteName: query,
                      id: id,
                    )));
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
        ? lastSearchedRoutes
        : routes
            .where(
              (r) => r.toString().toLowerCase().contains(query),
            )
            .toList();

    return suggestionList == null
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
                  UserSearchHistory().storeUserSearchHistory(query);
                  close(context, query);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RouteDetailsScreen(
                            searchedRouteName: query,
                            id: id,
                          )));
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
