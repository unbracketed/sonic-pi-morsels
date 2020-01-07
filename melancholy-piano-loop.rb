use_bpm 120

notes = (ring :a4, :d4, :c4, :a5)
time = (ring 2.0,2.0,1.0,2.0,)

notes1=(ring [:f5, :d4], [:a4], [:d5, :c4], [:c5], [:d5, :b3], [:a5], [:a4, :as3], [:g5])
time1 =(ring          2,     2,          1,     3,          1,     3,           1,     3)
mod =(ring 0,1,0,0,1,0,0,1,0,0,1,0,0)


with_fx :reverb, room: 0.8 do
  with_fx :lpf, cutoff: (range 75,65,5).mirror.tick do
    
    with_fx :level, amp: 0.5 do
      
      live_loop :piano2 do
        use_synth :piano
        if mod.tick == 1 then
          play_chord notes1.look, release: 4, sustain: 4
        else
          play_chord notes1.look, release: 1, sustain: 1
        end
        sleep time1.look
      end
      
    end
    
  end
end

live_loop :piano1 do
  sync :piano2
  if rand() >0.95
    notes = (ring :a4, :d4, :c4, :a5)
    time = (ring 2.0,2.0,1.0,2.0,)
  else
    notes = notes.shuffle
    time = time.shuffle
  end
  use_synth :piano
  6.times do
    play notes.tick, amp: 0.125, sustain: (time.look)-0.5
    sleep time.look
  end
end