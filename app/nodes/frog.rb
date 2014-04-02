class Frog < SKNode

  def self.initWithScene(scene)
    frog = SKSpriteNode.spriteNodeWithImageNamed("frog.png")
    frog.size = CGSizeMake(35, 35)
    frog.position = CGPointMake(10, scene.size.height / 2)

    setup_physics(frog)
  end

  def self.setup_physics(frog)
    frog.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize frog.size
    frog.physicsBody.usesPreciseCollisionDetection = true
    frog.physicsBody.dynamic = false
    frog.physicsBody.categoryBitMask = RoadScene::FROGS
    frog.physicsBody.contactTestBitMask = RoadScene::CAR
    frog.physicsBody.collisionBitMask = 0

    frog
  end

end
