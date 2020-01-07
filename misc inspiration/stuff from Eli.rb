use_bpm 110

live_loop :bar do
  sleep 1
end

live_loop :beat4 do
  sleep 4
end

# mixer
intro_vol = (line 1,0, steps: 10, inclusive: true).ramp
x=5
#show opener...

with_fx :echo, phase: 2, mix: 0.5 do
  with_fx :panslicer, mix: 0.5 do
    with_fx :hpf, cutoff: 70 do
      with_fx :reverb, mix: 0.4 do
        with_fx :echo, mix: 0.2 do
          
          live_loop :intro do
            sync :bar
            use_synth :prophet
            use_synth_defaults cutoff: rrand(70, 110),
              release: rrand(1, 4), amp: intro_vol.tick
            if x > 0 then
              x=x-1
            else
              x=4
            end
            
            x.times do
              play_chord chord(:D3, :minor )
              sleep 0.75
            end
            sleep 0.5
            play_chord chord(:D4, :minor ), attack: 4, release: 2
            sleep 2
          end
        end
      end
    end
  end
end

sleep 48
# put your own code here...

with_fx :distortion, mix: 0.06 do
  with_fx :nrhpf, cutoff: 30, mix: 0.1 do
    
    live_loop :beats do
      sync :bar
      sample :loop_compus, beat_stretch: 16, amp: 2
      sleep 16
    end
    
    live_loop :drums do
      sync :bar
      sample :bd_haus, amp: 2
      sleep 1
    end
  end
end

sleep 32

with_fx :reverb, mix: 0.2 do
  
  live_loop :bassline1 do
    use_synth :prophet
    use_synth_defaults release: rrand(0.05, 0.25), amp: rrand(1.5, 2)
    notes = (ring :C2, :C3, :r, :Eb3, :r, :G2, :Bb2, :r)
    play notes.tick, cutoff: rrand(40, 120)
    
    sleep 0.25
  end
  
  live_loop :bassline do
    use_synth :blade
    use_synth_defaults release: rrand(0.25, 0.5), amp: rrand(1.5, 2)
    if rand(1) > 0.65 then
      notes = (ring :C2, :C3, :r, :Eb3, :r, :G2, :Bb2, :r)
    else
      notes = (ring :C2, :C3, :r, :Eb3, :r, :G2, :Bb2, :r).shuffle
    end
    play notes.tick, cutoff: rrand(40, 120)
    
    sleep 0.25
  end
end

sleep 32

live_loop :hihat do
  sync :bar
  sample :drum_cymbal_pedal, amp: 0.2
  sleep 0.25
end

with_fx :reverb, mix: 0.5 do
  live_loop :snaps do
    sync :bar
    4.times do
      sleep 2
      sample :perc_snap, amp: 1.5 if rand < 0.8
    end
  end
end
