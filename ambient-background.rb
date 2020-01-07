# Title: 希望を失ったとき (Kibō o ushinatta toki) - When I Lost Hopes
# Artist: Mattia Giovanetti
# Date: 16/06/2019
#
# Sonic Pi v3.1

use_bpm 40
nota = [0,2,4,5,7,9,11,12]

define :voce_uno do
  use_synth :sine
  x = rand_i(8)
  y = nota[x] + 60
  play y, release: 0.75, pan: 0.333, amp: [0,0.25,0,0.5,0.75,0,1].choose
  sleep 0.25
end

define :voce_due do
  use_synth :sine
  x = rand_i(8)
  y = nota[x] + 48
  play y, release: 0.75, pan: 0, amp: [0,0.25,0,0.5,0.75,0,1].choose
  sleep 0.5
end

define :voce_tre do
  use_synth :sine
  x = rand_i(8)
  y = nota[x] + 36
  play y, release: 0.75, pan: -0.333, amp: [0,0.25,0,0.5,0.75,0,1].choose
  sleep 1
end

define :campane_casuali do
  sample :perc_bell, rpitch: [0.25,0.5,0.75,1,1.25,1.5,1.75,2,2.25,2.5,2.75,3].choose, amp: [0,0.25,0.5].choose
  sleep [0.125,0.25,0.333,0.5,0.666,0.75,1].choose
end

define :tempo_che_passa do
  sample :drum_snare_soft, rpitch: 27, amp: 0.75
  sleep 0.333
  sample :drum_snare_soft, rpitch: 28, amp: 0.7
  sleep 0.333
end


#forma
with_fx :level, amp: 0.25 do
  with_fx :reverb,mix: 0.5, damp: 0.5, room: 0.25 do
    with_fx :level, amp: 0, amp_slide: 75 do |lv|
      in_thread do
        186.times do
          tempo_che_passa
          control lv, amp: 1
        end
      end
    end
  end
  with_fx :reverb,mix: 0.5, damp: 0.5, room: 1 do
    in_thread do
      4.times do
        x = rand_i(8)
        3.times do
          campane_casuali
        end
        sleep 8
        x.times do
          campane_casuali
        end
        sleep 8
        x.times do
          campane_casuali
        end
        sleep 8
        3.times do
          campane_casuali
        end
      end
    end
    with_fx :echo, mix: 0.25, decay: 4 do
      in_thread do
        sleep 1
        x = 0.75
        6.times do
          sample :ambi_lunar_land, amp: x.abs
          sleep 16
          x = x - 0.25
        end
      end
      in_thread do
        sleep 2
        440.times do
          voce_uno
        end
      end
      in_thread do
        sleep 2
        220.times do
          voce_due
        end
      end
      in_thread do
        sleep 2
        110.times do
          voce_tre
        end
      end
    end
  end
end