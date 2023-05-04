import 'package:flutter/material.dart';
import 'package:crud_app/users.dart';
import 'package:crud_app/main.dart';
import 'package:crud_app/edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("CRUD"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: "username"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(border: OutlineInputBorder(), hintText: "age"),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  FirestoreHelper.create(UserModel(username: _usernameController.text, age: _ageController.text));
                  // _create();
                },
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black54,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<List<UserModel>>(
                  stream: FirestoreHelper.read(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    }
                    if (snapshot.hasData) {
                      final userData = snapshot.data;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: userData!.length,
                            itemBuilder: (context, index) {
                              final singleUser = userData[index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  onLongPress: () {
                                    showDialog(context: context, builder: (context) {
                                      return AlertDialog(
                                        title: Text("Delete"),
                                        content: Text(" You sure want to Delete ??"),
                                        actions: [
                                          ElevatedButton(onPressed: () {
                                            FirestoreHelper.delete(singleUser).then((value) {
                                              Navigator.pop(context);
                                            });
                                          }, child: Text("Delete"))
                                        ],
                                      );
                                    });
                                  },
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.indigoAccent,
                                        gradient: new LinearGradient(
                                          colors: [Colors.redAccent, Colors.greenAccent],
                                          begin: Alignment.centerRight,
                                          end: new Alignment(-1.0, -1.0)
                                        ),
                                        shape: BoxShape.circle),
                                  ),
                                  title: Text("${singleUser.username}"),
                                  subtitle: Text("${singleUser.age}"),
                                  trailing: InkWell(onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(user: UserModel(username: singleUser.username, age: singleUser.age, id: singleUser.id),)));
                                  },child: Icon(Icons.edit)),
                                ),
                              );
                            }),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
