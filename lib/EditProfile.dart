
import 'package:flutter/material.dart';
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
  List<String> list = ["a","b","v","g"," f","f","c","c","c","c","c"];
  int? edit = 0;
  void dialog(){
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
                      labelText: 'FirstName',
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
                      labelText: 'Email',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
              TextFormField(
                  controller: ffelinkController,
                  maxLength: 25,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Entrer du texte',
                      border: OutlineInputBorder())
              ),
            ],

          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {Navigator.pop(context, 'Cancel');
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width-100, top: 15),
            child:
            Container(
            decoration: const BoxDecoration(
              color: Colors.brown,
              shape: BoxShape.circle,
            ),
            child:IconButton (
              icon: const Icon(
                  Icons.edit, size: 20),
                onPressed: () {
                   dialog();
                },
              ),
            )
          ),
            Center(
                child:Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    height: 150,
                    width: 150,
                    child: ClipOval(
                      child: Image.network("https://images.unsplash.com/photo-1669178082499-341906b2ab28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8dG93SlpGc2twR2d8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60"),
                    )
                )
            ),
          Column(
            children:  [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Padding(padding: EdgeInsets.all(20),child: Text("Nom : Louis")),
                  Padding(padding: EdgeInsets.all(20),child:  Text("Age : 30"))


                ],
              ),
                  const Padding(padding: EdgeInsets.all(20),child: Text("Email : Louis@mail.com")),
                  const Padding(padding: EdgeInsets.all(20),child: Text("Phone : 6666666666")),
                  const Padding(padding: EdgeInsets.all(20),child: Text("Role : Cavalier")),
                  const Padding(padding: EdgeInsets.all(20),child: Text("FFE Link : https://ffe.com"))



            ],
          ),
          const Padding(padding: EdgeInsets.all(20),child: Text("Liste des Chevaux")),

        ]
      )

    );
  }
}
