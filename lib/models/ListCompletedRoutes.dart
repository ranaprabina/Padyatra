class ListCompletedRoutes {
  final String name;
  final String image;
  final String daystaken;
  final String length;

  ListCompletedRoutes({this.name, this.image, this.daystaken, this.length});

  static List<ListCompletedRoutes> allCompletedRoutes() {
    var lstofCompletedRoutes = new List<ListCompletedRoutes>();
    lstofCompletedRoutes.add(ListCompletedRoutes(
        name: 'Annapurna Base Camp',
        image: 'AC1.png',
        daystaken: '11 days',
        length: '112 km'));
    lstofCompletedRoutes.add(ListCompletedRoutes(
        name: 'Mardi Trek',
        image: 'AC2.png',
        daystaken: '15 days',
        length: '112 km'));
    lstofCompletedRoutes.add(ListCompletedRoutes(
        name: 'Upper Mustang Trek',
        image: 'AC6.jpg',
        daystaken: '11 days',
        length: '112 km'));

    return lstofCompletedRoutes;
  }
}
