import 'package:flutter/material.dart';
import 'package:flutter_app/post_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostPage extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final asyncPost = ref.watch(postProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Async Exemple'),
      ),
      body: Center(
        child: asyncPost.when(
            data: (posts){
              return ListView.builder(
                itemBuilder: (context, index){
                  final post = posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                }
              );
            }
            ,loading: ()=> Center(child: CircularProgressIndicator(),)
            , error: (error, stack)=> Center(
          child: Text('Error: $error'),
        ))
      ),
    );
  }

}