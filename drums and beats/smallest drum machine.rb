#Smallest Drum Machine
#With Randomisation
#Coded by Davids Fiddle

#Patterns:
p_kik = (ring 1,0,0,1,0,3,0,0)
p_sna = (ring 0,0,1,0,0,0,1,0)
p_hat = (ring 1,1,5,5,3,4,5,3)
#For the fill
f_tom = (ring 4,4,4,4,4,4,4,4)
f_kik = (ring 0,3,3,0,3,0,4,4)
f_sna = (ring 5,3,0,5,6,7,0,5)
#Fill state
fill = 0
#BPM:
use_bpm = 60

live_loop :filler do
  sleep 12
  fill = 1
  puts "filling"  #Debug Option
  sleep 4
  fill = 0
end

live_loop :drums do
  tick
  sample :drum_bass_hard if one_in(p_kik.look)
  sample :drum_snare_hard if one_in(p_sna.look)
  sample (knit :drum_cymbal_closed,5, :drum_cymbal_pedal,1).choose if one_in(p_hat.look)
  if fill == 1
    sample (ring :drum_tom_hi_hard, :drum_tom_lo_hard, :drum_tom_mid_hard).choose if one_in(f_tom.look)
    sample :drum_bass_hard if one_in(f_kik.look)
    sample :drum_snare_hard if one_in(f_sna.look)
  end
  sleep 0.25
end