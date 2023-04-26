import 'package:flutter/material.dart';
import 'package:test_user_pagination/blocHelper/PaginationBloc.dart';
import 'package:test_user_pagination/model/ApiModel.dart';

class HomeScreen extends StatefulWidget {

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<HomeScreen> {

  BlocPagination _blocPagination;
  ScrollController _controller;

  @override
  void initState() {

    _blocPagination = new BlocPagination(
      actionScroll: alert,
    );

    _controller = new ScrollController();
    _controller.addListener(listener);

    super.initState();

  }

  void listener() {

    if (_controller.position.pixels >= _controller.position.maxScrollExtent - 3) {
      _blocPagination.event.add(null);
    }

  }


  @override
  void dispose() {
    _controller.removeListener(listener);
    _controller.dispose();
    _blocPagination.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("User List"),
        ),
      ),

      body: StreamBuilder(
        initialData: <Data>[],
        stream: _blocPagination.pagecheck,
        builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {

          return ListView.builder(
            controller: _controller,
            itemCount: snapshot?.data?.length ?? 0,
            itemBuilder: (context, i) {
              final data = snapshot.data[i];

              return Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                child:Card(
                margin: EdgeInsets.only(top:20,bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 10,
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(25),
                            child: Image.network(data.avatar),
                          ),
                        Column(
                        mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            alignment: Alignment.centerLeft,
                            child:Text("Id : "+"${data.id}",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            alignment: Alignment.centerLeft,
                            child:Text("First Name : "+"${data.firstName}",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            alignment: Alignment.centerLeft,
                            child:Text("Last Name : "+"${data.lastName}",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            alignment: Alignment.centerLeft,
                            child:Text("Email : "+"${data.email}",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                          ),
                        ],
                      )
                    ],
                  )
                )
              );
            },
          );
        },
      ),
    );
  }

  
  void alert() {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              title: Text("Hi User"),
              content: Text("Here is your Next Page"),
            );
        }
    );
  }
}