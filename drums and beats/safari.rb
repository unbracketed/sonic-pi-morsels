#Safari Beat
#Coded by Davids Fiddle

use_sample_bpm :loop_safari
with_fx :slicer, phase: 0.5, pulse_width: 0.75 do
  live_loop :safari do
    sample :loop_safari
    sleep 1
  end
end
live_loop :hatz do
  sample :drum_cymbal_soft, amp: 0.5 if one_in(4)
  sleep 0.125
end
live_loop :kik do
  sync :safari
  sample :bd_haus
end