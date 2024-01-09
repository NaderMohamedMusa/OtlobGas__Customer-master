import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otlobgas_driver/core/languages/app_translations.dart';
import 'package:otlobgas_driver/core/services/user_service.dart';
import 'package:otlobgas_driver/core/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../order_feature/domain/entities/driver.dart';
import '../../../domain/entities/chat_message.dart';
import '../controllers/chat_controller.dart';
import 'components/text_chat_widget.dart';
import 'components/voice_chat_widget.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);

  late Driver? customer = Get.arguments['customer'];
  late String? address = Get.arguments['address'];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            toolbarHeight: 130,
            title: CustomText(
              LocaleKeys.communicationWithTheCustomer.tr,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                  ),
            ),
            bottomWidget:
                //  controller.isLoading
                //     ? ListTile(
                //         leading: const AvatarShimmer(),
                //         title: const Padding(
                //           padding: EdgeInsets.only(bottom: 8.0),
                //           child: TextShimmer(width: 100),
                //         ),
                //         subtitle: Row(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             SvgPicture.asset(
                //               Assets.locationOutlinedIC,
                //               color: Colors.red,
                //               height: 18,
                //             ),
                //             const SizedBox(width: 5.0),
                //             const TextShimmer(width: 150),
                //           ],
                //         ),
                //       )
                //     :
                ListTile(
              leading: CircleAvatar(
                radius: 25,
                child: Image.asset(Assets.ambobaIC),
              ),
              title: CustomText(customer?.name ?? ''),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Assets.locationOutlinedIC,
                    color: Colors.red,
                    height: 18,
                  ),
                  const SizedBox(width: 5.0),
                  Flexible(
                    child: CustomText(
                      address ?? '',
                      max: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              trailing: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  launchUrl(Uri.parse("tel://${customer?.mobile}"));
                },
                icon: SvgPicture.asset(
                  Assets.callIC,
                ),
              ),
            ),
          ),
          body: CustomLoading(
            isLoading: controller.isLoading,
            widget: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    controller: controller.scrollController,
                    itemCount: controller.chat?.messages.length ?? 0,
                    itemBuilder: (context, index) {
                      final ChatMessage chatMessage =
                          controller.chat!.messages[index];
                      final bool isCurrentChat = chatMessage.userId ==
                          UserService.to.currentUser.value!.id;

                      switch (chatMessage.type) {
                        case 'audio':
                          return VoiceChatWidget(
                            isCurrentChat: isCurrentChat,
                            url: chatMessage.message,
                            // url:
                            //     '${controller.chat?.voiceUrl ?? ''}/${chatMessage.message ?? ''}',
                          );

                        default:
                          return TextChatWidget(
                            isCurrentChat: isCurrentChat,
                            text: chatMessage.message,
                          );
                      }
                    },
                  ),
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: AppColors.otherChat),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  IgnorePointer(
                                    ignoring: controller.isRecording,
                                    child: CustomTextField(
                                      hintText: controller.isRecording
                                          ? null
                                          : LocaleKeys.writeAMessage.tr,
                                      textEditingController:
                                          controller.messageController,
                                      onTap: () {
                                        controller.setEmojiShowing = false;
                                      },
                                      onChanged: (value) =>
                                          controller.onChangeText(),
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          controller.setEmojiShowing = true;
                                        },
                                        icon: const Icon(
                                          Icons.emoji_emotions_outlined,
                                          color: AppColors.mainApp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (controller.isRecording)
                                    Positioned(
                                      bottom: 5,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: controller.deleteRecord,
                                            child: const CircleAvatar(
                                              radius: 19,
                                              backgroundColor: Colors.red,
                                              child: Icon(
                                                Icons.delete_outline_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          TweenAnimationBuilder<Duration>(
                                              duration:
                                                  const Duration(seconds: 60),
                                              tween: Tween(
                                                  begin: Duration.zero,
                                                  end: const Duration(
                                                      seconds: 60)),
                                              onEnd: () =>
                                                  controller.stopRecorder(),
                                              builder: (BuildContext context,
                                                  Duration value,
                                                  Widget? child) {
                                                final minutes = value.inMinutes;
                                                final seconds =
                                                    value.inSeconds % 60;
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Text(
                                                    '${minutes.getDurationReminder}:${seconds.getDurationReminder}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: AppColors.mainApp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            if (controller.isTyping || controller.isRecording)
                              GestureDetector(
                                onTap: controller.isRecording
                                    ? controller.toggleRecorder
                                    : controller.sendMessage,
                                child: const CircleAvatar(
                                  radius: 22.5,
                                  backgroundColor: AppColors.sendCircle,
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: controller.toggleRecorder,
                                child: SvgPicture.asset(
                                  Assets.recordIC,
                                  height: 45,
                                ),
                              )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Offstage(
                          offstage: !controller.emojiShowing,
                          child: SizedBox(
                            height: 250,
                            child: EmojiPicker(
                              onEmojiSelected:
                                  (Category? category, Emoji? emoji) =>
                                      controller.onChangeText(),
                              onBackspacePressed: () =>
                                  controller.onChangeText(),
                              textEditingController: controller
                                  .messageController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                              config: Config(
                                columns: 7,
                                emojiSizeMax: 32 *
                                    (foundation.defaultTargetPlatform ==
                                            TargetPlatform.iOS
                                        ? 1.30
                                        : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                                verticalSpacing: 0,
                                horizontalSpacing: 0,
                                gridPadding: EdgeInsets.zero,
                                initCategory: Category.RECENT,
                                bgColor: Colors.white,
                                indicatorColor: Colors.blue,
                                iconColor: Colors.grey,
                                iconColorSelected: Colors.blue,
                                backspaceColor: Colors.blue,
                                skinToneDialogBgColor: Colors.white,
                                skinToneIndicatorColor: Colors.white,
                                enableSkinTones: true,
                                // showRecentsTab: true,
                                recentsLimit: 28,
                                noRecents: const Text(
                                  'No Recents',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ), // Needs to be const Widget
                                loadingIndicator: const SizedBox
                                    .shrink(), // Needs to be const Widget
                                tabIndicatorAnimDuration: kTabScrollDuration,
                                categoryIcons: const CategoryIcons(),
                                buttonMode: ButtonMode.MATERIAL,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
