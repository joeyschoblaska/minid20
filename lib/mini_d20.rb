module MiniD20
  VERSION = "0.1"
end

Dir["./lib/mini_d20/node/*.rb"].each { |f| require f }

require "./lib/mini_d20/node"
require "./lib/mini_d20/renderer"
