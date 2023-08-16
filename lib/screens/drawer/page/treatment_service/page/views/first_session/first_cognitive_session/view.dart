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
import '../first_stage_additional_traning/view.dart';
import '../first_stage_oases_test/view.dart';
import '../sloki/cubit/behavioral_cubit.dart';
import 'cubit/cognitive_section_cubit.dart';

// ignore: must_be_immutable

class FirstTreatmentSession extends StatefulWidget {
  const FirstTreatmentSession({Key? key}) : super(key: key);

  @override
  State<FirstTreatmentSession> createState() => _FirstTreatmentSessionState();
}

class _FirstTreatmentSessionState extends State<FirstTreatmentSession> {
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
        child: BlocConsumer<CognitiveSectionCubit, CognitiveSectionState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<CognitiveSectionCubit>(context);
            if (state is CognitiveSectionLoading) {
              return const Center(
                child: LoadingFadingCircle(),
              );
            }
            if (state is CognitiveSectionSuccess) {
              return Form(
                key: cubit.formKey,
                child: state.questionModel[0].evalType.toString() == "1"
                    ? SuccessViewWidget(
                        title1:
                            "لقد اتممت الجلسة العلاجية وسيتم تحويلك إلي الجلسة التالية عن طريق المختص بعد تقييمة لنتائج الجلسة والفيديو التي قمت بارسالة",
                        title2: "تدريب وتعليم إضافي",
                        onTap: () => Get.offAll(
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
                            Object _status =
                                state.profileModel.data.currentDiagnosesStatus;
                            if (state
                                    .profileModel.data.currentDiagnosesStatus ==
                                3) {
                              BlocProvider.of<CognitiveSectionCubit>(context)
                                  .getCognitiveSection();

                              Get.offAll(() => const FirstTreatmentSession());
                            } else if (state
                                    .profileModel.data.currentDiagnosesStatus ==
                                2) {
                              BlocProvider.of<CognitiveSectionCubit>(context)
                                  .getCognitiveSection();

                              Get.offAll(() => const FirstTreatmentSession());
                              Alert.error(
                                  "تنبية : لم تتم الموافقة على النتيجة السابقة لهذه الجلسة وتم إرسال الملاحظات على البريد الإلكترونى");
                            } else if (state
                                    .profileModel.data.currentDiagnosesStatus ==
                                1) {
                              Alert.error(
                                  "تنبية :الجلسة قيد الانتظار لحين موافقه المختص علي النتيجة السابقة");
                            } else {
                              Alert.error("ولا واحدة ");
                            }
                          }
                          if (state is ProfileError) {
                            Alert.error(state.msg);
                          }
                        }),
                      )
                    : (state.questionModel[0].examMode.toString() ==
                                "jump_oases_1" &&
                            state.questionModel[0].evalType.toString() != "1")
                        ? SuccessViewJumpTest(
                            title1:
                                "لقد اتممت الجلسة العلاجية وسيتم تحويلك إلي الجلسة التالية عن طريق المختص بعد تقييمة لنتائج الجلسة والفيديو التي قمت بارسالة",
                            title2: "الإنتقال إلي إختبار ال Oases",
                            onTap: () =>
                                Get.offAll(() => const FirstStageOasesTest()),
                          )
                        : SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTileContainer(
                                      widthh: context.width / 1.7,
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
                                      print("Index : " + index.toString());

                                      String questionType = state.questionModel[index].questionType;
                                      //int incrementedIndex = index;

                                      // Increment the index only when the questionType is "ONE"
                                      // if (questionType != "VIDEO") {
                                      //   incrementedIndex--; // Increment the index
                                      // }else{
                                      //   incrementedIndex++;
                                      // }

                                      return Center(
                                        child: Column(
                                          children: [
                                            state.questionModel[index]
                                                    .description.isEmpty
                                                ? const SizedBox.shrink()
                                                :   Row(
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
                                                     /* Align(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      26),
                                                          height:
                                                              context.height *
                                                                  0.03,
                                                          width: context.width *
                                                              0.05,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: kPrimaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Center(child: custom12Text(title: "${index+1}", color: kHomeColor)),
                                                        ),
                                                        alignment:
                                                            Alignment.topRight,
                                                      ),*/
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 8),
                                                        width:
                                                            context.width * 0.8,
                                                        height: context.height *
                                                            0.25,
                                                        child: VideoScreen(
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
                                        BlocProvider.of<BehavioralCubit>(
                                                context)
                                            .getBehavioralSection();

                                        cubit.sendCognitiveSectionAnswers();
                                      }
                                      // navigateTo(context, const SlokiScreen());
                                    },
                                  ),
                                ]),
                          ),
              );
            }
            if (state is CognitiveSectionError) {
              return Text(state.msg);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
