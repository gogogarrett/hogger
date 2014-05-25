class SKColor < UIColor
end

class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    game_controller = GameViewController.alloc.init
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = game_controller
    @window.makeKeyAndVisible

    true
  end
end
