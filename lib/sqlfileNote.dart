// import 'package:apiproject/SqFiteScreen/SQLHelper.';dart
import 'package:flutter/material.dart';

import 'SQLHelper.dart';

class notesScreen extends StatefulWidget {
  const notesScreen({Key? key}) : super(key: key);

  @override
  State<notesScreen> createState() => _notesScreenState();
}

class _notesScreenState extends State<notesScreen> {

  bool isLoading=true;
  TextEditingController education=TextEditingController();
  TextEditingController Address=TextEditingController();
  TextEditingController skill=TextEditingController();
  // late String education;
  TextEditingController number=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController description =TextEditingController();

  List<Map<String, dynamic>> _notes = [];


  Future<void> _refreshNotes() async {
    final data =await SQLHelper.getNotes();
    setState(() {
      _notes=data;
      isLoading=false;
    });
  }

  void initState(){
    super.initState();
    _refreshNotes();
  }

  void showForm(int? id){
    if(id!=null){
      final existingNote=_notes.firstWhere((element) => element['id']==id);
      name.text=existingNote['name'];
      description.text=existingNote['desc'];
      number.text=existingNote['number'];
      Address.text=existingNote['Address'];
      education.text=existingNote['education'];
      skill.text=existingNote['skill'];
    }

    showDialog(context: context, builder: (_)=>Container(

      height: 300,
      width: 200,
      // padding: EdgeInsets.only(
      //   top: 15,
      //   left: 15,
      //   right: 15,
      //   // bottom: MediaQuery.of(context).viewInsets.bottom + 120,
      // ),
      child: Card(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: TextFormField(controller: name,decoration: InputDecoration(hintText: "name",enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2))),
              ),
            ),
            Container(
              child: TextFormField(controller: Address,decoration: InputDecoration(hintText: "Address",enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2))),
              ),
            ),
            Container(
              child: TextFormField(keyboardType: TextInputType.text,controller: number,decoration: InputDecoration(hintText: "number",enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2))),
              ),
            ),
            Container(
              child: TextFormField(controller: description,decoration: InputDecoration(hintText: "description",enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2))),
              ),
            ),
            Container(
              child: TextFormField(controller: skill,decoration: InputDecoration(hintText: "skill",enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2))),
              ),
            ),
            Container(
              child: TextFormField(controller: education,decoration: InputDecoration(hintText: "education",enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () async {
              if(id==null){
                await addNote();
              }
              if(id!=null){
                await updateNote(id);
              }

              name.text = '';
              description.text = '';
              skill.text = '';
              Address.text = '';
              education.text = '';
              number.text = '';


              Navigator.of(context).pop();

            }, child:Text(id==null ? "Create New" : "Update"),)

          ],
        ),
      ),
    ));

  }

  Future<void> addNote()async {
         await SQLHelper.createNote(
             name.text,
             education.text,
             skill.text,
             Address.text,
             number.text,
             description.text);
         _refreshNotes();
  }

  void deleteNote(int id) async {
    await SQLHelper.deleteNote(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted '),
    ));
    _refreshNotes();
  }
  
  Future<void> updateNote(int id )async {
    await SQLHelper.updateNote(id,name.text,
        education.text,
        skill.text,Address.text,
        number.text,
        description.text);
    _refreshNotes();
  }
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) => Card(
          color: Colors.orange[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(_notes[index]['name']),
              subtitle: Text(_notes[index]['desc']),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showForm(_notes[index]['id']);
                      }
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteNote(_notes[index]['id']);
                      }

                    ),
                  ],
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          showForm(null);
        }
      ),
    );
  }


  
  }

  
 



