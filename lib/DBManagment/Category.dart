


class Category{
  final String name;
  final int numofCourses;
  final String image;

  Category(this.name, this.numofCourses, this.image);


}

List<Category> categories =  categorydata.map((item) => Category(item['name'], item['courses'], item['image'])).toList();


var categorydata=[
  {"name":"english","courses":10,"image":"assets/images/image1.jpg"},
  {"name":"math","courses":12,"image":"assets/images/image2.jpg"},
  {"name":"arabic","courses":14,"image":"assets/images/image3.jpg"},
  {"name":"html","courses":13,"image":"assets/images/image4.jpg"}
];