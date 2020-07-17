class TrekkingRoutes {
  final String name;
  final String image;
  //Constructor
  TrekkingRoutes({this.name, this.image});

  static List<TrekkingRoutes> allTrekkingRoutes() {
    var lstofTrekkingRoutes = new List<TrekkingRoutes>();
    lstofTrekkingRoutes.add(TrekkingRoutes(name: 'ABC2', image: 'AC1.jpg'));
    lstofTrekkingRoutes.add(TrekkingRoutes(name: 'ABC', image: 'AC2.jpg'));
    lstofTrekkingRoutes.add(TrekkingRoutes(name: 'ABC2', image: 'AC1.jpg'));
    lstofTrekkingRoutes.add(TrekkingRoutes(name: 'ABC', image: 'AC2.jpg'));
    return lstofTrekkingRoutes;
  }
}
