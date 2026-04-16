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
          emit(ProfileError(errorMsg: 'Upload profile image failed'));
        }
      } catch (e) {
        emit(ProfileError(errorMsg: e.toString()));
      }
    });

    //update user name
    on<UpdateUserName>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await _profileRepo.updateUserName(
          event.currentUserUid,
          event.newName,
        );
        if (profile != null) {
          emit(ProfileLoaded(profile: profile));
        } else {
          emit(ProfileError(errorMsg: 'Failed to update user name'));
        }
      } on Exception catch (e) {
        emit(ProfileError(errorMsg: e.toString()));
      }
    });
  }
}
