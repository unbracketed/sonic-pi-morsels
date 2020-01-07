# https://github.com/DavidsFiddle/Sonic-Pi-Code-Bits/blob/master/Presets/String%20Pad
define :string_pad do |note|
  use_merged_synth_defaults attack: 0.2, vibrato_delay: 1,
    vibrato_rate: 6
  with_fx :compressor do
    with_fx :reverb do
      synth :blade, note: note
      synth :blade, note: note + 0.005
      synth :blade, note: note - 0.005
      synth :blade, note: note + 7, amp: 0.5
      synth :blade, note: note + 12, amp: 0.6
      synth :blade, note: note + 24, amp: 0.2
    end
    use_merged_synth_defaults attack: 0.1,
      vibrato_depth: 0.1, vibrato_delay: 4, vibrato_rate: 1
    synth :blade, note: note - 12, amp: 0.5
    synth :blade, note: note - 11.995, amp: 0.5
    synth :blade, note: note - 12.005, amp: 0.5
  end
end

string_pad :c4
sleep 1
string_pad :e4
sleep 1
string_pad :g4