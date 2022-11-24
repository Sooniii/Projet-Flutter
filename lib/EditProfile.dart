
import 'package:flutter/material.dart';
import 'package:projet_flutter/MongoDBModel.dart';
import 'package:projet_flutter/db/mongo_dart.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key, required this.title});
  final String title;
  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();
  final ffelinkController = TextEditingController();
  final nameHorseController = TextEditingController();
  final ageHorseController = TextEditingController();
  final raceHorseController = TextEditingController();
  final genderHorseController = TextEditingController();
  final colorHorseController = TextEditingController();


  void dialogEditProfile(MongoDbModel data){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Edition du profile"),
        content:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TextFormField(
                  controller: nameController,
                  maxLength: 60,
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
              TextFormField(
                  controller: ageController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'Age',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
              TextFormField(
                  controller: emailController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
              TextFormField(
                  controller: phoneController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'Phone',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
              TextFormField(
                  controller: ffelinkController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'Link FFE',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
            ],

          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _updateData(data.id, data.password, data.image, nameController.text, int.parse(ageController.text), phoneController.text, emailController.text, ffelinkController.text, data.role, data.horses);
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Envoyer'),
          ),
        ],


      ),
    );
  }
  void dialogEditCheval(MongoDbModel data){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Edition du cheval"),
        content:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TextFormField(
                  controller: nameHorseController,
                  maxLength: 60,
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
              TextFormField(
                  controller: ageHorseController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'Age',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
              TextFormField(
                  controller: colorHorseController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'color',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
              TextFormField(
                  controller: raceHorseController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'race',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
              TextFormField(
                  controller: genderHorseController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'gender',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
            ],

          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Envoyer'),
          ),
        ],


      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: MongoDatabase.getQueryData(),
            builder: (context, AsyncSnapshot snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                  if(snapshot.hasData){
                    var totalData = snapshot.data.length;
                    print("Tatal Data$totalData");
                    return miseEnPage(MongoDbModel.fromJson(snapshot.data[0]));

                  } else {
                    return Center(
                      child: Text('No Data Available'),
                    );
                  }
                }
              }
        ))
      );
  }
  Widget Test(MongoDbModel data){
    return Card(
      child: Column(
        children: [
          Text("${data.username}" "${data.password}" "${data.age}" "${data.email}" "${data.phone}" "${data.ffeProfile}")
        ],
      ),
    );
  }
  Widget miseEnPage (MongoDbModel data){

      return

        ListView(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: MediaQuery
                      .of(context)
                      .size
                      .width - 80, top: 15),
                  child:
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.brown,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                          Icons.edit, size: 20),
                      onPressed: () {
                        nameController.text = data.username;
                        ageController.text = "${data.age}";
                        emailController.text = data.email;
                        phoneController.text = data.phone;
                        ffelinkController.text = data.ffeProfile;
                        dialogEditProfile(data);
                      },
                    ),
                  )
              ),
              Center(
                  child: Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      height: 150,
                      width: 150,
                      child: ClipOval(
                        child: Image.network(
                            "https://images.unsplash.com/photo-1669178082499-341906b2ab28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8dG93SlpGc2twR2d8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60"),
                      )
                  )
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(padding: EdgeInsets.all(20),
                          child: Text("Nom : " "${data.username}")),
                      Padding(padding: EdgeInsets.all(20),
                          child: Text("Age : " "${data.age}"))


                    ],
                  ),
                  Padding(padding: EdgeInsets.all(20),
                      child: Text("Email : " "${data.email}")),
                  Padding(padding: EdgeInsets.all(20),
                      child: Text("Phone : " "${data.phone}")),
                  Padding(padding: EdgeInsets.all(20),
                      child: Text("Role : " "${data.phone}")),
                  Padding(padding: EdgeInsets.all(20),
                      child: Text("FFE Link : " "${data.ffeProfile}"))


                ],
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(10),
                      child: Text("Liste des Chevaux" , style: TextStyle(fontSize: 18))),
                  Padding(
                      padding: EdgeInsets.only(left: MediaQuery
                          .of(context)
                          .size
                          .width - 235, top: 15),
                      child:
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                              Icons.edit, size: 20),
                          onPressed: () {
                            nameController.text = data.username;
                            ageController.text = "${data.age}";
                            emailController.text = data.email;
                            phoneController.text = data.phone;
                            ffelinkController.text = data.ffeProfile;
                            dialogEditProfile(data);
                          },
                        ),
                      )
                  )
                ]
              )
            ]
        );
  }
  Future<void> _updateData(var id, String password,String image,String username,int age,String phone,String email, String ffeProfile,int role,List<Horse> horses) async{
    final updateData = MongoDbModel(id: id, username: username, password: password, image: image, email: email, role: role, horses: horses, phone: phone, age: age, ffeProfile: ffeProfile);
    await MongoDatabase.update(updateData);
  }
}
