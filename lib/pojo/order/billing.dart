class billing {
  late String first_name;
  late String last_name;
  late String address_1;
  late String address_2;
  late String city;
  late String state;
  late String postcode;
  late String country;
  late String email;
  late String phone;

  billing(
      {first_name,
      last_name,
      address_1,
      address_2,
      city,
      state,
      postcode,
      country,
      email,
      phone});

  billing.short({
    required this.first_name,
    required this.address_1,
  });
}
