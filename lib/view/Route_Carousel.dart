import 'package:flutter/material.dart';
import 'package:padyatra/models/TrekkingRoutes.dart';

class RouteCarousel extends StatefulWidget {
  @override
  _RouteCarouselState createState() => _RouteCarouselState();
}

class _RouteCarouselState extends State<RouteCarousel> {
  final List<TrekkingRoutes> _allTrekkingRoutes =
      TrekkingRoutes.allTrekkingRoutes();
  PageController _pageController;
  int prevPage;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.65)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'You might like this',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 350.0,
          // color: Colors.red,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: _allTrekkingRoutes.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (BuildContext context, Widget widget) {
                  double value = 1;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page - index;
                    value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
                  }
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: Curves.easeInOut.transform(value) * 350.0,
                      // width: Curves.easeInOut.transform(value) * 350.0,
                      child: widget,
                    ),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    print("Route number $index clicked");
                  },
                  child: Container(
                    width: 210.0,
                    margin: EdgeInsets.all(10.0),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          bottom: 30,
                          child: Container(
                            child: Text('${_allTrekkingRoutes[index].name}'),
                          ),
                        ),
                        Positioned(
                          bottom: 60.0,
                          child: Container(
                            height: 70.0,
                            width: 220.0,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 70,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 4.5, 0, 0),
                                      child: Text(
                                        '${_allTrekkingRoutes[index].difficulty}',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          // backgroundColor: Colors.green,
                                          color: Colors.white,
                                          letterSpacing: 1.2,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            'Length',
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w100),
                                          ),
                                        ),
                                        Text(
                                          '${_allTrekkingRoutes[index].length}',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            'Duration',
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${_allTrekkingRoutes[index].duration}',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Image(
                                    height: 210,
                                    width: 220,
                                    fit: BoxFit.cover,
                                    image: AssetImage("images/" +
                                        _allTrekkingRoutes[index].image)),
                              ),
//
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
