# Title: Droid Skit (Stock Edit)
# Artist: Binarysweets
# Date: May 2019
# Original: https://binarysweets.bandcamp.com/track/droid-skit
#
# Sonic Pi v3.1 (Win 10)

use_bpm 137
barLength = 32
use_random_seed 423
use_tuning :pythagorean

define :getPitchFromNote do |note, sampleBaseNote, fineTune|
  return note - sampleBaseNote + fineTune
end
define :run do |parts|
  parts.each { |part|
    in_thread do
      send part
    end
  }
end
define :bar do
  sleep barLength
end

define :lead1 do |switch = 1|
  pattern = (ring :Ds, :F, :Fs, :Gs, :As, :B, :Cs, :Ds, :Ds, :Cs, :B, :As, :Gs, :Fs, :F, :Ds) if switch == 1
  pattern = (ring :Ds, :Cs, :B, :Cs, :As, :Ds, :Fs, :F, :Fs, :Gs, :F, :B, :Ds, :As, :Gs, :Ds) if switch == 2
  pattern = (ring :Ds, :Cs, :B, :Cs, :As, :Ds, :Fs, :F, :Fs, :Gs, :F, :B, :Ds, :As, :Gs, :Ds) + (ring :Ds4, :Cs4, :B4, :Cs4, :As4, :Ds4, :Fs4, :F4, :Fs4, :Gs4, :F4, :B4, :Ds5, :As5, :Gs5, :Ds5) if switch == 3
  ampLine = (line 0.7, 0.9, steps: 64).mirror
  ampLine2 = (line 0.1, 0.4, steps: 64).mirror
  relLine = (line 2, 3, steps: 64).mirror
  idx = get[:leadCounter]
  
  (barLength).times do ; tick
    idx += 1
    with_synth :dpulse do
      with_swing (line 0.01, 0.05, steps: 8).look, pulse: 4 do
        play pattern.look, amp: ampLine[idx], release: (ring 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.3).look
      end
    end
    
    with_synth :fm do
      with_swing (line -0.01, 0.06, steps: 16).look, pulse: 4 do
        play pattern.look, amp: ampLine2[idx], release: relLine[idx]
      end
    end
    
    sleep (ring 1, 0.5, 1, 1.5, 0.5, 0.25, 0.25, 3).look
    set :leadCounter, idx
  end
end
define :lead2 do
  lead1 2
end
define :lead3 do
  lead1 3
end

define :leadAcc do
  pattern = (ring :Ds3, :F3, :Fs3, :Gs3, :As3, :B3, :Cs3, :Ds3)
  
  with_fx :echo, decay: 16, phase: 0.125 do
    (barLength / 4).times do ; tick
      with_synth :dpulse do
        with_swing (line 0.01, 0.05, steps: 8).look, pulse: 4 do
          play pattern.look, amp: rrand(0.1, 0.3), release: 1
        end
      end
      
      with_synth :fm do
        with_swing (line -0.01, 0.05, steps: 16).look, pulse: 4 do
          play pattern.look, amp: rrand(0.2, 0.4), release: 1
        end
      end
      
      sleep 4
    end
  end
end

define :lowBells do
  use_octave 2
  pattern = (ring :Ds, :F, :Fs, :Gs, :As, :B, :Cs, :Ds, :Ds, :F, :Fs, :Gs, :As, :B, :Cs, :Ds).reverse.repeat(3) + (ring :Ds, :F, :Fs, :Gs, :As, :B, :Cs, :Ds, :Ds, :F, :Fs, :Gs, :As, :B, :Cs, :Ds)
  idx = get[:lowBellsCounter]
  
  (barLength * 2).times do ; tick
    idx += 1
    with_swing (line -0.02, 0.05, steps: 8).look, pulse: 4 do
      play pattern.look, amp: rrand(0.02, 0.03), release: 2, pan: (line -0.5, 0.5, steps: 128).mirror[idx]
    end
    
    sleep 0.5
    set :lowBellsCounter, idx
  end
end

define :bass1 do |switch = false|
  pattern = (ring :Ds2, :F2, :Fs2, :Gs2, :As2, :B2, :Cs2, :Ds2, :Ds2, :Cs2, :B2, :As2, :Gs2, :Fs2, :F2, :Ds2)
  sleeps = (ring 1, 0.5, 1, 1.5, 0.5, 0.25, 0.25, 3) if switch == false
  sleeps = (ring 1, 0.5, 1, 1.5) if switch == true
  
  (barLength).times do ; tick
    with_synth :dtri do
      with_fx :distortion, distort: 0.5, mix: 0.1 do
        with_swing (line 0.01, 0.05, steps: 8).look, pulse: 4 do
          play pattern.look, amp: 0.3, sustain: 0.4, decay: 0.2, release: 0.125
          #with_octave -1 do
          #  play pattern.look, amp: 0.3, sustain: 0.4, decay: 0.2, release: 0.125
          #end
        end
      end
    end
    
    sleep sleeps.look
  end
end
define :bass2 do
  bass1 true
end

