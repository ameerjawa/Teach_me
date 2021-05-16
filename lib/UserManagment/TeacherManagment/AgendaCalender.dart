

import 'package:teach_me/DBManagment/Lession.dart';

class AgendaCalender{

final List<Lession> Lessions;

  AgendaCalender(this.Lessions);

  void addLession(Lession lession){
    this.Lessions.add(lession);
  }

  void deleteLession(Lession lession){
    this.Lessions.remove(lession);

  }



}