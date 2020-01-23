#slidey synth

slider = 0.25

# D
one_start = :d3
one_end = :d4
three_start = :fs5
three_end = :fs4
five_start = :a3
five_end = :a4

# Dm
##| one_start = :d3
##| one_end = :d4
##| three_start = :f3
##| three_end = :f4
##| five_start = :a3
##| five_end = :a4

# A
##| one_start = :a3
##| one_end = :a4
##| three_start = :cs5
##| three_end = :cs4
##| five_start = :e6
##| five_end = :e4


live_loop :slidey do
  
  one = synth :fm,  note: one_start, note_slide: slider
  control one, note: one_end
  three = synth :fm,  note: three_start, note_slide: slider
  control three, note: three_end
  five = synth :fm,  note: five_start, note_slide: slider
  control five, note: five_end
  sleep 1
end
