class RoadScene < SKScene

  def didMoveToView(view)
    super
    @view = view
    self.backgroundColor = SKColor.whiteColor
    self.scaleMode = SKSceneScaleModeFill

    init_swipe_gestures

    add_backgrounds
    add_car

    add_frog # needs to be random
  end

  def update(currentTime)
    @delta = if @lastUpdateTime
      currentTime - @lastUpdateTime
    else
      0
    end

    @lastUpdateTime = currentTime
    self.moveBackground
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

  def add_car
    @car = SKSpriteNode.spriteNodeWithImageNamed("car.png")
    @car.size = CGSizeMake(35, 35)
    @car.name = "car"
    @car.position = CGPointMake((size.width / 2) + 30, 90)

    addChild @car
  end

  def add_frog
    @frog = Frog.initWithScene(self)
    @frog.runAction(SKAction.repeatActionForever(hopping_sequence))

    addChild @frog
  end

  def hopping_sequence
    SKAction.sequence([SKAction.performSelector("move_frog", onTarget: self),
                       SKAction.waitForDuration(2, withRange: 0.15)])
  end


  # actions
  def move_frog
    @position = @frog.position.x
    @frog.runAction(SKAction.moveToX(@position + 90, duration: 0.5))
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
