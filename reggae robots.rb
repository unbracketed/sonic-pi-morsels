## ROBOTS REGGAE
## nlb - october 2019

define :monInstrument do | a=0, d=0.5, s=0.5, r=0.5 |
  use_synth :piano
  puts a , d , s , r
  use_synth_defaults attack: a, delay: d, sustain: s, release: r
end

live_loop :reggae, sync: :riff do
  
  sample :drum_cymbal_closed, rate: rrand(1, 1.6), amp: [1.2, 0.5, 0.8, 2].choose
  sleep 0.25
end

live_loop :riff do
  #monInstrument() if you want to default parameter
  monInstrument(0, 0.5, 0.5, 1) # you choose a d s r
  
  use_octave -2
  with_fx :reverb, room: 1 do
    
    play_pattern_timed [:c,:a,:e, :e], [1, 2 , 0.5, 0.5]
  end
  
end

live_loop :drums, sync: :riff do
  # stop
  with_fx :reverb, room: 0.5 do
    sample :drum_bass_soft
    sample :drum_cymbal_pedal, release: 1
    sleep 1
    
    
    
    if one_in(4)
      sample :drum_snare_soft
      sample :drum_cymbal_pedal, release: 1
      sleep 1
    else
      sample :drum_snare_soft
      sleep 0.25
      sample :drum_snare_soft
      sleep 0.75
    end
    
    
    sample :drum_bass_soft
    sample :drum_cymbal_pedal, release: 1
    sleep 0.5
    
    
    sample :drum_bass_soft
    sample :drum_cymbal_pedal, release: 1
    sleep 0.5
    
    sample :drum_snare_soft, amp: 1.2
    if one_in(2)
      sample :drum_cymbal_soft, release: 1, amp: 0.5
    end
    sleep 1
    
  end
  
  
end



live_loop :voice02, sync: :riff do
  #stop
  use_synth :piano
  with_fx :echo, decay: 0.125, mix: 0.4 do
    
    4.times do
      sleep 0.5
      play (chord :c5, 'major')
      sleep 0.5
    end
    4.times do
      sleep 0.5
      play (chord :a4, 'minor')
      sleep 0.5
    end
  end
  
end




live_loop :robots, sync: :riff do
  #stop
  
  
  # comment créer un ring avec les valeurs de 1 à 7
  #number = (line 1, 8, steps: 7).choose
  number = (line 1, 8, steps: 7).tick
  # i need an integer :-) not a float
  number = number.to_i
  puts number
  s01 = 'mehackit_robot'+number.to_s # it works
  
  puts s01 # to see in the log what happen
  with_fx :reverb, room: 1 do
    with_fx :echo, phase: 0.75, mix: 1 do
      sample s01, release: 2, pan: [-1,-0.5,0,0.5,1].choose
      sleep 4
    end
  end
end