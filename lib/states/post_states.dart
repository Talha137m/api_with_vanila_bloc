// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../model_classes/post_model_class.dart';

@immutable
abstract class PostState {}

@immutable
class PostInitialState extends PostState {}

@immutable
class PostLoadingState extends PostState {}

@immutable
class PostLoadedState extends PostState {
  final List<PostApiClass> list;
  PostLoadedState({
    required this.list,
  });
}

@immutable
class PostErrorState extends PostState {
  final String errorMesg;
  PostErrorState({
    required this.errorMesg,
  });
}
