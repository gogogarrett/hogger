class Frog < SKNode

  def self.initWithScene(scene)
    frog = SKSpriteNode.spriteNodeWithImageNamed("frog.png")
    frog.size = CGSizeMake(35, 35)
    frog.position = CGPointMake(10, scene.size.height / 2)
    frog
  end

end
