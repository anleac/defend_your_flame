import 'package:defend_your_flame/core/flame/main_game.dart';
import 'package:defend_your_flame/core/flame/worlds/main_world.dart';
import 'package:defend_your_flame/core/storage/saves/game_save.dart';
import 'package:flame/components.dart';

class ActiveGameManager extends Component with HasWorldReference<MainWorld>, HasGameReference<MainGame> {
  void resetGame() {
    world.playerBase.reset();
    world.entityManager.clearEntities();
    world.shopManager.resetPurchases();
    world.roundManager.overrideRound(0);
  }

  void loadGame(GameSave save) {
    resetGame();

    for (var purchase in save.purchaseOrder) {
      world.shopManager.handlePurchase(purchase, restoringSave: true);
    }

    world.playerBase.loadFromSave(save);
    world.roundManager.overrideRound(save.currentRound - 1);
  }

  void performAutoSave() {
    var saveData = GameSave.fromData(world);
    game.gameData.saveSave(saveData, saveData.saveSlot);
  }

  void clearAutoSave() {
    game.gameData.clearAutoSave();
  }
}
