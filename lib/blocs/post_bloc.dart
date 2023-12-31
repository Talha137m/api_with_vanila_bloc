import 'dart:async';

import 'package:fake_store_api_with_bloc/api_provider/post_api_service.dart';
import 'package:fake_store_api_with_bloc/events/post_events.dart';
import 'package:fake_store_api_with_bloc/states/post_states.dart';

class PostBloc {
  final StreamController<PostState> _postStateStreamController = StreamController();
  final StreamController<PostEvenet> _postEventsStreamController=StreamController();


  StreamSink<PostEvenet> get getEventSink =>_postEventsStreamController.sink;
  Stream<PostState> get getPostStream => _postStateStreamController.stream;

  PostBloc() {
    _postStateStreamController.add(PostInitialState());
    _postEventsStreamController.stream.listen(checkEvents);
  }

  void checkEvents(PostEvenet evenet) async {
    ApiProvider apiProvider = ApiProvider();
    if (evenet is InitialPostEvent) {
      _postStateStreamController.add(PostLoadingState());
      try {
        var list = await apiProvider.fetch();
        //print(list);
        _postStateStreamController.add(PostLoadedState(list: list));
      } catch (e) {
        print(e.toString());
        var message = e.toString();
        _postStateStreamController
            .add(PostErrorState(errorMesg: message.toString()));
      }
    }
  }

  void cancelStream() {
    _postStateStreamController.close();
    _postEventsStreamController.close();
  }
}
