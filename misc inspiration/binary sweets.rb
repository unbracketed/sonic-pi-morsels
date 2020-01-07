# Title: Just
# Artist: Binarysweets
# Date: Jul-2019
#
# SonicPi v3.1 (Win 10)


# Settings
use_bpm 100
use_random_seed 314
barLength = 32
scaleName = :dorian


# Loops
define :bar do
  sleep barLength
end

define :beats do
  (barLength).times do
    sample :bd_zum, amp: rrand(0.9, 1)
    sleep 0.5
    with_synth :zawa do
      play [:c3, :c4, :c5].choose, release: 0.1, amp: rrand(0.3, 0.4) if spread(16, 27).tick
    end
    sleep 0.5
  end
end

define :hats do
  (barLength * 4).times do
    with_fx :hpf, cutoff: 90 do
      with_synth :noise do
        with_swing (line 0.01, 0.05, steps: 8).tick do
          play :c5, release: 0.02, amp: rrand(0.6, 0.7) if spread(9, 13).look
        end
      end
    end
    sleep 0.25
  end
end

define :beats2 do
  s = :loop_breakbeat
  pattern = (ring 1,0,0,0, 2,0,0,1, 1,0,1,0, 3,0,0,1).repeat(7) + (ring 1,1,0,0, 1,0,0,2, 2,0,1,0, 3,0,0,0)
  
  with_fx :eq, low_note: 60, low: -0.8 do
    (barLength * 4).times do ; tick
      with_swing (line 0.01, 0.05, steps: 8).look do
        sample s, slice: 0, num_slices: 32, amp: rrand(2, 2.1) if pattern.look == 1
        sample s, slice: 8, num_slices: 32, amp: rrand(2, 2.1) if pattern.look == 2
        sample s, slice: 8, num_slices: 32, amp: rrand(2, 2.1), rate: 0.95 if pattern.look == 3
      end
      
      sleep 0.25
    end
  end
end

define :squelch do
  (barLength).times do
    with_synth :supersaw do
      play:c4, amp: rrand(0.2, 0.3) if bools(1,0,1,0, 1,1,1,0).tick
    end
    sleep 1
  end
end

define :bass do
  notes = [:C2, :Bb2, :F2, :D2, :A2, :G2, :Eb2, :G2, :C3, :G2, :Bb2, :D2, :D2, :F2, :C2, :Eb2,
           :C2, :D2, :G2, :C2, :D2, :A2, :D2, :Bb2, :C3, :D2, :G2, :F2, :F2, :Eb2, :D2, :C3].ring
  (barLength).times do
    with_swing (line -0.01, 0.05, steps: 4).tick do
      with_synth :fm do
        play notes.look+12, release: 0.5, amp: rrand(0.4, 0.5)
      end
    end
    sleep (ring 0.5, 0.5, 2, 1).look
  end
end

define :lead do
  notes1 = [:C4, :D4, :F4, :A4, :D4, :G4, :Bb4, :Bb4, :Bb4, :C4, :A4, :Bb4, :D4, :Bb4, :Bb4, :C4,
            :G4, :A4, :D4, :F4, :G4, :G4, :D4, :Bb4, :Bb4, :D4, :C4, :C4, :F4, :D4, :F4, :G4, :Eb4].ring
  notes2 = [:Bb4, :Eb4, :A4, :C4, :G4, :C6, :A4, :Eb4, :Bb4, :C5, :C5, :C5, :G4, :Bb5, :A4, :Eb4,
            :A4, :C4, :Eb4, :Eb5, :C6, :Eb4, :G4, :D5, :A4, :C5, :A4, :C6, :G4, :A4, :C5, :G4, :Eb5].ring
  sleeps = (ring 0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 0.5, 0.5, 0.75, 0.75, 0.75, 0.75, 1, 1, 1, 3).reverse.mirror
  idx = get[:leadCounter]
  
  (barLength+14).times do
    idx += 1
    with_swing (line -0.01, 0.05, steps: 8).tick do
      #with_synth :pulse do
      with_synth :fm do
        with_fx :hpf, cutoff: 70 do
          play notes1.look, release: sleeps.look, amp: (line 0.35, 0.1, steps: 256)[idx]
        end
      end
      #with_synth :blade do
      with_synth :dsaw do
        play notes2.look, release: (sleeps.tick + (line 0, 4, steps: 256)[idx]), amp: (line 0.2, 0.3, steps: 256)[idx] # second tick
      end
    end
    sleep sleeps.look
    set :leadCounter, idx
  end
