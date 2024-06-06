import 'package:firebase_note_provider/firebase/fb_notifications.dart';
import 'package:firebase_note_provider/utils/context_extention.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../firebase/fb_auth_controller.dart';
import '../../models/process_response.dart';
import '../../providers/note_provider.dart';
import 'note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with FbNotifications {
  @override
  void initState() {
    // TODO: implement initState


    super.initState();
    Provider.of<NoteProvider>(context, listen: false).read();
    requestNotificationsPermissions();
    mangeNotification();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Notes '), actions: [
        IconButton(
            onPressed: () async {
              await FbAuthController().signOut();
              Navigator.pushReplacementNamed(context, '/login_screen');
            },
            icon: Icon(Icons.logout)),
        IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => NoteScreen()));
        }, icon: Icon(Icons.add)),

      ]),
      body: Consumer<NoteProvider>(
        builder:
            (BuildContext context, NoteProvider controller, Widget? child) {
          if (controller.loading) {
            return  Center(child: CircularProgressIndicator());
          } else if (controller.notes.isNotEmpty) {
            return ListView.builder(
                itemCount: controller.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteScreen(note: controller.notes[index],)));
                    },
                    leading: Icon(Icons.note),
                    title: Text(controller.notes[index].title),
                    subtitle: Text(controller.notes[index].info),
                    trailing:IconButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => NoteScreen(note: controller.notes[index],)));
                      },
                      icon: IconButton(
                        onPressed:()=> _delete(controller.notes[index].id),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Text('Note Notes');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.image),
        onPressed: (){
          Navigator.pushNamed(context, '/images_screen');
        },
      ),
    );
  }


  _delete(String id)async{
    ProcessResponse processResponse=await Provider.of<NoteProvider>(context,listen: false).delete(id);
    if(processResponse.success){
    }
    context.showSnackBar(message: processResponse.message,error:! processResponse.success);

  }

}
