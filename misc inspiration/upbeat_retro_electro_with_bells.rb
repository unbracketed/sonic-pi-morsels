use_bpm 110
use_random_seed 20191219

live_loop :bar do
  sleep 1
end

live_loop :intro do
  sync :bar
  use_synth :prophet
  use_synth_defaults cutoff: rrand(70, 110), release: rrand(1, 4), amp: (line 1.5, 0, steps: 10, inclusive: true).tick
  
  (ring 4,3,2,1).look.times do
    play_chord chord(:D3, :minor )
    sleep 0.75
  end
  
  sleep 0.5
  play_chord chord(:D4, :minor ), attack: 4, release: 2
  sleep 2
end

with_fx :distortion, mix: 0.06 do
  with_fx :eq, low_note: 60, low: -0.8 do
    live_loop :beats do ; tick
      s = :loop_breakbeat
      pattern = (ring 1,0,0,0, 2,0,0,0, 1,0,0,0, 3,0,0,1)
      
      sample s, slice: 0, num_slices: 32, amp: rrand(5, 5.1) if pattern.look == 1
      sample s, slice: 8, num_slices: 32, amp: rrand(5, 5.1) if pattern.look == 2
      sample s, slice: 8, num_slices: 32, amp: rrand(5, 5.1), rate: 0.95 if pattern.look == 3
      
      sleep 0.25
    end
  end
end

live_loop :bassline1 do
  use_synth :prophet
  use_synth_defaults release: rrand(0.05, 0.25), amp: rrand(1.5, 2)
  notes = scale(:d2, :minor)
  play notes.tick, cutoff: rrand(40, 120)
  
  sleep 0.25
end

live_loop :bassline2 do
  use_synth :blade
  use_synth_defaults release: rrand(0.25, 0.5), amp: rrand(1.5, 2)
  
  if rand(1) > 0.65 then
    notes = scale(:d2, :minor) + (ring :r)
  else
    notes = scale(:d1, :minor).shuffle + (ring :r)
  end
  
  play notes.tick, cutoff: rrand(40, 120)
  sleep 0.25
end

live_loop :snaps do
  sync :bar
  
  4.times do
    sleep 2
    sample :perc_snap, amp: 1.5 if rand < 0.8
  end
end

live_loop :lead do
  notes = (ring :d5) + (scale :d5, :minor, num_octaves: 2).shuffle
  s = synth :pretty_bell, note: :e5, sustain: 4, note_slide: 0.1, amp: 0.2
  
  control s, note: notes.tick, note_slide: (line 0, 0.1, steps: 2).look
  sleep (ring 1, 1, 1, 1, 0.5, 0.5, 1, 2).look
end