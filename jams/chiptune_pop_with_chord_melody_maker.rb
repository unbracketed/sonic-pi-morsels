number = Time.now.to_i
use_random_seed number

define :getProg do |base|
  (ring base, :major, base+7, :major, base+9, :minor, base+5, :major)
end

define :getProg2 do |base|
  (ring base, :major, base+5, :major, base+11, :dim, base+4, :minor, base+9, :minor, base+2, :minor, base+7, :major, base, :major)
end

define :getMel do |base, chord|
  (ring (chord base, chord)[0], (chord base, chord)[1], (chord base, chord)[1]+2, (chord base, chord)[2])
end
define :getMel1 do |base, chord|
  (ring (chord base, chord)[2], (chord base, chord)[1], (chord base, chord)[1]+2, (chord base, chord)[2])
end
define :getMel2 do |base, chord|
  (ring (chord base, chord)[2], (chord base, chord)[0], (chord base, chord)[0]+2, (chord base, chord)[1])
end
define :getMel3 do |base, chord|
  (ring (chord base, chord)[1], (chord base, chord)[1], (chord base, chord)[0], (chord base, chord)[2])
end

chordProg = getProg (:C-12)
live_loop :back do
  use_synth :saw
  (chordProg.length/2).times do
    current_note = chordProg.tick(:notes)+12
    current_key = chordProg.tick(:notes)
    play_chord chord(chordProg.tick(:chord), chordProg.tick(:chord)), sustain: 1.75
    sleep 2
  end
  if one_in(2)
    chordProg = getProg (:C-12)
  else
    chordProg = getProg2 (:F-12)
  end
end

live_loop :melody do
  use_synth :chiplead
  current_note = chordProg.tick(:it)+12
  current_key = chordProg.tick(:it)
  2.times do
    if one_in(2)
      if one_in(2)
        melody = getMel current_note, current_key
      else
        melody = getMel1 current_note, current_key
      end
    else
      if one_in(2)
        melody = getMel2 current_note, current_key
      else
        melody = getMel3 current_note, current_key
      end
    end
    4.times do
      play melody.tick
      sleep 0.25
    end
  end
end

live_loop :drums do
  3.times do
    sample :bd_zum
    sleep 0.5
    sample :sn_dub
    if one_in(2)
      sleep 0.5
    else
      sleep 0.375
      sample :sn_dub
      sleep 0.125
    end
  end
  if one_in(2)
    sample :bd_zum
    sleep 0.5
    sample :sn_dub
    sleep 0.25
    sample :sn_dub
    sleep 0.25
  else
    sample :bd_zum
    sleep 0.5
    sample :sn_dub
    sleep 0.25
    sample :bd_zum
    sleep 0.125
    sample :sn_dub
    sleep 0.125
  end
end