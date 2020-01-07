use_bpm 130
use_debug false
define :tarai do |x,y,z|
  a=[:D4,:E4,:F4,:G4,:A4,:B4,:C5,:D5,:E5,:F5,:G5,:A5,:B5]
  2.times do
    puts x,y,z
    play_pattern_timed [a[x+1],a[x+1]+12,a[y+1],a[y+1]+12,a[z+1],a[z+1]+12,a[y+1],a[y+1]+12],0.25
  end
  n=n+1
  if(x<=y)
    return y
  else
    return tarai( tarai(x-1,y,z), tarai(y-1,z,x), tarai(z-1,x,y))
  end
end

tarai 10,5,0
