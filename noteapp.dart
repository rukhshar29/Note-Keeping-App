//import 'dart:html';
//import 'dart:ui';

//import 'package:basic_crud_app/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePagee extends StatefulWidget {
  const HomePagee({super.key});

  @override
  State<HomePagee> createState() => _HomePageeState();
}

class _HomePageeState extends State<HomePagee> {
  TextEditingController Controller=TextEditingController();
  FirestoreServices services=FirestoreServices();
  void showSnackbar(String?oldNote,String?docId){
    if (oldNote==null){
      Controller.text='';
    }else{
      Controller.text=oldNote;
    }
    showDialog(context: context,
    builder: (context) {
      return AlertDialog( 
        title: Text('Add your notes here',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 2, 68, 122),fontStyle: FontStyle.italic),),
        actions: [ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 3, 40, 69),
        
        ),
          onPressed:() {
          if(oldNote==null){
             services.addingNotes(Controller.text);

          }else{
            services.updatingNote(Controller.text, docId!);
          }
          Controller.clear();
          Navigator.pop(context);
         
          
        }, child: Text('save',style: TextStyle(fontSize:20,
        fontWeight:FontWeight.bold,fontStyle:FontStyle.italic,color:  Colors.red ),)),
          
        ],
        content: TextField(
          controller: Controller,

        ),
      );
    },);
  }
  // TextEditingController controller = TextEditingController();
  // FirestoreServices firestoreServices = FirestoreServices();
  // void showNoteBox(String? textToedit, String? docId, Timestamp? time) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       if (textToedit != null) {
  //         controller.text = textToedit;
  //       }
  //       return AlertDialog(
  //         title: Text(
  //           "Add note",
  //           style: GoogleFonts.alexandria(fontSize: 16),
  //         ),
  //         content: TextField(
  //           decoration: InputDecoration(hintText: 'Note here...'),
  //           style: GoogleFonts.alexandria(),
  //           controller: controller,
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               if (docId == null) {
  //                 firestoreServices.addNote(controller.text);
  //               } else {
  //                 firestoreServices.updateNotes(docId, controller.text, time!);
  //               }
  //               controller.clear();
  //               Navigator.pop(context);
  //             },
  //             child: Text(
  //               'add',
  //               style: GoogleFonts.alexandria(),
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton.extended(backgroundColor: Color.fromARGB(255, 57, 3, 67),
      label: Text('Add',style: TextStyle(fontSize:18,fontWeight: FontWeight.bold,color: Colors.white ),),
      icon:  Icon(Icons.add,color: Colors.white,),
        onPressed:()async {
        showSnackbar(null,null,);
        
      }, 
      ),
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        
        backgroundColor: Color.fromARGB(255, 132, 184, 232),
        title: Text(
          "Notes",
          style: GoogleFonts.alexandria(textStyle:TextStyle(fontWeight: FontWeight.w600,fontSize: 30,color: Color.fromARGB(255, 26, 0, 0)),
          ),
          
        ),
      ),
      body: StreamBuilder(stream: services.showData(), 
      builder:(context, snapshot) {
        if(snapshot.hasData){
          List notelist=snapshot.data!.docs;

          return ListView.builder(itemCount: notelist.length,
            itemBuilder:(context, index) {
              DocumentSnapshot document=notelist[index];
              Map<String,dynamic>data=document.data()as Map<String,dynamic>;
              String note=data['note'];
              String docId=document.id;
              Timestamp time=data['timestamp'];


              return Column(
                children: [
                  Padding(padding:EdgeInsets.symmetric(horizontal: 14),
                  child: ListTile(
                     
                    contentPadding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    tileColor: Color.fromARGB(255, 206, 239, 99),
                    title: Padding(padding:EdgeInsets.all(8.0),
                    child: Text(note,
                    style: GoogleFonts.aDLaMDisplay(textStyle:TextStyle(color: Colors.black,fontSize:19 
                      
                    )), ),
                    ),

              

            
              trailing: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    IconButton(color: Color.fromARGB(255, 125, 30, 23),
                      onPressed:() {
                      services.deletingNote(docId);
                      
                    }, icon: Icon(Icons.delete)),
                     IconButton(color: const Color.fromARGB(255, 2, 54, 3),
                      onPressed:() {
                       
                      showSnackbar(note, docId);
                      
                      
                    }, icon: Icon(Icons.edit))
                  ],),
                ],
              ),
              
            ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 14,vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(time.toDate().hour.toString(),style: TextStyle(color: Color.fromARGB(255, 43, 1, 51),fontWeight: FontWeight.bold),
                      ),
                      Text(":"),
                      Text(time.toDate().minute.toString(),
                      style: TextStyle(color: const Color.fromARGB(255, 43, 1, 51),fontWeight: FontWeight.bold),),
                      
                    ],
                  ),
                  )
                ],
              );
          },);
        }else{
          return
          Center(child: Text('there is noting to show'),);
        }
      },),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.purple[100],
      //   label: Text(
      //     'add',
      //     style: GoogleFonts.alexandria(fontSize: 18),
      //   ),
      //   icon: Icon(Icons.add),
      //   onPressed: () async {
      //     showNoteBox(null, null, null);
      //   },
      // ),
      // body: StreamBuilder(
      //   stream: FirestoreServices().showNotes(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       List noteList = snapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: noteList.length,
      //         itemBuilder: (context, index) {
      //           DocumentSnapshot document = noteList[index];
      //           String docId = document.id;
      //           Map<String, dynamic> data =
      //               document.data() as Map<String, dynamic>;
      //           String note = data['note'];
      //           Timestamp time = data['timestamp'];
      //           return Column(
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 14),
      //                 child: ListTile(
      //                   contentPadding: EdgeInsets.all(16),
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(16)),
      //                   tileColor: Colors.purple[100],
      //                   title: Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Text(
      //                       note,
      //                       style: GoogleFonts.alexandria(
      //                           textStyle: TextStyle(
      //                               color: Colors.purple[800], fontSize: 19)),
      //                     ),
      //                   ),
      //                   trailing: Column(
      //                     children: [
      //                       Row(
      //                         mainAxisSize: MainAxisSize.min,
      //                         children: [
      //                           IconButton(
      //                             color: Colors.purple[400],
      //                             icon: Icon(Icons.edit),
      //                             onPressed: () {
      //                               showNoteBox(note, docId, time);
      //                             },
      //                           ),
      //                           IconButton(
      //                               color: Colors.purple[400],
      //                               onPressed: () {
      //                                 firestoreServices.deleteNote(docId);
      //                               },
      //                               icon: Icon(Icons.delete))
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(
      //                     horizontal: 14, vertical: 4),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   children: [
      //                     Text(
      //                       time.toDate().hour.toString(),
      //                       style: const TextStyle(
      //                           color: Colors.purple,
      //                           fontWeight: FontWeight.bold),
      //                     ),
      //                     Text(":"),
      //                     Text(
      //                       time.toDate().minute.toString(),
      //                       style: const TextStyle(
      //                           color: Colors.purple,
      //                           fontWeight: FontWeight.bold),
      //                     ),
      //                   ],
      //                 ),
      //               )
      //             ],
      //           );
      //         },
      //       );
      //     } else {
      //       return Center(
      //         child: Text("Nohing to show...add notes"),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
class EditScreenn extends StatefulWidget {
  const EditScreenn({super.key});

  @override
  State<EditScreenn> createState() => _EditScreennState();
}

class _EditScreennState extends State<EditScreenn> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}