use_bpm 90

define :whistle do |notes, durs, slide=0.1|
  len = durs.reduce(:+)
  s = play notes[0], sustain: len, note_slide: slide
  sleep durs[0]
  notes.zip(durs)[1..-1].each do |n, d|
    control s, note: n
    sleep d
  end
end

use_synth :saw

whistle [:c6, :g6, :f6, :ds6, :d6, :ds6, :d6, :c6, :as5, :c6],
  [0.5, 0.5, 1, 0.5, 0.25, 0.25, 0.25, 0.25, 0.5, 1]
