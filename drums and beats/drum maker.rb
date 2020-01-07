#Drum Maker
#Coded by Davids Fiddle
#v0.8


define :cymbal do
  source = 4  #Select the noise source.
  dec = 0.1  #Decay time
  rel = 0.3  #Release time, slightly randomised
  res = 0.9  #Resonance of the lpf
  cut1 = 120  #Initial pitch of the cutoff
  cut2 = 2  #Amount of cutoff fall
  fall = 0.2  #Time for the cutoff fall
  bounce = 0.3  #Level between decay and release.
  with_fx :rlpf,cutoff: cut1, cutoff_slide: fall, res: res do |f0|
    synth (ring :noise,:gnoise,:bnoise,:pnoise,:cnoise)[source],
      decay: dec, sustain_level: bounce, sustain: 0, release: (line rel,rel * 1.5).choose
    control f0, cutoff: cut1 - cut2
  end
end

define :drum do
  #Control values:
  wave = 1  #Select the wave type
  cut = 90  #Cutoff pitch for the lpf. 40-60 for kick, 60-100 for snare & toms.
  pitch = 45  #Initial pitch of the drum. 40-60 for all drums.
  tension = 4 #Amount of pitch fall. 20-40 for kick, <10 for snare & toms.
  fall = 0.05  #Time for the pitch fall. Should be the same as decay.
  dec = 0.1  #Decay time
  rel = 0.1 #Release time
  bounce = 0.8  #Level between decay and release.
  wire = 0.8  #0-1, amount of noise. 0 makes it a kick / tom.
  with_fx :rlpf, cutoff: cut, res: 0.55 do
    synth (ring :sine, :tri, :saw, :square, :fm)[wave],
      note: pitch, release: rel, decay: dec, slide: fall,
      sustain_level: bounce
    control note: pitch - tension
    synth :bnoise, release: rel, amp: wire
  end
end

live_loop :test do
  tick
  drum
  sleep 1
  cymbal
  sleep 1
end