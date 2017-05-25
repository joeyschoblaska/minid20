require "rubygems"
require "bundler/setup"
Bundler.require :default

require "./lib/mini_d20"

desc "generate PDF from HTML input"
task :generate do
  MiniD20::Processor.new("mini-d20.html").process
end
