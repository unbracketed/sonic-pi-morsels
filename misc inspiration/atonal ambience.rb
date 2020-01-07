#Atonal Ambience
#Coded by Davids Fiddle
#https://youtu.be/uF8saqnApwI


use_random_seed 42
s0 = sample_names :ambi
s1 = sample_names :elec
s2 = sample_names :misc
s3 = sample_names :vinyl
sam = s0 + s1 + s2 + s3
live_loop :aton do
  #stop
  current = sam.choose
  puts "new sample"
  (rand_i 5).times do  #Repeat?
    sample current, rate: (line -10,10,steps: 99).choose / (ring 1,2,3).choose,
      amp: (line 0.4,2).choose
    sleep (line 0.1,1).choose
  end
  sleep (line 0.5,1.5).choose
end