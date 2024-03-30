import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'note_settings.dart';

class NoteTiles extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  const NoteTiles({super.key, required this.text, this.onEditPressed, this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12)

        ),
      margin: const EdgeInsets.only(top: 20, right: 20, left: 20 ),
      child: ListTile(
        title: Text(text, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
        trailing: Builder(
          builder:(context)=> IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => showPopover(
              height: 100,
                width: 100,
                backgroundColor: Theme.of(context).colorScheme.background,
                context:context,
                bodyBuilder:(context)=>
                    NoteSettings(onEditTap: onEditPressed, onDeleteTap: onDeletePressed,)

            ),
          ),
        )
      ),
    );
  }
}
