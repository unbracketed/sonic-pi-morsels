# Hold Better
#
# loop with synth, typewriter / 'shutter' percussion
use_bpm 120
samples_dir = "/Users/brian/Dropbox/M_U_S_I_C/recording/Songs/Hold Better/export"

live_loop :notes do
  play [:f3, :a3, :c4, :e4], amp: 0.5, release: 1.5
  sleep 2
  play [:a3, :c4, :e4, :g4], attack: 0.25, amp: 0.75
  sleep 2
end

with_fx :hpf, cutoff: 105 do
  
  live_loop :perc, sync: :notes do
    sleep 1.75
    sample samples_dir, "click-clack.wav", amp: 0.5
    sleep 16 - 1.75
  end
end



with_fx :reverb, room: 0.6 do
  live_loop :bell, sync: :notes do
    sleep 10
    sample samples_dir, "ding.wav", amp: 0.6
    sleep 6
  end
  
end

