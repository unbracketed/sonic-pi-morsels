##| use_synth :fm
##| use_synth_defaults divisor: 24, depth: 23

# drop down to a low phase for nasty growling static , 0.1, 0.04, 0.0125

live_loop :beats do
  sample :bd_haus
  sleep 0.5
end

live_loop :tune do
  with_fx :wobble, mix: 0.8, phase: 0.04, cutoff_min: 40, cutoff_max: 110 do
    with_fx :ixi_techno, mix: 0.8, phase: 2, cutoff_min: 40, cutoff_max: 110 do
      
      play 60
      sleep 0.25
      play 62
      sleep 0.5
      play ring(66, 66, 66, 66, 65, 65, 66, 66).tick
      sleep 0.5
      play 60
      sleep 1
    end
  end
end

