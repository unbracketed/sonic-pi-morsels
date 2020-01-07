use_bpm 120

live_loop :drums do
  use_sample_defaults amp: 0.5
  sample :drum_heavy_kick
  sleep 1
  sample :drum_snare_hard
  sleep 1
  sample :drum_heavy_kick
  sleep 1
  sample :drum_snare_hard
  sleep 1
end

live_loop :hihat do
  use_sample_defaults amp: 0.5
  
  sample :drum_cymbal_closed
  sleep 0.5
  sample :drum_cymbal_pedal
  sleep 0.5
end

live_loop :bass do
  use_synth :fm
  use_synth_defaults  amp: 1.5
  play :c2
  sleep 0.25
  play :c2
  sleep 2
  play :e2
  sleep 0.75
  play :f2
  sleep 1
end

##| live_loop :melody do
##|   play_pattern_timed [:c4, :e4, :f4, :g4, :f4, :e4, :f4, :g4, :f4, :e4, :f4], [0.25, 0.25, 0.25, 1.5, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25]
##| end