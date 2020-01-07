use_bpm 120
use_random_seed 667766
set_volume! 5

drum_seeds = (ring 666,222,333,666,555,666)

automatic=1
manual=0

drum_control=automatic

define :set_drum_seed   do |i|
  set :drum_seeds, i
end

live_loop :drums do
  
  use_random_seed get :drum_seeds
  g=get :drum_seeds
  puts g
  8.times do
    cue :drummer # in case you want something to synce off
    sample :bd_haus, amp: 0.5 if one_in(3)
    sample :sn_dolf, amp: 0.5 if one_in(5)
    sample :drum_cymbal_closed, amp: 0.25
    sleep 0.5
  end
end

live_loop :drum_controller do
  if drum_control == automatic then
    sleep 1
    set :drum_seeds, drum_seeds.tick
    sleep 7
  else
    sleep 1
  end
end

# Title: Perhilion (W.I.P)
# Artist: Paul 'Just Eli...' Whitfield
# Date:
#
# Sonic Pi v3.1
# Eli's Framework v1.0

use_bpm 120
use_random_seed 667766
set_volume! 5

tracker = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
volume =  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

notes = (ring :a4, :d4, :c4, :a5)
time = (ring 2.0,2.0,1.0,2.0,)

notes1=(ring [:f5, :d4], [:a4], [:d5, :c4], [:c5], [:d5, :b3], [:a5], [:a4, :as3], [:g5])
time1 =(ring          2,     2,          1,     3,          1,     3,           1,     3)
mod =(ring 0,1,0,0,1,0,0,1,0,0,1,0,0)


key = scale(:a3, :minor_pentatonic, num_octaves: 5)

$notes1 = (ring :a3, :g3,:d3, :f3, :a3, :g3,:a3, :d3, :g3, :f3, :e3)
$sleeps1 = [0.5, 0.5, 0.5, 0.25, 0.5, 0.5, 0.5, 0.25,
            0.25, 0.5, 0.25, 0.5, 0.5, 0.5, 0.25, 0.25,
            0.25, 0.5, 0.25, 0.25, 0.75, 0.5, 0.25, 0.25,
            0.5, 0.25, 0.25, 0.5, 0.5, 0.25, 0.5, 0.75,
            0.5, 0.5, 0.25, 0.25, 0.5, 0.5, 0.25, 0.75,
            0.5, 0.5, 0.5, 0.25, 0.25, 0.5, 0.5, 0.25,
            0.5, 0.75, 0.5, 0.5, 0.5, 1.5, 0.25, 0.25,
            0.25, 1.25, 0.5, 0.5, 1.5, 0.5, 0.5, 0.5,
            0.25, 0.25, 0.5, 0.25, 0.25, 0.5].ring

$notes2 = (ring, :c2, :c3, :as2, :f3, :ds3)
$sleeps2 = (ring, 0.75, 0.5, 0.25, 0.75, 1, 0.5)

r=(ring 2,2,4)

drum_seeds = (ring 666,222,333,666,555,666)

drum_control=automatic

tick_reset_all

# Start a loop.
define :start_loop do |i|
  tracker[i] = 1
end

# Stop a loop.
define :stop_loop do |i|
  tracker[i] = 0
end

# Stop all loops.
define :stop_all do
  (0..12).each do |i|
    tracker[i] = 0
  end
end

# Repeat loop 'n' times
define :repeat_loop do |i,n|
  tracker[i] = n
end

# One-shot loop
define :oneshot_loop do |i|
  tracker[i] = 1
end

# Reduce loop's volume
define :decrease_volume  do |i, n |
  volume[i] = volume[i] - n if volume[i] - n >= 10
end

# Increase loop's volume
define :increase_volume  do |i, n |
  volume[i] = volume[i] + n if volume[i] + n <= 10
end

# Reduce loop's volume
define :reset_volume  do |i|
  volume[i] = 0
end

# Increase loop's volume
define :set_volume  do |i, n |
  volume[i] = n if n <= 10
end

define :set_drum_seed   do |i|
  set :drum_seeds, i
end


live_loop :drums do
  
  use_random_seed get :drum_seeds
  g=get :drum_seeds
  puts g
  if tracker[0]>0 then
    8.times do
      cue :drummer
      sample :bd_haus, amp: volume[0]*0.5 if one_in(3)
      sample :sn_dolf, amp: volume[0]*0.5 if one_in(5)
      sample :drum_cymbal_closed, amp: volume[0]*0.25
      sleep 0.5
    end
    
  else
    sleep 0.75
  end
end

live_loop :drum_controller do
  if drum_control == 1 then
    sleep 1
    set :drum_seeds, drum_seeds.tick
    sleep 7
  else
    sleep 1
  end
end


with_fx :rhpf, res: 0.85, cutoff: 118, amp: 0.25 do
  live_loop :hats  do
    sync :bar
    if tracker[2]>0 then
      synth :chipnoise, sustain: 0, release: 0.09, freq_band: 15,amp: volume[2]*0.0625
      sleep 0.5
      if rand(1) < 0.5 then
        synth :chipnoise, sustain: 0, release: 0.09, freq_band: 15,amp: volume[2]*0.125
      else
        sleep 0.5
      end
    else
      sleep 0.75
    end
  end
end

with_fx :flanger do
  with_fx :reverb do
    
    live_loop :background do
      if tracker[3]>0 then
        sync :drums
        with_synth_defaults amp: volume[3]* 0.5, attack: 0.0, release: 3.5 do
          use_synth :fm
          play (chord [:c4, :eb, :g4].choose, :M7)
          sleep 4
          if one_in(4) then
            play (chord :c4, :M7)
          else
            play (chord :d4, :M7)
          end
        end
        
      end
      sleep 0.75
    end
    
  end
end

with_fx :reverb, room: 0.8 do
  with_fx :lpf, cutoff: (range 75,65,5).mirror.tick do
    
    with_fx :level, amp: 0.5 do
      cue :drummer
      
      live_loop :piano do
        if tracker[4]>0 then
          use_synth :piano
          
          if mod.tick == 1 then
            play_chord notes1.look, amp: volume[4]*0.5, release: 4, sustain: 4
          else
            play_chord notes1.look,  amp: volume[4]*0.5, release: 1, sustain: 1
          end
          sleep time1.look
        else
          sleep 2
        end
      end
      
    end
    
  end
end


live_loop :beats do
  sleep 1
end

live_loop :bar do
  sync :beats
  sleep 4
end

live_loop :bar8 do
  sync :beats
  sleep 8
end

live_loop :loopy do
  cue :loop
  sleep 1
end

drums = 0
hats = 2
background = 3
piano = 4

set_volume drums, 1
start_loop drums
set_volume hats, 2
set_volume background, 1
start_loop background
sleep 32
stop_loop background
start_loop hats
sleep 16
set_volume background, 1
start_loop background
sleep 16
stop_loop background
stop_loop hats
stop_loop drums

