clapping_rhythm = 'xxx-xx-x-xx-'

# How many times to play each pattern before clapper two shifts it by one beat
bars_per_pattern = 2

# As the BPM goes up (and lacking some sample mixing), it becomes harder to
# hear the interplay between the two patterns
use_bpm 45

in_thread do
  
  shifts = 0
  
  # Cycle through the rhythm pattern:
  #   Once for each beat in the rhythm,
  #   Repeated number of times specified in `bars_per_pattern`
  (clapping_rhythm.length * bars_per_pattern).times do |bars|
    
    # Play through one bar of the rhythm
    (clapping_rhythm.length).times do |clapper_one|
      # Use modulo operator so we can treat the string characters like a ring and wraparound
      clapper_two = (clapper_one + shifts) % clapping_rhythm.length
      if clapping_rhythm[clapper_one] == 'x' then
        sample :perc_snap
      end
      if clapping_rhythm[clapper_two] == 'x' then
        sample :drum_tom_hi_hard
      end
      sleep 0.125
    end
    
    # Check if it is time to shift the pattern
    if (bars + 1) % bars_per_pattern == 0 then
      shifts += 1
    end
  end
end




