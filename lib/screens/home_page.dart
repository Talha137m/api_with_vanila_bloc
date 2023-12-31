import 'package:fake_store_api_with_bloc/blocs/post_bloc.dart';
import 'package:fake_store_api_with_bloc/events/post_events.dart';
import 'package:fake_store_api_with_bloc/model_classes/post_model_class.dart';
import 'package:fake_store_api_with_bloc/states/post_states.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostBloc bloc = PostBloc();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var bloc = context.read<PostBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vanila bloc with api'),
      ),
      body: Center(
        child: StreamBuilder<PostState>(
          stream: bloc.getPostStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Text('null');
            } else {
              switch (snapshot.data.runtimeType) {
                case PostInitialState:
                  return const Text(
                      'click floating action button to load data');
                case PostLoadingState:
                  return const CircularProgressIndicator();
                case PostLoadedState:
                  return LoadedPage(
                      list: (snapshot.data as PostLoadedState).list);
                default:
                  return Text((snapshot.data as PostErrorState).errorMesg);
              }
            }
            // if (snapshot.data is PostInitialState) {
            //   return const Text('click floating action button to load data');
            // } else if (snapshot.data is PostLoadingState) {
            //   return const CircularProgressIndicator();
            // } else if (snapshot.data is PostLoadedState) {
            //   return LoadedPage(list: (snapshot.data as PostLoadedState).list);
            // }
            // return Text((snapshot.data as PostErrorState).errorMesg);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.getEventSink.add(InitialPostEvent());
        },
        child: const Icon(Icons.fiber_smart_record_sharp),
      ),
    );
  }
}

class LoadedPage extends StatelessWidget {
  final List<PostApiClass> list;
  const LoadedPage({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(list[index].id.toString()),
          title: Text(list[index].title),
          trailing: Text(list[index].userId.toString()),
        );
      },
    ));
  }
}
