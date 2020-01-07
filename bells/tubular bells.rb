#Tubular Bells
use_bpm 135
use_tuning :just, :a
riff = (ring :a5,:e5,:b5,:e5,:g5,:a5,:e5,:c6,
        :e5,:d6,:e5,:b5,:c6,:e5,
        :a5,:e5,:b5,:e5,:g5,:a5,:e5,:c6,
        :e5,:d6,:e5,:b5,:c6,:e5,:b5,:e5)

with_fx :reverb, room: 1 do
  live_loop :tubular do
    tick
    use_synth :pretty_bell
    use_synth_defaults sustain: 0, release: 1.5
    play riff.look
    use_synth :piano
    #play riff.look
    #play riff.look - 12
    sleep 0.5
  end
end