class TrekkingRoutes {
  final String name;
  final String image;
  final String length;
  final String duration;
  final String difficulty;

  //Constructor
  TrekkingRoutes(
      {this.name, this.image, this.length, this.duration, this.difficulty});

  static List<TrekkingRoutes> allTrekkingRoutes() {
    var lstofTrekkingRoutes = new List<TrekkingRoutes>();
    lstofTrekkingRoutes.add(TrekkingRoutes(
        name: 'Annapurna Base Camp',
        image: 'AC1.png',
        length: '112km',
        duration: '12 days',
        difficulty: 'Moderate'));
    lstofTrekkingRoutes.add(TrekkingRoutes(
        name: 'Mardi Trek',
        image: 'AC2.png',
        length: '112km',
        duration: '12 days',
        difficulty: 'Hard'));
    lstofTrekkingRoutes.add(TrekkingRoutes(
        name: 'Australian Base Camp',
        image: 'AC6.jpg',
        length: '112km',
        duration: '12 days',
        difficulty: 'Easy'));
    lstofTrekkingRoutes.add(TrekkingRoutes(
        name: 'Upper Mustang Trek',
        image: 'AC7.jpg',
        length: '112km',
        duration: '12 days',
        difficulty: 'Moderate'));
    lstofTrekkingRoutes.add(TrekkingRoutes(
        name: 'Upper Mustang Trek',
        image: 'AC7.jpg',
        length: '112km',
        duration: '12 days',
        difficulty: 'Moderate'));
    lstofTrekkingRoutes.add(TrekkingRoutes(
        name: 'Upper Mustang Trek',
        image: 'AC7.jpg',
        length: '112km',
        duration: '12 days',
        difficulty: 'Moderate'));
    lstofTrekkingRoutes.add(TrekkingRoutes(
        name: 'Upper Mustang Trek',
        image: 'AC7.jpg',
        length: '112km',
        duration: '12 days',
        difficulty: 'Moderate'));
    lstofTrekkingRoutes.add(TrekkingRoutes(
        name: 'Upper Mustang Trek',
        image: 'AC7.jpg',
        length: '112km',
        duration: '12 days',
        difficulty: 'Moderate'));
    lstofTrekkingRoutes.add(TrekkingRoutes(
        name: 'Upper Mustang Trek',
        image: 'AC7.jpg',
        length: '112km',
        duration: '12 days',
        difficulty: 'Moderate'));
    return lstofTrekkingRoutes;
  }
}
