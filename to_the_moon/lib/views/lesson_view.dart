import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/views/individual_lesson_view.dart';




class LessonView extends StatelessWidget {
  const LessonView({super.key});

  @override
  Widget build(BuildContext context) {
    LessonViewModel lessonViewModel = context.watch<LessonViewModel>();
    var list = context.watch<LessonViewModel>().Lessons;
    // LessonViewModel L = new LessonViewModel();
     // List<LessonModel> Lessons = L.getLessonsList();
    return Scaffold(
     body: Column(
          children : [
          //progress card
          Center(
          child: Card(
            color:Colors.white,
            elevation: 1, 
            shape: RoundedRectangleBorder( side: BorderSide(color: Theme.of(context).colorScheme.outline,),borderRadius: const BorderRadius.all(Radius.circular(12)),),
            child: const SizedBox(
              width: 400,
              height: 200,
              child: Center(child: Text('0/6 lessons complete')),
            ),
          ),
        ),
        Expanded(child:FutureBuilder(
            future: list,
            builder: (context,data){
              if(data.hasError){
                return Text("${data.error}");
              }else if(data.hasData){
                var Lessons = data.data as List<LessonModel>;
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 1, 
                        shape: RoundedRectangleBorder(side: BorderSide(width: .25),borderRadius: BorderRadius.circular(20) ),
                        child: ListTile(  
                          //change this maybe
                          //leading: CircleAvatar(child: Text((index+1).toString()), backgroundColor: Colors.grey,),
                          title:Text(Lessons[index].getTitle().toString()),
                          subtitle:Text(Lessons[index].getDescription().toString()),
                          //change this as well
                          trailing: getTrailing(Lessons[index]),
                          onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IndividualLessonView(lesson: Lessons[index]),
                              ),
                            );
                          },
                        ) 
                      ); 
                    },
                ); 

              }else{
                return Center(child:CircularProgressIndicator());
              }
            }
          )
      ),] )
    );
  }

  Icon getTrailing(LessonModel lesson){
    if(lesson.getComplete().toString() == 'true'){
          return Icon(CupertinoIcons.star_fill);
      }else{
        return Icon(CupertinoIcons.star);
      }
  }

  


}