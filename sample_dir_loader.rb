samples_dir = "/Users/brian/Dropbox/M_U_S_I_C/audio/"
sample_sets = "keyboard loops/JonahSmith_80sMIDIKeyboards/Audio Loops/"

define :cruisin do
  set :sample_set_collection, "Cruise 84BPM AUDIO"
  use_bpm 84
end

cruisin
path = samples_dir + sample_sets + get[:sample_set_collection]

define :getSampleName do |path,index=0|
  begin
    k=(sample_paths sample_info path,index)[0].split("/")[-1]
  rescue
    return nil
  else
    return k
  end
end

define :getSampleDuration do |path,index=0|
  begin
    k=sample_duration sample_info path,index
  rescue
    return 0.1 #return small number if no sample found
  else
    return k
  end
end

live_loop :splay do
  tick
  puts getSampleName(path,look)
  sample path,look
  sleep getSampleDuration(path,look)
end
