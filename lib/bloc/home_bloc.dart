import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_project/repositories/network_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NetworkRepository _networkRepository;
  HomeBloc(this._networkRepository) : super(HomeLoading()) {
    on<HomeInitialEvent>((event, emit) {
      emit(HomeLoading());
    });
    on<HomeLoadingEvent>(loadAllPhotos);
    on<HomeUploadPhotoEvent>(uploadPhoto);
    on<HomeDeletePhotoEvent>(deletePhoto);
  }

  Future<FutureOr<void>> uploadPhoto(
      HomeUploadPhotoEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    //open image picker for camera
    //upload image to firebase storage
    try {
      var imagePath = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagePath != null) {
        File image = File(imagePath.path);
        //upload image to firebase storage
        //get url from firebase storage

        //add url to firebase firestore
        await _networkRepository.uploadPhotoToFirebaseStorage(image);
        var result = await _networkRepository.getAllPhotosFromFirebaseStorage();

        emit(HomeLoaded(result));
      }
    } on FirebaseException catch (e) {
      emit(HomeError(message: e.message ?? ''));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> loadAllPhotos(
      HomeLoadingEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
      //get all photos from firebase storage
      //get all urls from firebase firestore
      //add urls to state
      var result = await _networkRepository.getAllPhotosFromFirebaseStorage();
      emit(HomeLoaded(result));
    } on FirebaseException catch (e) {
      emit(HomeError(message: e.message ?? ''));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<FutureOr<void>> deletePhoto(
      HomeDeletePhotoEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      //delete photo from firebase storage
      //delete url from firebase firestore
      await _networkRepository.deletePhotoFromFirebaseStorage(event.url);
      var result = await _networkRepository.getAllPhotosFromFirebaseStorage();
      emit(HomeLoaded(result));
    } on FirebaseException catch (e) {
      emit(HomeError(message: e.message ?? ''));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
