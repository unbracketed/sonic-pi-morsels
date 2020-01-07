use_random_seed Time.new.usec
use_synth :dsaw
f1 = 20.0
f2 = 200.0
DN = []
n = 4
slideT = 2
totalT = n * slideT * 3
for j in 0..n
  DN[j] = [:F6,:D6,:A5,:D5,:A4,:D4,:A3,:D3,:A2,:D2,:D1]
end

for i in 0 ... DN[n].length
  DN[0][i] = hz_to_midi(rrand(f1, f2))
end

for j in 1 ... n
  for i in 0 ... DN[n].length
    DN[j][i] = DN[0][i] + (DN[n][i] - DN[0][i]) / n.to_f + rrand(-n * 2 + j * 2, n * 2 - j * 2)
  end
end
with_fx :reverb, room: 1, mix: 1 do #####
  s = play DN[0], sustain: totalT, note_slide: slideT, amp: 0.1, amp_slide: slideT
  sleep slideT
  for i in 1..n
    control s, note: DN[i], amp: (i / n.to_r) + 0.5
    sleep slideT
  end
end #####
