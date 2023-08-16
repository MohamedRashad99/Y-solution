import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tal3thoom/config/custom_shared_prefs.dart';import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../../../home/pages/views/profile/cubit/profile_cubit.dart';
import '../../../../../../../widgets/alerts.dart';
import '../../../../../../../widgets/appBar.dart';
import '../../../../../../../widgets/better_video_widget.dart';
import '../../../../../../../widgets/constants.dart';
import '../../../../../../../widgets/customButton.dart';
import '../../../../../../../widgets/loading.dart';
import '../../../../../../../widgets/success_widget.dart';
import '../../../../../../../widgets/sucess_widget_treatment_tests.dart';
import '../../../../../../view.dart';
import '../../first_session/first_stage_additional_traning/view.dart';
import '../second_stage_oases_test/view.dart';
import '../second_tratement_sessions_sloki/cubit/second_behavioral_cubit.dart';
import 'cubit/second_cognitive_section_cubit.dart';

// ignore: must_be_immutable
class SecondTreatmentSession extends StatefulWidget {
  const SecondTreatmentSession({Key? key}) : super(key: key);

  @override
  State<SecondTreatmentSession> createState() => _SecondTreatmentSessionState();
}

class _SecondTreatmentSessionState extends State<SecondTreatmentSession> {
  final currentStage = Prefs.getString("currentStage");
  final currentDiagnosesStatus = Prefs.getString("currentDiagnosesStatus");
  final FijkPlayer player = FijkPlayer();

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    final profileStatus = BlocProvider.of<ProfileCubit>(context);

