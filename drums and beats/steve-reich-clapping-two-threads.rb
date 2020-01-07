clapping_rhythm = 'xxx-xx-x-xx-'

# How many times to play each pattern before clapper two shifts it by one beat
bars_per_pattern = 2

in_thread do
  (clapping_rhythm.length * bars_per_pattern).times do |bars|
    (clapping_rhythm.length).times do |clapper_one|
      if clapping_rhythm[clapper_one] == 'x' then
        sample :perc_snap
      end
      sleep 0.125
    end
  end
end

in_thread do
  shifts = 0
  (clapping_rhythm.length * bars_per_pattern).times do |bars|
    (clapping_rhythm.length).times do |clapper_one|
      clapper_two = (clapper_one + shifts) % clapping_rhythm.length
      if clapping_rhythm[clapper_two] == 'x' then
        sample :drum_tom_hi_hard
      end
      sleep 0.125
    end
    if (bars + 1) % bars_per_pattern == 0 then
      shifts += 1
    end
    
  end
end


