import 'package:flutter/material.dart';

import 'package:teste_tec3/models/swinfo.dart';

class ListItem extends StatefulWidget {
  final bool initialFavoriteState;
  final ValueChanged<SWInfo> onPressed;
  final SWInfo swinfo;

  const ListItem({
    required this.initialFavoriteState,
    required this.swinfo,
    required this.onPressed,
    super.key,
  });

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initialFavoriteState;
  }

  @override
  Widget build(context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: const BorderSide(),
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text(
        widget.swinfo.title,
        style: const TextStyle(
          fontFamily: "Conthrax",
          fontSize: 14,
        ),
      ),
      trailing: IconButton(
        tooltip: "Favoritar",
        onPressed: () {
          setState(() {
            _isFavorite = !_isFavorite;
          });
          widget.onPressed(widget.swinfo);
        },
        icon: _isFavorite
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_outline),
      ),
    );
  }
}