define :chords1 do |switch = false|
  pattern = (ring chord(:Ds, :minor7), chord(:Ds, :minor7), chord(:Ds, :minor7), chord(:Fs, :major7)) if switch == false
  pattern = (ring chord_degree(1, :DS, :minor, 4), chord_degree(3, :DS, :minor, 4), chord_degree(4, :DS, :minor, 4), chord_degree(5, :DS, :minor, 4)) if switch == true
  
  (barLength / 8).times do ; tick
    with_synth :fm do
      with_fx :rlpf, cutoff: (line 60, 100, steps: 16).mirror.look do
        with_swing rrand(-0.01, 0.03), pulse: 4 do
          play pattern.look, amp: 0.7, release: 4
        end
      end
    end
    
    sleep 8
  end
end
define :chords2 do
  chords1 true
end

define :beats1 do
  s = :loop_compus
  sample :loop_breakbeat
  pattern = (ring 1,0,0,0, 2,0,0,1, 1,0,1,0, 2,0,0,0, 1,0,1,0, 2,0,0,1, 1,0,0,0, 3,1,0,0).repeat(3) + (ring 1,0,0,0, 2,0,0,1, 1,0,0,0, 2,0,0,0, 0,0,1,0, 2,0,2,1, 1,0,0,0, 3,0,0,0)
  
  with_fx :eq, low_note: 60, low: -0.5 do
    (barLength * 4).times do ; tick
      with_fx :distortion, distort: 0.4, mix: 0.1 do
        with_swing (line 0.01, 0.05, steps: 8).look, pulse: 4 do
          sample s, slice: 0, num_slices: 32, amp: rrand(8, 8.2) if pattern.look == 1
          sample s, slice: 4, num_slices: 32, amp: rrand(8, 8.2) if pattern.look == 2
          sample s, slice: 4, num_slices: 32, amp: rrand(8, 8.2), rate: 0.95 if pattern.look == 3
        end
      end
      
      sleep 0.25
    end
  end
end

define :beats2 do
  s = :loop_compus
  
  with_fx :eq, low_note: 60, low: -0.8 do
    (barLength).times do ; tick
      with_fx :bitcrusher, bits: (line 2, 16, steps: 16).mirror.look do
        with_swing (line 0.01, 0.05, steps: 8).look, pulse: 4 do
          sample :bd_pure, amp: rrand(6, 6.2), rate: 1
          sample s, slice: 4, num_slices: 32, amp: rrand(8, 8.2), rate: 1 if spread(1, 9).look
        end
        
        sleep 1
      end
    end
  end
end

define :hats do
  s = :loop_compus
  
  with_fx :eq, low_note: 60, low: -0.8 do
    (barLength * 2).times do ; tick
      with_swing (line 0.01, 0.05, steps: 8).look, pulse: 4 do
        sample s, slice: 1, num_slices: 32, amp: rrand(4, 4.2) if (spread 6, 11).look
        sample s, slice: 1, num_slices: 32, amp: rrand(4, 4.2) if (spread 9, 4).look
      end
      
      sleep 0.5
    end
  end
end

define :slowLead do |_pan = 0.3|
  use_synth :chiplead
  pattern = (ring :Ds5, :F5, :Fs5, :Gs5, :As5, :B5, :Cs5, :Ds6)
  phaseLine = (line 5, 10, steps: 8)
  
  (barLength / 4).times do ; tick
    with_fx :wobble, amp: 1, phase: phaseLine.look, wave: 3 do
      with_swing rrand(-0.01, 0.03), pulse: 4 do
        play pattern.look, amp: 0.3, attack: 0.2, sustain: 2, decay: 2, release: 6, pan: _pan
      end
    end
    
    sleep 8
  end
end
define :slowLeadL do
  slowLead -0.3
end

define :tabla do
  s = (ring "tabla_dhec.flac", "tabla_na.flac", "tabla_na_o.flac", "tabla_na_s.flac", "tabla_re.flac",
       "tabla_tas1.flac", "tabla_tas2.flac", "tabla_tas3.flac", "tabla_te_m.flac", "tabla_te2.flac").shuffle
  
  (barLength * 4).times do
    with_swing rrand(-0.03, 0.03), pulse: 4 do
      sample s[tick], amp: rrand(0.2, 0.4), pan: -0.2, rate: 1
    end
    
    sleep 0.25
  end
end


# Reset globals
set :leadCounter, 1
set :lowBellsCounter, 1

# Structure
run [:chords1, :leadAcc] ; bar
run [:chords2, :leadAcc] ; bar

run [:beats2, :chords1, :lowBells] ; bar
run [:beats2, :chords2, :lowBells] ; bar
run [:bass1, :beats1, :chords1, :hats, :lowBells] ; bar
run [:bass1, :beats1, :chords2, :hats, :lowBells, :tabla] ; bar

run [:bass1, :beats1, :chords1, :hats, :lowBells, :tabla, :lead1] ; bar
run [:bass1, :beats1, :chords2, :hats, :lowBells, :tabla, :lead1] ; bar
run [:bass2, :beats1, :hats, :lowBells, :tabla, :lead2] ; bar
run [:bass2, :beats1, :hats, :lowBells, :tabla, :lead3] ; bar

run [:bass1, :beats1, :hats, :lowBells, :tabla] ; bar
run [:bass1, :beats1, :hats, :lowBells, :tabla, :slowLead] ; bar
run [:beats2, :chords1, :leadAcc, :slowLeadL] ; bar
run [:beats2, :chords2, :leadAcc] ; bar

run [:bass1, :beats2, :chords1, :lowBells, :lead1] ; bar
run [:bass1, :beats2, :chords2, :lowBells, :lead1] ; bar