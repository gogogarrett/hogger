class GameViewController < UIViewController
  def loadView
    view = SKView.alloc.init
    view.showsFPS = true
    view.showsDrawCount = true
    view.showsNodeCount = true

    self.view = view
  end

  def viewWillLayoutSubviews
    super

    unless self.view.scene
      view.presentScene RoadScene.alloc.initWithSize(self.view.bounds.size)
    end
  end
end
