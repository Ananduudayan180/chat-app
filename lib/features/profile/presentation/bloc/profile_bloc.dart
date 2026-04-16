import 'dart:typed_data';
import 'package:chat_app/features/profile/domain/entity/profile_model.dart';
import 'package:chat_app/features/profile/domain/repo/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo _profileRepo;
  ProfileBloc({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo,
      super(ProfileInitial()) {
    //fetch user profile
    on<FetchUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profileModel = await _profileRepo.fetchUserProfile(event.uid);
        if (profileModel != null) {
          emit(ProfileLoaded(profile: profileModel));
        } else {
          emit(ProfileError(errorMsg: 'User profile not found'));
        }
      } catch (e) {
        emit(ProfileError(errorMsg: e.toString()));
      }
    });

    //upload profile image
    on<UploadProfileImage>((event, emit) async {
      emit(ProfileLoading());
      try {
        final url = await _profileRepo.uploadProfileImage(
          fileName: event.fileName,
          bytes: event.bytes,
          path: event.path,
        );
        await _profileRepo.updateProfileImage(url, event.uid);
        final profileModel = await _profileRepo.fetchUserProfile(event.uid);
        if (profileModel != null) {
          emit(ProfileLoaded(profile: profileModel));
        } else {
          emit(ProfileError(errorMsg: 'User profile not found'));
        }
      } catch (e) {
        emit(ProfileError(errorMsg: e.toString()));
      }
    });

    //update user name
    on<UpdateUserName>((event, emit) async {
      emit(ProfileLoading());
      try {
        await _profileRepo.updateUserName(event.currentUserUid, event.newName);
        final profile = await _profileRepo.fetchUserProfile(
          event.currentUserUid,
        );
        if (profile != null) {
          emit(ProfileLoaded(profile: profile));
        } else {
          emit(ProfileError(errorMsg: 'User profile not found'));
        }
      } on Exception catch (e) {
        emit(ProfileError(errorMsg: e.toString()));
      }
    });

    //delete image
    on<DeleteProfileImage>((event, emit) async {
      emit(ProfileLoading());
      try {
        await _profileRepo.deleteProfileImage(event.currentUserUid);
        final profile = await _profileRepo.fetchUserProfile(
          event.currentUserUid,
        );
        if (profile != null) {
          emit(ProfileLoaded(profile: profile));
        } else {
          emit(ProfileError(errorMsg: 'User profile not found'));
        }
      } on Exception catch (e) {
        emit(ProfileError(errorMsg: e.toString()));
      }
    });
  }
}
