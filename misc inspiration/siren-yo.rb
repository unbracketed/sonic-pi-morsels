slider = 4
wails =(ring 2, 3)


live_loop :siren do
  sleep 8
  use_synth_defaults amp: 0.25
  siren = synth :fm,  note: :d6, note_slide: slider, sustain: slider * wails.look * 2
  wails.look.times do
    control siren, note: :d7
    sleep slider / 2
    control siren, note: :d6
    sleep slider
    control siren, amp: 0.5, note: :d7
    sleep slider
    control siren, amp: 0.5, note: :d6
    sleep slider
    control siren, amp: 0
    wails.tick
  end
end