    return Scaffold(
      backgroundColor: kHomeColor,
      drawer: const MenuItems(),
      appBar: DynamicAppbar(
          context: context,
          press: (context) => Scaffold.of(context).openDrawer()),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: context.height,
        width: context.width,
        color: kHomeColor,
        child: BlocConsumer<SecondCognitiveSectionCubit,
            SecondCognitiveSectionState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<SecondCognitiveSectionCubit>(context);
            if (state is SecondCognitiveSectionLoading) {
              return const Center(
                child: LoadingFadingCircle(),
              );
            }
            if (state is SecondCognitiveSectionSuccess) {
              return Form(
                key: cubit.formKey,
                child: state.questionModel[0].evalType.toString() == "1"
                    ? SuccessViewWidget(
                        title1:
                            "لقد اتممت الجلسة العلاجية وسيتم تحويلك إلي الجلسة التالية عن طريق المختص بعد تقييمة لنتائج الجلسة والفيديو التي قمت بارسالة",
                        title2: "تدريب وتعليم إضافي",
                        onTap: () => Get.off(
                            () => const FirstStageAdditionalTrainingScreen()),
                        goNext: true,
                        title3: "الجلسة العلاجية التالية",
                        onTap2: () {},
                        withAdditionalButton: true,
                        button: BlocConsumer<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                          if (state is ProfileLoading) {
                            return const Center(child: LoadingFadingCircle());
                          }
                          return CustomButton(
                            color: kPrimaryColor,
                            onPressed: () {
                              BlocProvider.of<ProfileCubit>(context)
                                  .getProfile();
                            },
                            title: "الجلسة العلاجية التالية",
                          );
                        }, listener: (context, state) {
                          if (state is ProfileSuccess) {
                            print((state.profileModel.data
                                            .currentDiagnosesStatus ==
                                        1)
                                    .toString() +
                                "Khalllllllllllled");
                            print(state.profileModel.data.currentDiagnosesStatus
                                    .toString() +
                                "Khalllllllllllled");
                            if (state
                                    .profileModel.data.currentDiagnosesStatus ==
                                3) {
                              BlocProvider.of<SecondCognitiveSectionCubit>(
                                      context)
                                  .getSecondCognitiveSection();

                              Get.off(() => const SecondTreatmentSession());
                            } else if (state
                                    .profileModel.data.currentDiagnosesStatus ==
                                2) {
                                                          BlocProvider.of<SecondCognitiveSectionCubit>(
                                      context)
                                  .getSecondCognitiveSection();

                              Get.off(() => const SecondTreatmentSession());
                                                          Alert.error(
                                                              "تنبية : لم تتم الموافقة على النتيجة السابقة لهذه الجلسة وتم إرسال الملاحظات على البريد الإلكترونى");

                            } else if (state
                                    .profileModel.data.currentDiagnosesStatus ==
                                1) {
                              Alert.error(
                                  "تنبية :الجلسة قيد الانتظار لحين موافقه المختص علي النتيجة السابقة");
                            } else {
                              Alert.error("ولا واحدة");
                            }
                          }
                          if (state is ProfileError) {
                            Alert.error(state.msg);
                          }
                        }),
                      )
                    : (state.questionModel[0].examMode.toString() ==
                                "jump_oases_2" &&
                            state.questionModel[0].evalType.toString() == "3")
                        ? SuccessViewJumpTest(
                            title1:
                                "لقد اتممت الجلسة العلاجية وسيتم تحويلك إلي الجلسة التالية عن طريق المختص بعد تقييمة لنتائج الجلسة والفيديو التي قمت بارسالة",
                            title2: "الإنتقال إلي إختبار ال Oases",
                            onTap: () =>
                                Get.off(() => const SecondStageOasesTest()),
                          )
                        : SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTileContainer(
                                      widthh: context.width / 1.5,
                                      title: "الجلسة العلاجية " +
                                          state.questionModel[0].tags
                                              .toString(),
                                      context: context),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 4),
                                    child: Image.asset(
                                      "assets/images/marfi.png",
                                    ),
                                  ),
                                  ListView.builder(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: state.questionModel.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Column(
                                          children: [
                                            state.questionModel[index]
                                                    .description.isEmpty
                                                ? const SizedBox.shrink()
                                                : Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 4),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 6,
                                                                vertical: 4),
                                                        width:
                                                            context.width * 0.8,
                                                        // height: context.height * 0.14,
                                                        decoration:
                                                            const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                ),
                                                                color:
                                                                    kBackgroundButton),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AutoSizeText(
                                                              "$index - " +
                                                                  state
                                                                      .questionModel[
                                                                          index]
                                                                      .description,
                                                              style: const TextStyle(
                                                                  color:
                                                                      kBlackText,
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'DinBold'),
                                                              maxLines: 2,
                                                            ),
                                                            FormBuilder(
                                                              autovalidateMode:
                                                                  AutovalidateMode
                                                                      .always,
                                                              child:
                                                                  FormBuilderRadioGroup<
                                                                      dynamic>(
                                                                decoration:
                                                                    const InputDecoration(
                                                                  labelStyle: TextStyle(
                                                                      color:
                                                                          kBlackText,
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'DinBold'),
                                                                  // labelText: "${index + 1} " +
                                                                  //     state
                                                                  //         .questionModel[
                                                                  //             index]
                                                                  //         .description,
                                                                ),
                                                                initialValue: cubit
                                                                        .answer[
                                                                    state.questionModel[
                                                                        index]],
                                                                name:
                                                                    'best_language',
                                                                onChanged:
                                                                    (value) {
                                                                  log('$value');
                                                                  if (value !=
                                                                      null) {
                                                                    setState(
                                                                        () {
                                                                      cubit.answer[
                                                                              state.questionModel[index]] =
                                                                          value;
                                                                    });
                                                                  }
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      null) {
                                                                    return 'من فضلك أجب علي المدون أعلاة ';
                                                                  }
                                                                  return '';
                                                                },
                                                                options: state
                                                                    .questionModel[
                                                                        index]
                                                                    .answers
                                                                    .map((lang) =>
                                                                        FormBuilderFieldOption(
                                                                          value:
                                                                              lang,
                                                                          child: customText3(
                                                                              title: lang.answerOption.toString(),
                                                                              color: kBlackText),
                                                                        ))
                                                                    .toList(
                                                                        growable:
                                                                            false),
                                                                controlAffinity:
                                                                    ControlAffinity
                                                                        .trailing,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            state.questionModel[index]
                                                        .videoFile ==
                                                    null
                                                ? const SizedBox.shrink()
                                                : Column(
                                                  children: [
                                                    videoHint(),
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(vertical: 8),
                                                        width: context.width * 0.8,
                                                        height:
                                                            context.height * 0.25,
                                                        child:

                                                            // BetterVideoItems(video:      BetterPlayer.network(
                                                            //   "http://mcsc-saudi.com/api/" +
                                                            //       state
                                                            //           .questionModel[
                                                            //       index]
                                                            //           .videoFile
                                                            //           .toString(),
                                                            //   betterPlayerConfiguration: const BetterPlayerConfiguration(
                                                            //     aspectRatio: 16 / 9,
                                                            //   ),
                                                            // ),
                                                            //
                                                            //
                                                            //
                                                            //
                                                            // ),

                                                            VideoScreen(
                                                          url: "http://mcsc-saudi.com/api/" +
                                                              state
                                                                  .questionModel[
                                                                      index]
                                                                  .videoFile
                                                                  .toString(),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  CustomButton(
                                    color: kPrimaryColor,
                                    title: "متابعة",
                                    onPressed: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        BlocProvider.of<SecondBehavioralCubit>(
                                                context)
                                            .getSecondBehavioralSection();

                                        cubit
                                            .sendSecondCognitiveSectionAnswers();
                                      }
                                      // navigateTo(context, const SlokiScreen());
                                    },
                                  ),
                                ]),
                          ),
              );
            }
            if (state is SecondCognitiveSectionError) {
              return Text(state.msg);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
