
import 'package:bokaramstore/getdataromweb/allNetworking.dart';
import 'package:bokaramstore/jsondata/get_about_json.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  AllNetworking _allNetworking = AllNetworking();
List<aboutdatatype>list=[];
List<Widget>widgetlist=[];
  String lang;
  final box = GetStorage();
  @override
  void initState() {
    lang = box.read('lang');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('معلومات عننا'),
        ),
        body: StreamBuilder<Get_about_json>(
            stream: _allNetworking.get_about(lang: lang).asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for(int i=0;i<snapshot.data.result.allInfo.length;i++){
                  print(snapshot.data.result.allInfo[i].title);
                list.add(aboutdatatype(snapshot.data.result.allInfo[i].title, snapshot.data.result.allInfo[i].content));

                }
                for(int i=0;i<list.length;i++){

                  widgetlist.add(Text(list[i].title,style: TextStyle(color: Colors.red,fontSize: 22,fontWeight: FontWeight.bold),));
                  widgetlist.add(Text(list[i].content,style: TextStyle(color: Colors.blue,fontSize: 16                                                                                               )));
                }
                return SingleChildScrollView(


                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: widgetlist),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      ),
    );
  }
}
class aboutdatatype {
  String title;
  String content;

  aboutdatatype(this.title, this.content);
}