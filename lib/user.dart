// lib/user.dart

import 'package:hive/hive.dart';

part 'user.g.dart'; // This will be generated automatically

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  @HiveField(2)
  List<String> reviews; // List of reviews or preferences

  @HiveField(3)
  String paymentInfo; // Payment information (e.g., card number)

  User({
    required this.username,
    required this.password,
    this.reviews = const [],
    this.paymentInfo = '',
  });
}
