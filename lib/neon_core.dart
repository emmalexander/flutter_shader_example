import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class NeonCore extends StatefulWidget {
  const NeonCore({Key? key}) : super(key: key);

  @override
  State<NeonCore> createState() => _NeonCoreState();
}

class _NeonCoreState extends State<NeonCore>
    with SingleTickerProviderStateMixin {
  double time = 0;

  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      time += 0.05;
      setState(() {});
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ShaderBuilder(
          assetKey: 'lib/shader/neon_core.glsl',
          child: SizedBox(
            width: size.width,
            height: size.height,
          ), (context, shader, child) {
        return AnimatedSampler((image, size, canvas) {
          shader
            ..setFloat(0, time)
            ..setFloat(1, size.width)
            ..setFloat(2, size.height);
          canvas.drawPaint(Paint()..shader = shader);
        }, child: child!);
      }),
    );
  }
}
