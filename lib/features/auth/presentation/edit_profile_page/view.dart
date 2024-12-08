import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:litlearn/core/entity/user_entity.dart';
import 'package:litlearn/core/global%20states/user%20state/bloc/user_bloc.dart';
import 'package:litlearn/core/theme/palette.dart';
import 'package:litlearn/core/utils/show_toast.dart';
import 'package:litlearn/core/widgets/common.dart';
import 'package:litlearn/features/auth/presentation/edit_profile_page/cubit/edit_profile_cubit.dart';
import 'package:litlearn/features/auth/presentation/edit_profile_page/widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserEntity storedUserData;

  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();

  final gender = ValueNotifier(1);
  final dob = ValueNotifier('');

  @override
  void initState() {
    storedUserData =
        (context.read<UserBloc>().state as UserStateUserEntity).userEntity;

    nameController.text = storedUserData.fullName;
    phoneNoController.text = storedUserData.phoneNo;
    gender.value =
        storedUserData.gender.isEmpty ? 1 : int.parse(storedUserData.gender);
    dob.value = storedUserData.dob.isEmpty ? '' : storedUserData.dob;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileStateDataUpdated) {
          context.read<UserBloc>().add(UserEventUserUpdate(state.user));

          showToastMessage(
              context: context, message: 'Data updated successfully');

          Navigator.pop(context);
        }
        if (state is EditProfileStateFailure) {
          showToastMessage(context: context, message: 'Something went wrong');
        }
      },
      child: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          return PopScope(
            canPop: state is! EditProfileStateLoading,
            child: Scaffold(
              backgroundColor: ColorConstants.blue,
              body: SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          kHeight(20.h),
                          SafeArea(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      padding: EdgeInsets.all(10.r),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.white,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 25.r,
                                        color: ColorConstants.blue,
                                      ),
                                    ),
                                  ),
                                  kWidth(20.w),
                                  kText(
                                    text: 'Personal Information',
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.white,
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          kHeight(20.h),
                          Container(
                            height: 100.r,
                            width: 100.r,
                            decoration: BoxDecoration(
                              color: ColorConstants.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 0),
                                  blurRadius: 9,
                                  spreadRadius: 0,
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_rounded,
                              color: ColorConstants.blue,
                              size: 70.r,
                            ),
                          ),
                          kHeight(10.h),
                          kText(
                            text: 'Edit Profile',
                            fontSize: 15,
                          ),
                          kHeight(30.h),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              decoration: BoxDecoration(
                                color: ColorConstants.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(50.r),
                                ),
                              ),
                              child: Column(
                                children: [
                                  kHeight(50.h),
                                  EditProfilePageWidgets.textFormFields(
                                      hintText: 'Full name',
                                      textController: nameController),
                                  EditProfilePageWidgets.textFormFields(
                                      hintText: 'Phone number',
                                      isNumber: true,
                                      textController: phoneNoController),
                                  EditProfilePageWidgets.dobSelector(
                                      dob: dob, context: context),
                                  ValueListenableBuilder(
                                      valueListenable: gender,
                                      builder: (context, _, __) {
                                        return EditProfilePageWidgets
                                            .genderSelector(gender);
                                      }),
                                  kHeight(10.h),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<EditProfileCubit>()
                                          .editUserData(
                                              user: UserEntity(
                                            userId: storedUserData.userId,
                                            fullName: nameController.text,
                                            dob: dob.value,
                                            gender: gender.value.toString(),
                                            profilePicUrl:
                                                storedUserData.profilePicUrl,
                                            createdAt: storedUserData.createdAt,
                                            email: storedUserData.email,
                                            phoneNo: phoneNoController.text,
                                            password: storedUserData.password,
                                          ));
                                    },
                                    child:
                                        EditProfilePageWidgets.submitButton(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      (state is EditProfileStateLoading)
                          ? Container(
                              height: size.height,
                              width: size.width,
                              color: Colors.black.withOpacity(0.5),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  padding: EdgeInsets.all(20.r),
                                  height: 100.r,
                                  width: 100.r,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                  ),
                                  child: const CircularProgressIndicator(
                                    color: ColorConstants.blue,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
