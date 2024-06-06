import 'package:firebase_note_provider/models/process_response.dart';
import 'package:firebase_note_provider/providers/images_provider.dart';
import 'package:firebase_note_provider/utils/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ImagesProvider>(context, listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/upload_image_screen'),
              icon: Icon(Icons.camera))
        ],
      ),
      body: Consumer<ImagesProvider>(
        builder: (context, controller, child) {
          return GridView.builder(
              itemCount: controller.reference.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(

                  child: Card(
                    child: Stack(
                      children: [
                        FutureBuilder<String>(
                          future: controller.reference[index].getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Image.network(snapshot.data!);
                            } else {
                              return Icon(Icons.image_aspect_ratio_outlined);
                            }
                          },
                        ),
                        Align(
                        alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 50,
                            color: Colors.black26,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                  controller.reference[index].name,
                                  style: TextStyle(color: Colors.white),
                                )),
                                IconButton(
                                  onPressed: ()=> _deleted(index),
                                  icon:
                                  Icon(Icons.delete),
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },

      ),

    );
  }
 Future<void> _deleted( int index)async{
    ProcessResponse processResponse =await Provider.of<ImagesProvider>(context,listen: false).delete(index);
    context.showSnackBar(message: processResponse.message,error: !processResponse.success);
  }
}
