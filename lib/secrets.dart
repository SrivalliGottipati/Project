List<dynamic> all_users = [
  {'name': 'admin', 'password': '12345', 'email': 'admin@gmail.com'}
];
void addUser(String name, String password, String email) {
  Map<String, String> singleUser = {
    'name': name,
    'password': password,
    'email': email
  };
  all_users.add(singleUser);
}

bool? validateUser(String name, String password) {
  // ignore: dead_code
  for (int i = 0; i < all_users.length; i++) {
    if (all_users[i]['name'] == name && all_users[i]['password'] == password) {
      final_email = all_users[i]['email']!;
      return true;
    }
  }
  return false;
}

String final_user = '';
String final_pass = '';
String final_email = '';

bool didSkip = false;
