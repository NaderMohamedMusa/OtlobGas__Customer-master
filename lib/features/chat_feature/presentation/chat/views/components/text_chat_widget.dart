import 'package:flutter/material.dart';

import '../../../../../../core/utils/utils.dart';
import '../../../../../../core/widgets/custom_text.dart';
import 'chat_holder_widget.dart';

class TextChatWidget extends StatelessWidget {
  const TextChatWidget({
    super.key,
    required this.isCurrentChat,
    required this.text,
  });
  final bool isCurrentChat;
  final String? text;
  @override
  Widget build(BuildContext context) {
    final bool isTextRTL = Utils.getDirection(text ?? '') == TextDirection.rtl;

    return ChatHolderWidget(
      isCurrentChat: isCurrentChat,
      child: CustomText(text ?? '',
          textAlign: Utils.isRTL
              ? isTextRTL
                  ? TextAlign.start
                  : TextAlign.end
              : isTextRTL
                  ? TextAlign.end
                  : TextAlign.start),
    );
  }
}
