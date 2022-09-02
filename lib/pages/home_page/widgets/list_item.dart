import 'package:flutter/material.dart';
import 'package:teste_tec3/models/favorite.dart';

class ListItem extends StatefulWidget {
  final bool initialFavoriteState;
  final ValueChanged<Favorite> onPressed;
  final String text;
  final String category;

  const ListItem({
    required this.initialFavoriteState,
    this.text = "",
    required this.category,
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
        widget.text,
        style: const TextStyle(
          fontFamily: "Starjedi",
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            _isFavorite = !_isFavorite;
          });
          widget.onPressed(Favorite(widget.text, widget.category));
        },
        icon: _isFavorite
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_outline),
      ),
    );
  }
}
