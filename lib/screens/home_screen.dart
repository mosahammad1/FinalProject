import 'package:final_project/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../model/usermodel.dart';
import '../service/userservice.dart';
import 'adduser.dart';
import 'edituser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<User> _userList;
  final _userService = UserService();

  getAllUserDetails() async {
    _userList = <User>[];
    var users = await _userService.readAllUsers();
    // _userList=<User>[];
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.address = user['address'];
        userModel.landmark = user['landmark'];
        userModel.pincode = user['pincode'];
        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnacBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  _deleteFromDialog(BuildContext context, useId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  var result = await _userService.deleteUser(useId);
                  if (result != null) {
                    setState(() {
                      Navigator.pop(context);
                    });
                    getAllUserDetails();
                    _showSuccessSnacBar('User Details Deleted Success');
                  }
                },
                child: const Text('Delete'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: const [
              UserAccountsDrawerHeader(
                  accountName: Text('Ahmad_mosa'),
                  accountEmail: Text("ahmad_mosa@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 0, 148, 47),
                  )),
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: Text("Help"),
                leading: Icon(Icons.help),
              ),
              ListTile(
                title: Text("About"),
                leading: Icon(Icons.help_center),
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.exit_to_app),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Add Address"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const ProfileScreen();
                  }));
                },
                icon: Icon(Icons.account_circle_rounded))
          ],
        ),
        body: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                width: 00,
                height: 150,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: const EdgeInsets.all(10),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : ${_userList[index].name ?? ''} ',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Mobile no : ${_userList[index].contact ?? ''} ',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Address : ${_userList[index].address ?? ''} ',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Landmark : ${_userList[index].landmark ?? ''} ',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Pincode : ${_userList[index].pincode ?? ''} ',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditUser(
                                    user: _userList[index],
                                  ))).then((data) {
                        if (data != null) {
                          getAllUserDetails();
                          _showSuccessSnacBar('User Details Updated Success');
                        }
                      });
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      _deleteFromDialog(context, _userList[index].id);
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ]),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddUser()))
                .then((data) {
              if (data != null) {
                getAllUserDetails();
                _showSuccessSnacBar('User Details Added Success');
              }
            });
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'edit',
            ),
          ],
        ));
  }
}
