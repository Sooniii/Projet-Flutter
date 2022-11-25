


import 'package:flutter/material.dart';


import 'package:projet_flutter/class/Horse.dart';
import 'package:projet_flutter/class/Riders.dart';
import 'package:projet_flutter/db/mongo_dart.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key, required this.title});

  static var tag = '/editprofile';
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
  final specialityHorseController = TextEditingController();
// Formulaire d'edition du profile utilisateur
  void dialogEditProfile(Riders data){
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
              _updateData(data.id, data.password, data.image, nameController.text, int.parse(ageController.text), phoneController.text, emailController.text, ffelinkController.text, data.role,data.isDp,data.isOwner).then((_) => setState(() {}));
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Envoyer'),
          ),
        ],


      ),
    );
  }

  // Dialog contenant la liste de tout les chevaux de la base
  void dialogListCheval(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("List des chevaux"),
        content:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
              child: FutureBuilder(
                  future: MongoDatabase.getDataHorse(),
                  builder: (context, AsyncSnapshot snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if(snapshot.hasData){
                        var totalData = snapshot.data.length;
                        print("Tatal Data$totalData");
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 420,
                              childAspectRatio: 3/2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20),
                          itemCount:  snapshot.data.length,
                          itemBuilder: (context, index) {
                            return CardHorse(Horse.fromJson(snapshot.data[index]));
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('No Data Available'),
                        );
                      }
                    }
                  }
              )),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Formulaire d'edition du profile d'un cheval (pas utilisable car incapable de récuperer les chevaux de l'utilisateur)
  void dialogEditCheval(Horse data){
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
              TextFormField(
                  controller: specialityHorseController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'speciality',
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
  // Créeation de cartes pour les chevaux
  Widget CardHorse(Horse data){
    return GestureDetector(
        onTap: () {
          /*_updateOwner(
              data.id,
              data.name,
              data.image,
              data.color,
              data.age,
              data.race,
              data.sexe,
              data.speciality,
              data.owner);*/
          Navigator.of(context).pop();
          const snackBar = SnackBar(
            content: Text('The owner of horse as been edited'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        },
        child:
        SizedBox(
            height: 100,
            width: 100,
            child:
            Card(
                elevation: 10,
                color: Colors.brown,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  <Widget> [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/cheval.jpeg'),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 30), child: Text(data.name),),
                    Container(

                      decoration: const BoxDecoration(
                        color: Colors.brown,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                            Icons.edit, size: 20),
                        onPressed: () {
                          nameHorseController.text =  data.name;
                          ageHorseController.text = "${data.age}";
                          colorHorseController.text = data.color;
                          genderHorseController.text = data.sexe;
                          raceHorseController.text = data.race;
                          specialityHorseController.text = data.speciality;
                          dialogEditCheval(data);
                        },
                      ),
                    )

                  ],
                )
            )
        )
    );
  }
//retourne le role de user sous forme textuel
  Widget GetRole (int role){
    if(role == 0){
      return Text("Role : Administrateur");
    }else{
      return Text("Role : Cavalier");
    }
  }
  // Mise en page des données utilisateur sur la page
  Widget miseEnPage (Riders data){
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
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage("https://images.unsplash.com/photo-1669178082499-341906b2ab28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8dG93SlpGc2twR2d8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60"),
                      fit: BoxFit.fill
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(padding: const EdgeInsets.all(20),
                        child: Text("Nom : " "${data.username}")),
                    Padding(padding: const EdgeInsets.all(20),
                        child: Text("Age : " "${data.age}"))
                  ],
                ),
                Padding(padding: const EdgeInsets.all(20),
                    child: Text("Email : " "${data.email}")),
                Padding(padding: const EdgeInsets.all(20),
                    child: Text("Phone : " "${data.phone}")),
                Padding(padding: const EdgeInsets.all(20),
                    child: GetRole(data.role)),
                Padding(padding: const EdgeInsets.all(20),
                    child: Text("FFE Link : " "${data.ffeProfile}"))
              ],
            ),
            Row(
                children: [
                  const Padding(padding: EdgeInsets.all(10),
                      child: Text("Liste des Chevaux" , style: TextStyle(fontSize: 20))),
                  Padding(
                      padding: EdgeInsets.only(left: MediaQuery
                          .of(context)
                          .size
                          .width - 255, top: 8),
                      child:
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.brown,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                              Icons.add, size: 20),
                          onPressed: () {
                            dialogListCheval();
                          },
                        ),
                      )
                  )
                ]
            )
          ]
      );
  }
  //Sert a update le profile utilisateur
  Future<void> _updateData(var id, String password,String image,String username,int age,String phone,String email, String ffeProfile,int role,List<String> isDp, List<String> isOwner) async{
    final updateData = Riders(id: id, username: username, password: password, image: image, email: email, role: role, phone: phone, age: age, ffeProfile: ffeProfile, isDp : isDp, isOwner : isOwner);
    await MongoDatabase.update(updateData);
  }

  // Sert a update le proprietaire d'un cheval (marche pas)
  Future<void> _updateOwner(var id, String name,String image,String color,int age,String race,String sexe,String speciality, var owner) async{
    final updateData = Horse(id: id, image: image, name: name, age: age, color: color, race: race, sexe: sexe, owner: owner, speciality: speciality);
    await MongoDatabase.updateHorse(updateData);
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if(snapshot.hasData){
                      var totalData = snapshot.data.length;
                      print("Tatal Data$totalData");
                      return miseEnPage(Riders.fromJson(snapshot.data[0]));

                    } else {
                      return const Center(
                        child: Text('No Data Available'),
                      );
                    }
                  }
                }
            ))
    );
  }

}
