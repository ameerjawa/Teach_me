


import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addCourseToFireBase(Map<String,dynamic> data)async{

  CollectionReference courses = FirebaseFirestore.instance.collection("CoursesData");

  await courses.add(data);

}




/// **********
///
/// get categories from firebase
///
/// ******/

Future<List<Map<String,dynamic>>> getCategoriesFromFireBase() async{


  QuerySnapshot<dynamic> d= await FirebaseFirestore.instance.collection('CoursesData').get();
  List<String> categories=[];
  List<Map<String,dynamic>> categoriesList=[];
  List<String> categoriesimages=[];


  d.docs.forEach((element) {
    categories.add(element.id);
  });
  d.docs.forEach((element) {
    categoriesimages.add(element["categoryImage"]);
  });

  for (int i=0;i<categories.length;i++) {
    final int documents = await FirebaseFirestore.instance.collection(
        'CoursesData').doc(categories[i]).collection("Courses").get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.length;
    });
    categoriesList.add({"name":categories[i],"Courses":documents,"categoryImage":categoriesimages[i]});
  }
  return categoriesList;
}


// function that get name of catigories and return all the Courses There
Future<QuerySnapshot<Map<String, dynamic>>> getCategoryCoursesFromFireBase(String name)async{

  return    await FirebaseFirestore.instance
      .collection("CoursesData")
      .doc(name)
      .collection("Courses")
      .get();
}