import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() {
  runApp(MaterialApp(
    title: 'ListView',
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>MyListView();
}

class MyListView extends State<MyApp>{  
  
  var count;
  List list = [
    {
      "name": {"first": "Dharmesh","last": "Gondaliya"},
      "location": {"city": "Junagadh","country": "India",},
      "email": "gondaliyadharmesh.gd@gmail.com",
      "login": {"username": "dharmeshgondaliya",},
      "phone": "9429243558",
      "picture": {"large": "",},
    }
  ];

  @override
  void initState() {
    super.initState();
    this.getuser();
  }

  Future getuser() async {
    count = Random().nextInt(50);
    var url = "https://randomuser.me/api/?results=${count}";
    var response = await http.get(url);
    var result = json.decode(response.body)['results'];
    setState(() {
      list = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("3D ListView")
      ),
      floatingActionButton: FloatingActionButton(onPressed: getuser,child: Icon(Icons.refresh,color: Colors.white,),),
      body: RefreshIndicator(
        onRefresh: getuser,
        child:  Center(
          child:ListWheelScrollView(
            children: list.map((e) => Padding(padding: EdgeInsets.all(10),
            child: Card(
              color: Colors.blue[100],
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Padding(padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Container(width: 150,height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          border: Border.all(color: Colors.white,width: 2),
                          image: DecorationImage(image: NetworkImage(e['picture']['large']),fit: BoxFit.cover)
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20,),
                      child: Text(e['login']['username'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    ),
                    Padding(padding: EdgeInsets.only(top: 25,left: 10,right: 10,bottom: 10),
                      child: Column(
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                            child: ListTile(
                              leading: Icon(Icons.person_pin,size: 35,color: Colors.lightGreen,),
                              title: Text(e['name']['first']+" "+e['name']['last'],style: TextStyle(fontSize: 18),),
                            ),
                          ),

                          SizedBox(height: 5,),

                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                            child: ListTile(
                              leading: Icon(Icons.phone,size: 35,color: Colors.lightGreen,),
                              title: Text(e['phone'],style: TextStyle(fontSize: 18),),
                            ),
                          ),

                          SizedBox(height: 5,),

                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                            child: ListTile(
                              leading: Icon(Icons.email,size: 35,color: Colors.lightGreen,),
                              title: Text(e['email'],style: TextStyle(fontSize: 18),),
                            ),
                          ),

                          SizedBox(height: 5,),

                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                            child: ListTile(
                              leading: Icon(Icons.home,size: 35,color: Colors.lightGreen,),
                              title: Text(e['location']['city'],style: TextStyle(fontSize: 18),),
                            ),
                          ),

                          SizedBox(height: 5,),

                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                            child: ListTile(
                              leading: Icon(Icons.my_location,size: 35,color: Colors.lightGreen,),
                              title: Text(e['location']['country'],style: TextStyle(fontSize: 18),),
                            ),
                          )

                        ],
                      )
                    )
                  ],
                ),
              ),
            ),
          )
          )).toList(),
          itemExtent: MediaQuery.of(context).size.height * 0.85,
        ),
      ),
    ));    
  }

}