import 'package:tdd_demo/entities/user.dart';

abstract class IUserRepository{
  Future<User?> getUser(int id);
}