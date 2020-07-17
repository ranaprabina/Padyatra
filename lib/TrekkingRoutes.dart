class TrekkingRoutes {
  final String name;
  final String image;
  //Constructor
  TrekkingRoutes({this.name, this.image});
}

List<TrekkingRoutes> allTrekkingRoutes() {
  var lstofTrekkingRoutes = new List<TrekkingRoutes>();

  lstofTrekkingRoutes.add(TrekkingRoutes(name: 'ABC', image: ''));
  return lstofTrekkingRoutes;
}
