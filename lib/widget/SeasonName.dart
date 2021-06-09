import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:padyatra/control_sizes.dart';
import 'package:padyatra/widget/SeasonalRoutesCarousel.dart';

class SeasonName extends StatefulWidget {
  final userId;

  const SeasonName({Key key, this.userId}) : super(key: key);
  @override
  _SeasonNameState createState() => _SeasonNameState();
}

class _SeasonNameState extends State<SeasonName> {
  String userId;
  List<String> seasonName = ['spring', 'summer', 'autumn', 'winter'];
  List<String> _filters;
  PersistentBottomSheetController buttomSheetController;
  bool _isSelected;

  @override
  void initState() {
    userId = widget.userId;
    _filters = <String>[];
    _isSelected = false;
    super.initState();
  }

  buildSeasonalRoutesList(String seasonName) {
    buttomSheetController = showBottomSheet(
        context: context,
        builder: (context) => Container(
              margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
              height: displayHeight(context) * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: SeasonalRoutesCarousel(
                  seasonName: seasonName, userId: userId),
            ));
    buttomSheetController.closed.then((value) => {
          reverseSelectedBoolValue(false),
          _filters.clear(),
        });
  }

  void reverseSelectedBoolValue(bool value) {
    setState(() {
      _isSelected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: (displayHeight(context) -
                  MediaQuery.of(context).padding.top -
                  kTextTabBarHeight) *
              0.07,
          child: ListView.builder(
            itemCount: seasonName.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: FilterChip(
                  label: Text(seasonName[index],
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  selected: _filters.contains(seasonName[index]),
                  selectedColor: _isSelected ? Colors.green : Colors.black54,
                  checkmarkColor: Colors.white,
                  backgroundColor: Colors.black54,
                  onSelected: (bool selected) {
                    setState(() {
                      _isSelected = selected;

                      if (selected) {
                        if (_filters.isEmpty) {
                          _filters.add(seasonName[index]);
                          buildSeasonalRoutesList(seasonName[index]);
                        } else {
                          _filters.clear();
                          _filters.add(seasonName[index]);
                          buildSeasonalRoutesList(seasonName[index]);
                        }
                      } else {
                        _isSelected = selected;
                        buttomSheetController.close();
                        _filters.removeWhere((String name) {
                          return name == seasonName[index];
                        });
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
