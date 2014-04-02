class Car < SKNode

  def self.initWithScene(scene)
    car = SKSpriteNode.spriteNodeWithImageNamed("car.png")
    car.size = CGSizeMake(35, 35)
    car.name = "car"
    car.position = CGPointMake((scene.size.width / 2) + 30, 90)
    car
  end

end
