# https://github.com/DavidsFiddle/Sonic-Pi-Code-Bits/blob/master/Presets/Pad%20Dirty
define :pad_dirty do |note|
  with_fx :compressor do
    synth :growl, note: note
    synth :growl, note: note + 7, amp: 0.5
    synth :growl, note: note + 12, amp: 0.4
  end
end

pad_dirty :c4
sleep 1
pad_dirty :e4
sleep 1
pad_dirty :g4