# AKAI MPK mini MIDI receiver
#

live_loop :midi_piano do
  use_real_time
  note, velocity = sync "/midi/mpkmini2/1/1/note_on"
  set :midi_input_note_message, [note, velocity]
end



# Bank A
#---------------
# Pads
#------
#
# Notes
# 35 38 46 42
# 41 43 45 49
#
# CC - toggles velocity / 0
# 5  6  7  8
# 1  2  3  4
#
# PC
# 12 13 14 15
# 8  9  10 11
#----------------
# Bank B
#----------------
# Pads
#-------
#
# Notes
# 60 61 56 70
# 76 77 54 37
#
# CC
# 13 14 15 16
# 9  10 11 12
#
# PC
# 12 13 14 15
# 8  9  10 11
#
# ------------
# Rotaries
# 1 - 8