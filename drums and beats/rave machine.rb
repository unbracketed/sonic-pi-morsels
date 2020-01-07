#Rave Machine
#Coded by Davids Fiddle
#https://youtu.be/j2gPWf3lBCQ

use_bpm 160
do_hat = 1
do_bass = 0

live_loop :controller do
  tick
  #do_hat = (knit 1,64,0,32,1,32).look
  #do_bass = (knit 0,32,1,32,0,16,1,48).look
  do_hat = 1
  do_bass = 1
  sleep 1
end

with_fx :reverb do
  with_fx :compressor, relax_time: 0.03, mix: 0.5 do
    live_loop :kick do
      tick
      sample :bd_tek, amp: 2
      sleep (ring 1,1,1,0.5,0.5,1,1,1,1,
             1,1,0.75,0.25,0.5,0.5,1,1,1,1
             ).look
    end
    
    live_loop :hat, delay: 0.5 do
      tick
      sample :glitch_perc1 if do_hat == 1
      sample :glitch_perc4 if one_in(8)
      sleep 1
    end
    
    with_fx :gverb, mix: 0.5 do
      with_fx :rlpf, mix: 0.8 do |bpf|
        live_loop :bass do
          tick
          if do_bass == 1
            synth :tech_saws, note: (knit :f2,7,:f3,1).look,
              pan: (line -0.3,0.3).mirror.look
          end
          sleep 1
        end
        live_loop :con do
          tick
          control bpf, cutoff: (line 50,90, steps: 16).mirror.look
          sleep 1
        end
      end
    end
  end
end