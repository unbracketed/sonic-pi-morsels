use_bpm 90

define :pattern do |pattern, name|
  return pattern.ring.tick(name) == "x"
end

snare_hit = "----x---".ring
kick_hit =  "x---x---x---x---".ring

live_loop :cues do
  cue :kick if pattern kick_hit, :kicktick
  cue :snare if pattern snare_hit, :snaretick
  sleep 0.25
end

live_loop :kicks do
  sync :kick
  sample :bd_haus
end

live_loop :snares do
  sync :snare
  sample :sn_generic
end