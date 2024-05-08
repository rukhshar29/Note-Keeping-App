import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class FirestoreServices{
  CollectionReference?reference=FirebaseFirestore.instance.collection('notes_collection');
  //adding new notes function
  Future<void>addingNotes(String note){
    return reference!.add({'note':note,'timestamp':DateTime.now()});

  }
  Stream<QuerySnapshot>showData(){
    return reference!.orderBy('timestamp',descending:true).snapshots();
  }
  //updating notes
  Future<void>updatingNote(String updatingNote,String docId){
    return reference!.doc(docId).update({'note':updatingNote,'timestamp':DateTime.now()});
  }
  //deleting
  Future<void>deletingNote(String docId){
    return reference!.doc(docId).delete();
  }
}