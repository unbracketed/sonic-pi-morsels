use_debug false

bscale =  (scale :c2, :dorian, num_octaves: 4 )
roots = (knit 0, 4, 2, 4, 0, 4, 2, 4, 3, 2, 4, 2)
tscale = (scale :c3, :dorian, num_octaves: 4 )
fill = (knit false, 3, true, 1 )
start = (knit true, 1, false, 3)

reset_mixer!
set_mixer_control! limiter_bypass: 1

use_bpm 125

set :pingmode, 'off'
set :chordsmode, 'off'
set :chordfm, 'off'
set :drummode, 'off'
set :bassmode, 'off'
set :melomode, 'off'

live_loop :ping1 do
  sync :loop
  tick
  
  if get( :pingmode ) == 'on'
    
    if fill.look
      use_random_seed 2341
    else
      use_random_seed 13234
    end
    
    tsamples = [:tabla_ke1, :tabla_ke3, :tabla_ke2]
    
    with_fx :reverb, mix: 0.3 do
      
      16.times do
        sample tsamples.choose, amp: 0.5, pan: -0.7 if one_in(2)
        sample tsamples.choose, amp: 0.5, pan: 0.7 if one_in(2)
        sleep 0.2499
      end
    end
  end
end

live_loop :drums do
  sync :loop
  tick
  
  if get( :drummode ) == 'on'
    
    if start.look
      with_fx :rhpf, cutoff: 110, amp: 0.3 do
        with_fx :flanger do
          with_fx :echo, decay: 4 do
            sample :elec_cymbal
          end
          
        end
      end
    end
    
    at [ 0, 1.25, 1.5, 2, 2.75 ] do
      sample :bd_haus, amp: 1.5
    end
    
    at [1, 3] do
      sample :drum_snare_soft, amp: 2, pan: -0.3
    end
    
    if fill.look
      at [ 2.25, 3.75 ] do
        sample :drum_snare_soft, amp: 1.5, pan: -0.3
      end
    end
    
    at (range 0, 3.5, inclusive: true, step: 0.5) do
      sample :drum_cymbal_closed, pan: 0.7, amp: rrand( 0.7, 1.0)
    end
  end
end

live_loop :melo do
  sync :loop
  tick
  
  if get( :melomode ) == 'on'
    
    if start.look
      use_random_seed 6535
    end
    
    notes = tscale[roots.look],
      tscale[roots.look+2],
      tscale[roots.look+4],
      tscale[roots.look+6],
      tscale[roots.look+7];
    
    use_synth :fm
    use_synth_defaults divisor: 0.166666, depth: 12
    
    with_fx :reverb, mix: 0.5 do
      with_fx :panslicer do
        
        with_fx :rbpf, centre: 70, res: 0.3 do
          
          if fill.look == false
            play notes.choose, sustain: 2, pitch: 24
            sleep 3
            play notes.choose, sustain: 1, pitch: 24
          else
            play notes.choose, sustain: 1, pitch: 24
            sleep 1
            play notes.choose, sustain: 0.5, pitch: 24
            sleep 0.5
            play notes.choose, sustain: 0.5, pitch: 24
            sleep 0.5
            play notes.choose, sustain: 1, pitch: 24
            sleep 1
          end
        end
      end
    end
  end
end

live_loop :chords do
  sync :loop
  tick
  
  if get( :chordsmode ) == 'on'
    
    chordx = [ tscale[roots.look],
               tscale[roots.look+2],
               tscale[roots.look+4],
               tscale[roots.look+6] ]
    
    use_synth :dpulse
    use_synth_defaults amp: 0.5, cutoff: 30, pulse_width: 0.3, dpulse_width: 0.3
    play chordx, sustain: 4
    
    if get( :chordfm ) == 'on'
      
      with_fx :echo, phase: 0.5, decay: 6 do
        use_synth :fm
        use_synth_defaults pitch: 12, amp: 0.5, divisor: 0.25, depth: 10, sustain: 0, release: 0.3
        play chordx
      end
    end
  end
end

live_loop :bass do
  sync :loop
  use_synth :dsaw
  use_synth_defaults cutoff: 50, amp: 0.5
  tick
  
  if get( :bassmode ) == 'on'
    
    bassnote = bscale[roots.look]
    
    with_fx :eq, low_shelf: 1.2 do
      
      at [ 0, 1.5, 2 ] do
        play bassnote
      end
      
      if fill.look
        
        at 3 do
          play bassnote
        end
        
        at [ 3.5, 3.75 ], [0, 12] do |p|
          play bassnote, sustain: 0.25, release: 0.1, pitch: p
        end
        
      end
    end
  end
end

bar = 0

live_loop :timing do
  cue :loop
  print "bar: ", bar
  bar = bar + 1
  sleep 4
end

at 0 do
  set :pingmode, 'on'
end

at 15 do
  set :chordsmode, 'on'
end

at 47 do
  set :chordfm, 'on'
end

at 79 do
  set :drummode, 'on'
  set :bassmode, 'on'
  set :pingmode, 'off'
end

at 159  do
  set :chordsmode, 'off'
  set :melomode, 'on'
  set :pingmode, 'on'
end

at 239 do
  set :drummode, 'off'
  set :chordsmode, 'on'
end

at 255 do
  set :drummode, 'on'
  set :chordfm, 'on'
end

set_mixer_control! lpf_slide: 16
set_mixer_control! amp_slide: 2

at 400 do
  set_mixer_control! lpf: 0
end

at 425  do
  set_mixer_control! amp: 0
end