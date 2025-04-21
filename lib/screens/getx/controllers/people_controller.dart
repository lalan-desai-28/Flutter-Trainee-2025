import 'package:flutter_trainee_2025/models/person.dart';
import 'package:get/get.dart';

class PeopleController extends GetxController {
  RxList<Person> people = <Person>[].obs;

  void insert(Person person) => people.add(person);

  void removeAt(int index) => people.removeAt(index);

  void updateAt(int index, Person person) => people[index] = person;
  
  void deleteAt(int index) => people.removeAt(index);
}
