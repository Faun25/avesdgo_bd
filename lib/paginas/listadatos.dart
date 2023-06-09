
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaDatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.black,
          title: Text('Aves Durango'),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Avesdgo').snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic>  data = document.data()! as Map<String, dynamic>;  //nuevo paquete
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: new Column(
                      children: [
                        Image.network(data['foto']),
                        ListTile(
                          title: Text("Nombre común: "+data['nombrecom']),
                          //leading: Icon(Icons.favorite,color: Colors.red,),
                          subtitle: Text("Nombre científico: "+data['nombrecie']+"\n"+
                              "Fotografiada por: "+data['nombrecrd'],style: TextStyle(fontSize: 15),),
                        )
                      ],
                    ),
                  );
                  /*return ListTile(
                    title: Text("Nombre común: "+data['nombrecom']),
                    subtitle: Text("Nombre científico: "+data['nombrecie']+"\n"+
                        "Fotografiada por: "+data['nombrecrd']),
                    leading: Image(
                      image: NetworkImage(data['foto']),
                      fit: BoxFit.fitHeight,
                      width: 50,
                    ),
                  );*/
                }).toList(),
              );
            }
        )
    );
  }
}