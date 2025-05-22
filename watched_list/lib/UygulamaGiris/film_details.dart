import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../Models/colorspallette.dart';
import '../Models/film.dart';

class FilmDetails extends StatefulWidget {
  final Film film;

  const FilmDetails({super.key, required this.film});

  @override
  _FilmDetailsState createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    if (widget.film.video != null && widget.film.video!.isNotEmpty) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.film.video!))
            ..initialize().then((_) {
              setState(() {}); // video hazır olduğunda UI güncelle
            });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onPlayPause() {
    if (_controller == null) return;

    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        _isPlaying = false;
      } else {
        _controller!.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGC,
      appBar: AppBar(
        title: Text(widget.film.film_adi ?? ''),
        backgroundColor: ABC,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TC),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video veya Poster + Play Butonu
            if (_controller != null && _controller!.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_controller!),
                    _ControlsOverlay(
                      controller: _controller!,
                      onPlayPause: _onPlayPause,
                    ),
                    VideoProgressIndicator(_controller!, allowScrubbing: true),
                  ],
                ),
              )
            else
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    widget.film.filmResim ??
                        'https://via.placeholder.com/300x200?text=No+Image',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  if (widget.film.video != null &&
                      widget.film.video!.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        if (_controller == null) {
                          _controller = VideoPlayerController.networkUrl(
                              Uri.parse(widget.film.video!))
                            ..initialize().then((_) {
                              setState(() {});
                              _controller!.play().then((_) {
                                setState(() {
                                  _isPlaying = true;
                                });
                              });
                            });
                        } else if (_controller!.value.isInitialized) {
                          _onPlayPause();
                        }
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.black.withOpacity(0.6),
                        child: Icon(Icons.play_arrow,
                            size: 50, color: Colors.white),
                      ),
                    ),
                ],
              ),

            const SizedBox(height: 16),

            // IMDB PUANI
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5),
                  Text("IMDB: ${widget.film.imdbPuani}",
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // FİLM HAKKINDA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Film Hakkında",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: TC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.film.ozet ?? "Açıklama bulunamadı.",
                style: TextStyle(fontSize: 16, color: TC),
              ),
            ),

            // KATEGORİLER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Kategoriler",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: TC),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: widget.film.turler
                    .map((tur) => Chip(label: Text(tur)))
                    .toList(),
              ),
            ),

            const SizedBox(height: 16),

            // BAŞROL OYUNCULARI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Başrol Oyuncuları",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: TC),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.film.oyuncular
                    .map((oyuncu) => Text("- $oyuncu"))
                    .toList(),
              ),
            ),

            const SizedBox(height: 16),

            // YÖNETMEN VE YIL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.movie_creation_outlined),
                  const SizedBox(width: 8),
                  Text("Yönetmen: ${widget.film.yonetmen}",
                      style: TextStyle(color: TC)),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text("Yapım Yılı: ${widget.film.yil}",
                      style: TextStyle(color: TC)),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onPlayPause;

  const _ControlsOverlay({
    Key? key,
    required this.controller,
    required this.onPlayPause,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlayPause,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: controller.value.isPlaying
                ? const SizedBox.shrink()
                : Container(
                    color: Colors.black45,
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 80.0,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
