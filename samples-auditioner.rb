
samples_dir = "/Users/brian/Dropbox/M_U_S_I_C/audio/"
sample_sets = "keyboard loops/JonahSmith_80sMIDIKeyboards/Audio Loops/"
sample_set_collection = "Cruise 84BPM AUDIO/"
cur_samples = samples_dir + sample_sets + sample_set_collection
sections = ["Verse", "Bridge", "Chorus"]
styles = ["Arp", "Bass", "Line", "Pad", "Progression"]

loop do
  idx = tick
  duration = sample_duration cur_samples, sections[0], idx
  puts duration
  samp = sample cur_samples, sections[0], idx
  sleep duration
end
