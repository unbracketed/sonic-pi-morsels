use_synth :tri

define :lone do
  play scale(:c5,:minor_pentatonic).choose,release: 0.1
  sleep 0.1
end

define :ltwo do
  play scale(:g5,:minor_pentatonic).choose,release: 0.1
  sleep 0.1
end

define :lthree do
  play scale(:c6,:minor_pentatonic).tick,release: 0.1
  sleep 0.1
end

RUNSTATE_KEY = "ll_runstate_"
LIVE_LOOP_NAME_KEY = "ll_"

define :runLoop do |name, fn|
  loopsym = (RUNSTATE_KEY + name).to_sym
  set loopsym, true
  live_loop (LIVE_LOOP_NAME_KEY + name).to_sym do
    fn.call()
    stop if ! get(loopsym)
  end
end

define :stopLoop do |name|
  set (RUNSTATE_KEY + name).to_sym, false
end


live_loop :control do
  puts "start live_loop :lone"
  runLoop "lone", method(:lone)
  sleep 4
  
  puts "stop live_loop :lone"
  puts "start live_loop :ltwo"
  stopLoop "lone"
  runLoop "ltwo", method(:ltwo)
  sleep 4
  
  puts "stop live_loop :ltwo"
  puts "start live_loop :lthree"
  stopLoop "ltwo"
  runLoop "lthree", method(:lthree)
  sleep 4
  
  puts "ADD live_loop :lone"
  runLoop "lone", method(:lone)
  sleep 2
  
  puts "ADD live_loop :ltwo"
  runLoop "ltwo", method(:ltwo)
  sleep 4
  
  puts "stop live_loop :one"
  puts "stop live_loop :ltwo"
  puts "stop live_loop :lthree"
  stopLoop "lone"
  stopLoop "ltwo"
  stopLoop "lthree"
  sleep 2
end
