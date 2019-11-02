import 'package:matricula_provider/model/user.dart';

abstract class UserRepository{
  Future<int> insert(User user);
  Future<int> update(User user);
  Future<int> delete(User user);
  Future<List<User>> getList();
}