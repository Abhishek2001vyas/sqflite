import 'package:flutter/material.dart';
import 'package:sq/model/note.dart';
import 'package:sq/pdf1.dart';
import '../mo.dart';
import 'da.dart';
import 'db/home.dart';



class Add extends StatefulWidget {
   final Notes? note;
   final String ? name;
   final String? description;
  const Add({ Key ?key,this.note,
    // this.number = "",
    this.name = '',
    this.description = '',
    // required this.description,
    // required this.onChangedTitle,
    // required this.onChangedDescription,
  }):super(key: key);




   //
  // const AddEditNotePage({
  //   Key? key,
  //   this.note,
  // }) : super(key: key);
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController education=TextEditingController();
  TextEditingController Address=TextEditingController();
  TextEditingController skill=TextEditingController();
  // late String education;
  TextEditingController number=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController description =TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //
  //   number = widget.note?.number ?? '';
  //   name = widget.note?.name ?? '';
  //   description = widget.note?.description ?? '';
  //   skill = widget.note?.skill ?? '';
  //   education = widget.note?.education ?? '';
  //   Address = widget.note?.Address ?? '';
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("api"),centerTitle: true),
      body: Form(
        key: _formKey,
        child: Column(children: [

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

          Center(child: ElevatedButton(onPressed: () async{
            var a= name.text.toString();
            await addOrUpdateNote();
            Navigator.push(context, MaterialPageRoute(builder: (context) => QW(),));
            }, child: Text("Add")))

        ],)

        // NoteFormWidget(
        //   isImportant: isImportant,
        //   number: number,
        //   title: title,
        //   description: description,
        //   onChangedImportant: (isImportant) =>
        //       setState(() => this.isImportant = isImportant),
        //   onChangedNumber: (number) => setState(() => this.number = number),
        //   onChangedTitle: (title) => setState(() => this.title = title),
        //   onChangedDescription: (description) =>
        //       setState(() => this.description = description),
        // ),
      ),


    );
  }
  Future addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        // await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }
  //
  // Future updateNote() async {
  //   final note = widget.note!.copy(
  //
  //     number:  number.text.toString(),
  //     name: name.text.toString(),
  //     skill: skill.text.toString(),
  //     Address: Address.text.toString(),
  //     education: education.text.toString(),
  //     description: description.text.toString(),
  //   );
  //
  //   await Re.instance.update(note);
  // }


  Future addNote() async {
    final note = Notes(
      name: name.text.toString(),
      number: number.text.toString(),
      description: description.text.toString(),
     skill: skill.text.toString(),
      education: education.text.toString(),
      Address: Address.text.toString()
    );

    await Re.instance.create(note);

    print({name,skill,Address,education,description,number});
  }


}
