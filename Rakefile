require "rubygems"
require "bundler/setup"
Bundler.require :default

require "./lib/mini_d20"

task :build do
  MiniD20::Processor.new("mini-d20.html").process
end
