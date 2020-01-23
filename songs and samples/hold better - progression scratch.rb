# Hold Better - progression scratch
use_bpm 120
samples_dir = "/Users/brian/Dropbox/M_U_S_I_C/recording/Songs/Hold Better/export"

live_loop :notes do
  ##| play [:f3, :a3, :c4, :e4], amp: 0.5, release: 1.5
  ##| sleep 2
  ##| play [:a3, :c4, :e4, :g4], attack: 0.25, amp: 0.75
  ##| sleep 2
  ##| play [:f3, :a3, :c4, :e4], amp: 0.5, release: 1.5
  ##| sleep 2
  ##| play [:d3, :f3, :a4, :c4], release: 1.5
  ##| sleep 2
  
  
  # Fmaj7
  play [:f3, :a3, :c4, :e4], amp: 0.5, release: 1.5
  sleep 2
  # Am7
  play [:a3, :c4, :e4, :g4], attack: 0.25, amp: 0.75
  sleep 2
  # Fmaj7
  play [:f3, :a3, :c4, :e4], amp: 0.5, release: 1.5
  sleep 2
  
  # E
  play [:e3, :gs3, :b4, :e4], amp: 0.5, release: 1.5
  sleep 2
  
  
  
  
  # Dm7 first inv.
  play [ :f3, :a4, :c4, :d4], release: 1.5
  sleep 2
  #
  play [ :f3, :a4, :c4], release: 1.5
  sleep 2
  
  play [ :c4, :e3, :g3, :b4], release: 1.5
  sleep 2
end

