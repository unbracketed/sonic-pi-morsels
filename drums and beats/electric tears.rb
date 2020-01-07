#Electric Tears
#Coded by Davids Fiddle

use_sample_bpm :loop_electric
with_fx :slicer, pulse_width: 0.75, phase: 0.315, wave: 1, smooth: 0.1 do
  live_loop :beat do
    sample :loop_electric
    sleep 1
  end
end
live_loop :hatz do
  use_synth_defaults amp: 0.6, sustain: 0, release: 0.05
  synth :cnoise, cutoff: 100 if one_in(4)
  synth :pnoise, cutoff: 110, decay: 0.01 if one_in(6)
  sleep 0.125
end
live_loop :kik do
  sync :beat
  sample :bd_haus
end