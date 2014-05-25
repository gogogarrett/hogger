# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end
# require 'motion-support/inflector'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'hogger'
  app.frameworks += ["SpriteKit"]
  app.interface_orientations = [:landscape_left]
end
