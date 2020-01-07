this_sample = :loop_breakbeat
use_sample_bpm this_sample
len = sample_duration this_sample
bar = len * 0.25
beats = len * 0.0625

live_loop :drummer do
  cue :loop
  cue :bar
  sample :drum_heavy_kick, amp: 2
  
  3.times do
    sleep bar
    cue :bar
  end
  
  sleep beats * 3
  sample :drum_heavy_kick, amp: 2
  sleep beats
end

live_loop :gunshot do
  # Alternate patterns
  # phase = [3,2,1,2].ring.tick
  phase = 3
  with_fx :echo, phase: beats * phase, decay: len, mix: 0.6 do
    # Change speed of gunshots
    # speed = [0.25, 0.5, 1, 1, 1, 0.5].ring.look
    speed = [0.25, 0.5, 1, 1, 1, 0.5].choose
    sync :loop
    if rand < 0.9 then
      sample this_sample, rate: speed, amp: 2
    end
  end
end

live_loop :pads do
  use_synth :prophet
  use_synth_defaults cutoff: rrand(70, 110), release: rrand(1, 4), amp: 0.4
  sleep 8
  
  (ring 4,3,2,1).look.times do
    play_chord chord(:D3, :minor)
    sleep 0.75
  end
  
  sleep 0.5
  play_chord chord(:D3, :minor ), attack: 4, release: 2
  sleep 2
end

with_fx :distortion, distort: 0.9 do
  live_loop :bass do
    sleep 16
    use_synth :tri
    
    32.times do
      play scale(:D1, :minor).choose, release: 0.25, amp: 0.5
      sleep (ring 1, 1, 0.5, 1.5).tick
    end
  end
end

# Below code by emyln
# https://in-thread.sonic-pi.net/t/simulating-a-telephone-in-sonic-pi/2212
#
# https://en.wikipedia.org/wiki/Dial_tone
# https://help.genesys.com/cic/mergedprojects/wh_ia/desktop/dial_tone,_busy_and_ringback_signals_by_country.htm
DIAL_TONES = {
  :uk => [350, 450],
  :us => [350, 440],
  :eu => [425],
  :jp => [400]
}

# http://dialabc.com/sound/dtmf.html
DTMF_TONES = {
  '1' => [697, 1209],
  '2' => [697, 1336],
  '3' => [697, 1477],
  '4' => [770, 1209],
  '5' => [770, 1336],
  '6' => [770, 1477],
  '7' => [852, 1209],
  '8' => [852, 1336],
  '9' => [852, 1477],
  '*' => [941, 1209],
  '0' => [941, 1336],
  '#' => [941, 1477],
  'A' => [697, 1477],
  'B' => [770, 1477],
  'C' => [852, 1477],
  'D' => [941, 1477],
}

# also
# http://www.telephonesuk.co.uk/sounds.htm

define :pulses do |freqs, periods|
  on = true
  periods.each do |t|
    if on
      freqs.each do |freq|
        synth :sine, note: hz_to_midi(freq), sustain: t, release: 0, amp: 0.1
      end
    end
    
    sleep t
    on = not(on)
  end
end

define :dialtone do |tone=:uk, periods=[2]|
  tone = DIAL_TONES[tone]
  pulses(tone, periods)
end

define :dtmf do |digit, length=0.25, pause=0.25|
  tone = DTMF_TONES[digit.to_s.upcase]
  pulses(tone, [length, pause]) if tone
end

define :ringring do |rings=1|
  pulses([400, 450], [0.5, 1, 0.5, 1] * rings)
end

define :phone do |number|
  with_fx :distortion, distort: 0.3, mix: 0.3 do
    noise = synth :pnoise, amp: 0.01, sustain: 15
    dialtone(:uk)
    number.split('').each do |n|
      dtmf(n)
    end
    sleep 1.5
    ringring(3)
    #control noise, amp: 0
  end
end

live_loop :call_the_police do
  phone '999'
end