end

define :endingChords do
  (barLength / 8).times do
    with_synth :blade do
      play (chord_degree (ring 1,2,1,3).tick, :c3, scaleName, 4), amp: rrand(0.5, 0.6), sustain: 3, release: 6
    end
    sleep 8
  end
end

define :chords do
  (barLength / 8).times do
    with_fx :wobble, phase: (ring 4, 2, 3, 1).tick do
      with_synth :chiplead do
        play (chord_degree (ring 1,2,1,3).look, [:c4, :c5].choose, scaleName, 4), amp: 0.15, sustain: 2, release: 4
        play (chord_degree (ring 1,2,1,3).look, [:c3, :c4].choose, scaleName, 4), amp: 0.15, sustain: 2, release: 4
      end
    end
    sleep 8
  end
end

define :tabla do
  s = (ring "tabla_dhec.flac", "tabla_na.flac", "tabla_na_o.flac", "tabla_na_s.flac", "tabla_re.flac",
       "tabla_tas1.flac", "tabla_tas2.flac", "tabla_tas3.flac", "tabla_te_m.flac", "tabla_te2.flac").shuffle
  
  (barLength * 4).times do
    with_swing rrand(-0.03, 0.03) do
      sample s[tick], amp: rrand(0.2, 0.3) if spread(12, 37).tick # second tick
    end
    
    sleep 0.25
  end
end

# Reset globals
set :leadCounter, 1

# Structure
with_fx :level, amp: 2 do
  in_thread do ; beats ; end ; in_thread do ; hats ; end ; in_thread do ; squelch ; end ; bar
  
  in_thread do ; hats ; end ; in_thread do ; bass ; end ; in_thread do ; endingChords ; end ; bar
  
  in_thread do ; beats ; end ; in_thread do ; hats ; end ; in_thread do ; squelch ; end ; in_thread do ; bass ; end ; bar
  
  in_thread do ; beats ; end ; in_thread do ; beats2 ; end ; in_thread do ; hats ; end ; in_thread do ; squelch ; end ; in_thread do ; bass ; end ; in_thread do ; chords ; end ; bar
  
  2.times do
    in_thread do ; beats ; end ; in_thread do ; beats2 ; end ; in_thread do ; hats ; end ; in_thread do ; squelch ; end ; in_thread do ; bass ; end
    in_thread do ; chords ; end ; in_thread do ; endingChords ; end ; in_thread do ; lead ; end
    bar
  end
  
  2.times do
    in_thread do ; beats ; end ; in_thread do ; beats2 ; end ; in_thread do ; hats ; end ; in_thread do ; squelch ; end ; in_thread do ; bass ; end
    in_thread do ; chords ; end ; in_thread do ; lead ; end ; in_thread do ; tabla ; end
    bar
  end
  
  in_thread do ; bass ; end ; in_thread do ; chords ; end ; in_thread do ; lead ; end ; bar
  
  in_thread do ; chords ; end ; in_thread do ; lead ; end ; bar
  
  2.times do
    in_thread do ; beats ; end ; in_thread do ; beats2 ; end ; in_thread do ; hats ; end ; in_thread do ; squelch ; end ; in_thread do ; bass ; end ; in_thread do ; endingChords ; end ; bar
  end
  
  #repeat chorus?
end