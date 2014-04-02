class Car < SKNode

  def self.initWithScene(scene)
    car = SKSpriteNode.spriteNodeWithImageNamed("car.png")
    car.size = CGSizeMake(35, 35)
    car.name = "car"
    car.position = CGPointMake((scene.size.width / 2) + 30, scene.size.height / 2)

    setup_physics(car)
  end

  def self.setup_physics(car)
    car.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize car.size
    car.physicsBody.usesPreciseCollisionDetection = true
    car.physicsBody.categoryBitMask = RoadScene::CAR
    car.physicsBody.contactTestBitMask = RoadScene::FROGS
    car.physicsBody.collisionBitMask = 0

    car
  end

end
