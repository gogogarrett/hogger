class RoadScene < SKScene
  CAR = 1
  FROGS = 2

  def didMoveToView(view)
    super
    @view = view
    @score = 0

    self.backgroundColor = SKColor.whiteColor
    self.scaleMode = SKSceneScaleModeFill
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;

    init_swipe_gestures

    add_backgrounds
    add_car
    add_highscore

    add_frog # needs to be random
  end

  def update(currentTime)

    @score += 1
    update_highscore

    @delta = if @lastUpdateTime
      currentTime - @lastUpdateTime
    else
      0
    end

    @lastUpdateTime = currentTime
    self.moveBackground
  end


  def didBeginContact(contact)
    first, second = if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
      [contact.bodyA, contact.bodyB]
    else
      [contact.bodyB, contact.bodyA]
    end

    if (first.categoryBitMask & CAR) != 0
      car, frog = first.node, second.node


      @score += 10
      update_highscore
      # car.runAction(SKAction.removeFromParent)
      frog.runAction(SKAction.removeFromParent)
    end
  end

  def update_highscore
    @highscore_label.text = "#{@score}"
  end

  # create elements
  def init_swipe_gestures
    %w[left right].each do |direction|

      gesture = UISwipeGestureRecognizer.alloc.initWithTarget(self, action: "move_#{direction}:")
      # why doesn't this work?
      # gesture.direction = "UISwipeGestureRecognizerDirection#{direction.capitalize}".constantize

      gesture.direction = if direction == 'left'
        UISwipeGestureRecognizerDirectionLeft
      else
        UISwipeGestureRecognizerDirectionRight
      end

      @view.addGestureRecognizer gesture
    end
  end

  def add_backgrounds
    2.times do |i|
      background = SKSpriteNode.spriteNodeWithImageNamed("road.png")
      background.position = CGPointMake(background.size.width / 2, (i * background.size.height) + background.size.height  / 2)
      background.zPosition = 0
      background.name = "background"

      addChild background
    end
  end

  def add_highscore
    @highscore_label = SKLabelNode.labelNodeWithFontNamed("Chalkduster")
    @highscore_label.text = "#{@score}"
    @highscore_label.fontSize = 10
    @highscore_label.fontColor = SKColor.blackColor
    @highscore_label.position = CGPointMake((scene.size.width / 2) + 60, scene.size.height / 2)

    addChild @highscore_label
  end

  def add_car
    @car = Car.initWithScene(self)
    addChild @car
  end

  def add_frog
    @frog = Frog.initWithScene(self)
    @frog.runAction SKAction.repeatActionForever(hopping_sequence)

    addChild @frog
  end

  def hopping_sequence
    SKAction.sequence([SKAction.performSelector("move_frog", onTarget: self),
                       SKAction.waitForDuration(2, withRange: 0.15)])
  end


  # actions
  def move_frog
    @position = @frog.position.x
    @frog.runAction SKAction.moveToX(@position + 90, duration: 0.5)
  end

  def move_left(recognizer)
    @car.runAction SKAction.moveByX(-58, y: 0, duration: 0.5)
  end

  def move_right(recognizer)
    @car.runAction SKAction.moveByX(58, y: 0, duration: 0.5)
  end

  def moveBackground
    self.enumerateChildNodesWithName("background", usingBlock:-> node, stop {
        bg = node
        bgVelocity = CGPointMake(0, -100)
        amountToMove = CGPointMultiplyScalar(bgVelocity, @delta)
        bg.position = CGPointAdd(bg.position,amountToMove)

        if bg.position.y <= -bg.size.height / 2
          bg.position = CGPointMake(bg.position.x, bg.position.y + (bg.size.height) * 2)
        end
    })
  end

  # helpers
  def CGPointAdd(p1, p2)
    CGPointMake(p1.x + p2.x, p1.y + p2.y)
  end

  def CGPointMultiplyScalar(velocity, delta)
    CGPointMake(velocity.x * delta, velocity.y * delta)
  end
end
