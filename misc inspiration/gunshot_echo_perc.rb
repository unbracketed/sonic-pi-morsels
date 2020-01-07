this_sample = :loop_breakbeat

use_sample_bpm this_sample

len = sample_duration this_sample
bar = len * 0.25
beats = len * 0.0625

live_loop :drummer do
  cue :loop
  cue :bar
  sample :drum_heavy_kick
  3.times do
    sleep bar
    cue :bar
  end
  sleep beats * 3
  sample :drum_heavy_kick
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
      sample this_sample, rate: speed
    end
  end
end
