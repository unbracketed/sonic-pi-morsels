#Robot
#Coded by Davids Fiddle

low = 60
high = 120
use_bpm 120

live_loop :beat do
  tick
  sample :bd_klub
  sample (knit :glitch_robot1,3,:glitch_robot2,1).look,
    cutoff: (line low,high,steps: 16).mirror.look
  sleep 1
end

in_thread do #control cutoff
  sleep 16
  low = 90
  high = 120
end