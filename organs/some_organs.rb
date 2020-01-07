define :organ_high do |note|
  use_merged_synth_defaults attack: 0.1
  with_fx :reverb, room: 0.7 do
    synth :tri, note: note, amp: 1
    synth :tri, note: note + 0.02, amp: 1
    synth :tri, note: note + 12.01, amp: 0.8
    synth :tri, note: note - 12, amp: 0.4
  end
  with_fx :reverb, room: 0.9 do
    synth :saw, note: note + 12, amp: 1
    synth :saw, note: note + 19, amp: 0.7
    synth :saw, note: note + 24, amp: 0.5
    synth :saw, note: note + 12.01, amp: 1
    synth :saw, note: note + 19.02, amp: 0.7
    synth :saw, note: note + 24.01, amp: 0.5
  end
  use_merged_synth_defaults attack: 0
  synth :tri, note: note + 12, amp: 0.8
  synth :tri, note: note + 12.02, amp: 0.8
end

define :organ_low do |note|
  use_merged_synth_defaults attack: 0.2
  with_fx :compressor do
    with_fx :reverb, room: 0.7 do
      synth :tri, note: note, amp: 1
      synth :tri, note: note + 0.02, amp: 1
      synth :tri, note: note + 0.01, amp: 0.8
      synth :tri, note: note, amp: 0.4
      synth :tri, note: note + 12, amp: 0.8
      synth :tri, note: note + 12.02, amp: 0.8
    end
    use_merged_synth_defaults attack: 0.1
    synth :sine, note: note, amp: 0.8
    synth :sine, note: note + 0.02, amp: 0.8
  end
end

organ_low :c4
organ_high :g4
sleep 1
organ_high :g4
organ_low :d5
