import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  // We make the collection static so static methods can use it
  static final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todos');

  // CREATE
  static Future<void> addTodo(String title) async {
    await todoCollection.add({
      'title': title,
      'isCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // READ (Stream for real-time updates)
  static Stream<QuerySnapshot> getTodosStream() {
    return todoCollection.orderBy('createdAt', descending: true).snapshots();
  }

  // UPDATE (Toggle completion)
  static Future<void> toggleTodo(String docId, bool isCompleted) async {
    await todoCollection.doc(docId).update({'isCompleted': isCompleted});
  }

  // UPDATE (Edit text)
  static Future<void> updateTodo(String docId, String newTitle) async {
    await todoCollection.doc(docId).update({'title': newTitle});
  }

  // DELETE single task
  static Future<void> deleteTodo(String docId) async {
    await todoCollection.doc(docId).delete();
  }

  // DELETE all completed tasks (This fixes your 5th error!)
  static Future<void> deleteCompletedTodos() async {
    final completedTasks = await todoCollection.where('isCompleted', isEqualTo: true).get();
    for (var doc in completedTasks.docs) {
      await doc.reference.delete();
    }
  }
}