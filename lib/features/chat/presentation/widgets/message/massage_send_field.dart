import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MassageSendField extends StatelessWidget {
  final bool blockState;
  final bool isDeleted;
  final VoidCallback? onTap;
  final TextEditingController messageController;
  const MassageSendField({
    super.key,
    required this.blockState,
    required this.isDeleted,
    required this.messageController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isBlocked = blockState;
    final theme = Theme.of(context).colorScheme;
    return BlocBuilder<BlockBloc, BlockState>(
      buildWhen: (previous, current) => current is BlockSuccess,
      builder: (context, state) {
        if (state is BlockSuccess) {
          isBlocked = state.isBlocked;
        }
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: MyTextField(
                  enable: !isDeleted && !isBlocked,
                  controller: messageController,
                  hintText: isBlocked
                      ? 'You have blocked this user'
                      : isDeleted
                      ? 'This account is deleted'
                      : 'Send message',
                  validator: null,
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  backgroundColor: theme.surface,
                  radius: 22,
                  child: Icon(Icons.send, color: theme.primary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
