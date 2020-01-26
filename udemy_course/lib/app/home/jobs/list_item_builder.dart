import 'package:flutter/material.dart';
import 'package:udemy_course/app/home/jobs/empty_content.dart';

typedef ItemWidgetBuilder<T>=Widget Function(BuildContext context,T item);
class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({Key key, this.snapshot, this.itemBuilder}) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;


  @override
  Widget build(BuildContext context) {
    if(snapshot.hasData){
      final List<T> items=snapshot.data;
      if(items.isNotEmpty){
        //TODO : return ListView
      }else{
        return EmptyContent();
      }
    }else if(snapshot.hasError){
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
