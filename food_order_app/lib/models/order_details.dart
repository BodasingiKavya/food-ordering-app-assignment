// lib/models/address_details.dart
import 'package:equatable/equatable.dart';

class AddressDetails extends Equatable {
  final String street;
  final String city;
  final String postalCode;

  const AddressDetails({
    required this.street,
    required this.city,
    required this.postalCode,
  });

  @override
  List<Object?> get props => [street, city, postalCode];
}