import 'package:flame/box2d/box2d_component.dart';
import 'package:coronajump/components/player.dart';
import 'package:coronajump/components/background.dart';

class World extends Box2DComponent {
  Player player;

  World() : super();

  void initializeWorld() {
    //add(new Background());
    add(player = new Player(this));
  }

  @override
  void update(t) {
    super.update(t);
    //cameraFollow(player, horizontal: 0.4, vertical: 0.4);
  }
}
