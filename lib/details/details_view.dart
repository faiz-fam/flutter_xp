import 'package:flutter/material.dart';

class DetailsView extends StatefulWidget {
  final String? movieTitle;
  final String? moviePosterUrl;

  const DetailsView(
      {super.key, required this.movieTitle, required this.moviePosterUrl});

  @override
  State<StatefulWidget> createState() {
    return _DetailsView();
  }
}

class _DetailsView extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Column(
        children: [
          const SizedBox(
            width: double.maxFinite,
            height: 80,
          ),
          Text(
            widget.movieTitle ?? "no title found",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: double.maxFinite,
            height: 40,
          ),
          Hero(
            tag: widget.moviePosterUrl ?? "",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(fit: BoxFit.fill, widget.moviePosterUrl ?? ""),
            ),
          ),
        ],
      ),
    );
  }
}
