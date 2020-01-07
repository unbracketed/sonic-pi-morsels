# Random walk around on the Circle of Fifth
use_debug false
use_random_seed Time.new.usec
use_synth :pluck
i=0
loop do
  2.times do
    play_pattern_timed (chord 48 + i%12, :major),0.01
    puts i/7, note_info(48 + i%12)
    sleep 0.5
  end
  i=i+(rrand_i(0,2)-1)*7
end
