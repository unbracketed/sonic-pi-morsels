# 84 Cruisin
#
samples_dir = "/Users/brian/Dropbox/M_U_S_I_C/audio/"
sample_sets = "keyboard loops/JonahSmith_80sMIDIKeyboards/Audio Loops/"

define :cruisin do
  set :sample_set_collection, "Cruise 84BPM AUDIO"
  use_bpm 84
end

define :maybeinmind do
  set :sample_set_collection, "MaybeInMind 95bpm AUDIO/"
  use_bpm 95
end

define :contusion do
  set :sample_set_collection, "BandOfContusion 102bpm AUDIO/"
  use_bpm 102
end

define :donotwantme do
  set :sample_set_collection, "DoNotWantMe 118BPM AUDIO/"
  use_bpm 118
end

define :nothingaboutyou do
  set :sample_set_collection, "NothingAboutYou 104bpm AUDIO/"
  use_bpm 104
end

define :screwdriver do
  set :sample_set_collection, "Screwdriver 101bpm AUDIO/"
  use_bpm 101
end

#Pick a set:
screwdriver


cur_samples = samples_dir + sample_sets + get[:sample_set_collection]
sections = ["Verse", "Bridge", "Chorus"]
styles = ["Arp", "Bass", "Line", "Pad", "Progression"]

# can use fn
#sample_paths



set :play_bass, true
set :play_arp, false
set :measures, 0


live_loop :arp_loop do
  sync :four_bars
  if get[:play_arp]
    sample cur_samples, "Verse", "Line", 0
    sample cur_samples, "Verse", "Line", 1
  end
end


live_loop :melody_loop do
  sync :fourth_bar
  
  sample cur_samples, "Verse", "Progression", 3
  
  
end

live_loop :drum_loop do
  puts spread(2,4)
  sync :main_loop
  sample :drum_bass_hard if spread(2,4).tick
  sample :drum_cymbal_closed
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
  measures = get[:measures]
  
  set :measures, measures + 1
  if tick % 16 == 0
    cue :four_bars
    if measures >= 16
      cue :fourth_bar
    end
  end
  sleep 1
  
end



