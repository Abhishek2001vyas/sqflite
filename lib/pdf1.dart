import 'package:flutter/material.dart';
import 'package:sq/pdf2.dart';

import 'da.dart';
import 'mo.dart';

class QW extends StatefulWidget {
  const QW({super.key});

  @override
  State<QW> createState() => _QWState();
}

class _QWState extends State<QW> {
 late List<Notes> notes;
  bool isLoading = false;
 @override
 void initState() {
   super.initState();

   refreshNotes();
 }
 Future refreshNotes() async {
   setState(() => isLoading = true);

   this.notes = await Re.instance.readAllNotes();

   setState(() => isLoading = false);
 }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("list"),
       centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: isLoading
                ? CircularProgressIndicator()
                : notes.isEmpty
                ? Text(
              'No Notes',
              style: TextStyle(color: Colors.white, fontSize: 24),
            )
                : buildNotes(),
          ),
          GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Add(),)),
            child: Container(child: ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: notes.length,itemBuilder: (context, index) {
              return Column(children: [
                Container(child: Column(children: [ Text(NotesFields.name),
                  Text(NotesFields.description.toString())]),)

              ],);


            },),),
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: 40),
          backgroundColor: Colors.blue,
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Add()),
            );


            refreshNotes();
          },),


    );
  }

  buildNotes() {}
}
