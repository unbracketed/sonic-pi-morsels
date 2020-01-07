
##| live_loop :keys do
##|   use_synth :dsaw
##|   play [(chord :Ab, :major7), (chord :Db, :major7), (chord :Bb, :minor7), (chord :Eb, '7')].ring.tick, attack: 0.1, release: 1
##|   sleep 1
##| end

live_loop :keys2 do
  use_synth :dsaw
  play [(chord :Ab, :major7), (chord :Db, :major7), (chord :Bb, :minor7), (chord :Eb, '7')].ring.tick, attack: 0.1, release: 1
  sleep 1
end


