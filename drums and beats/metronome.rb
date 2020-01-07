#Metronome
#Coded by Davids Fiddle

#The BPM to use:
bpm = 120

#Every element in the list is an eighth note.
#2 is a strong beat, 1 is a normal beat, 0 is silence.
#Remove the # for the list you want.
#If multiple lines are enabled, the last one counts.
#beats = []
#beats = [2,0,0,0,1,0,0,0] #2/2
beats = [2,0,1,0] #2/4
#beats = [2,0,1,0,1,0,1,0] #4/4
#beats = [2,1,1,1,1,1,1,1] #8/8
#beats = [2,0,1,0,1,0] #3/4 Classical
#beats = [2,0,0,0,1,0] #3/4 Folk
#beats = [2,0,0,1,0,1,0] #7/8
#beats = [2,0,1,0,1,0,1,0,0] #9/8
#beats = [2,0,1,0,1,0,0,1,0,0] #10/8


live_loop :metronome do
  tick
  with_bpm bpm do
    sample :elec_plip, amp: 1, rate: 0.8 if beats.ring.look == 1
    sample :elec_plip, amp: 2 if beats.ring.look == 2
    sleep 0.5
  end
end