
samples_dir = "/Users/brian/Dropbox/M_U_S_I_C/audio/"
sample_sets = "keyboard loops/JonahSmith_80sMIDIKeyboards/Audio Loops/"
sample_set_collection = "Cruise 84BPM AUDIO/"
cur_samples = samples_dir + sample_sets + sample_set_collection
sections = ["Verse", "Bridge", "Chorus"]
styles = ["Arp", "Bass", "Line", "Pad", "Progression"]

# can use fn
#sample_paths

use_bpm 84


set :play_bass, true
set :play_melody, true


live_loop :arp_loop do
  sync :four_bars
  sample cur_samples, "Verse", "Line", 0
end


live_loop :melody_loop do
  sync :four_bars
  if get[:play_melody]
    sample cur_samples, "Verse", "Progression", 0
    sample cur_samples, "Verse", "Line", 1
  end
  
end

live_loop :drum_loop do
  sync :main_loop
  sample :drum_bass_hard if  spread(2,4)
end



live_loop :bass_loop do
  sync :four_bars
  if get[:play_bass]
    sample cur_samples, "Verse", "Bass", 2
    sample cur_samples, "Verse", "Bass", 3
    
  end
  sleep 16
end


live_loop :main_loop do
  cue :beat
  if tick % 16 == 0
    cue :four_bars
  end
  sleep 1
  
end



