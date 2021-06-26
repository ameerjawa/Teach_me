

class Exam{
  final String examName;
  final String examSubject;
  final List<String> questions;
  final List<List<String>> answers;

  Exam(this.examName, this.examSubject, this.questions, this.answers);







}

// Future<List<Map<String,dynamic>>> getExamsFromFireBase() async {
//   QuerySnapshot<dynamic> d = await FirebaseFirestore.instance.collection(
//       'Exams').get();
//   List<dynamic> examsList = [];
//
//   d.docs.forEach((element) {
//     examsList.add(element);
//   });
//
//
//
//
//   debugPrint( examsList.toString());
//
// }