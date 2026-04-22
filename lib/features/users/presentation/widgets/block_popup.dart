import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/users/presentation/bloc/block/block_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlockPopup extends StatelessWidget {
  final String otherUserUid;
  final String currentUserUid;
  final bool isBlocked;
  final Color bgColor;
  const BlockPopup({
    super.key,
    required this.otherUserUid,
    required this.currentUserUid,
    required this.isBlocked,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MenuAnchor(
        style: MenuStyle(
          padding: WidgetStateProperty.all(EdgeInsetsGeometry.zero),
          backgroundColor: WidgetStatePropertyAll(bgColor),
          elevation: const WidgetStatePropertyAll(8),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        builder: (context, controller, child) {
          return IconButton(
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
            icon: Icon(Icons.more_vert_outlined),
          );
        },
        menuChildren: [
          //block
          !isBlocked
              ? MenuItemButton(
                  leadingIcon: FaIcon(
                    FontAwesomeIcons.ban,
                    color: Colors.red,
                    size: 18,
                  ),
                  child: Text('Block', style: TextStyle(color: Colors.red)),
                  onPressed: () => context.read<BlockBloc>().add(
                    BlockUser(
                      currentUserUid: AuthService().currentUserUid,
                      otherUserUid: otherUserUid,
                    ),
                  ),
                )
              :
                //unblock
                MenuItemButton(
                  leadingIcon: FaIcon(FontAwesomeIcons.unlock, size: 18),
                  child: Text('Unblock'),
                  onPressed: () => context.read<BlockBloc>().add(
                    UnblockUser(
                      currentUserUid: currentUserUid,
                      otherUserUid: otherUserUid,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
