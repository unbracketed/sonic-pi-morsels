#Microtonal Pads
#Coded by Davids Fiddle

#A microtonal scale
sc = (ring 1,2,3,5,7,
      0.5,1.5,2.5,3.5,
      1/3.0,2/3.0,5/3.0,7/3.0,
      1/5.0,2/5.0,3/5.0,7/5.0,
      1/7.0,2/7.0,3/7.0,5/7.0
      ).sort

live_loop :pads do
  sync :tick
  tick
  use_synth :tri
  use_synth_defaults sustain: 4, attack: 1, release: 1.5,
    amp: 0.3, divisor: (line 2,4).choose
  play hz_to_midi(sc.choose * 440), pan: (line -0.3,0.3).choose
  play hz_to_midi(sc.choose * 440), pan: (line -0.3,0.3).choose
  play hz_to_midi(sc.choose * 440), pan: (line -0.3,0.3).choose
  play hz_to_midi(sc.choose * 440), pan: (line -0.3,0.3).choose
  sleep 5.8
end

live_loop :beat do
  with_bpm 85 do
    tick
    sample :bd_klub, amp: (ring 1,0.8).look if (ring 1,1,0,0,0,0,0,0).look == 1
    sleep 0.25
  end
end

live_loop :tick do
  #sample :elec_plip, amp: (line 0,1).choose
  sleep 0.25
end