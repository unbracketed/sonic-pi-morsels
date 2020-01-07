$easing = { # Derived from: https://github.com/danro/jquery-easing/blob/master/jquery.easing.js
            linear: -> (t, b, c, d) { c * t / d + b },
            in_quad: -> (t, b, c, d) { c * (t/=d)*t + b },
            out_quad: -> (t, b, c, d) { -c * (t/=d)*(t-2) + b },
            quad: -> (t, b, c, d) { ((t/=d/2) < 1) ? c/2*t*t + b : -c/2 * ((t-=1)*(t-2) - 1) + b },
            in_cubic: -> (t, b, c, d) { c * (t/=d)*t*t + b },
            out_cubic: -> (t, b, c, d) { c * ((t=t/d-1)*t*t + 1) + b },
            cubic: -> (t, b, c, d) { ((t/=d/2) < 1) ? c/2*t*t*t + b : c/2*((t-=2)*t*t + 2) + b },
            in_quart: -> (t, b, c, d) { c * (t/=d)*t*t*t + b },
            out_quart: -> (t, b, c, d) { -c * ((t=t/d-1)*t*t*t - 1) + b },
            quart: -> (t, b, c, d) { ((t/=d/2) < 1) ? c/2*t*t*t*t + b : -c/2 * ((t-=2)*t*t*t - 2) + b },
            in_quint: -> (t, b, c, d) { c * (t/=d)*t*t*t*t + b},
            out_quint: -> (t, b, c, d) { c * ((t=t/d-1)*t*t*t*t + 1) + b },
            quint: -> (t, b, c, d) { ((t/=d/2) < 1) ? c/2*t*t*t*t*t + b : c/2*((t-=2)*t*t*t*t + 2) + b },
            in_sine: -> (t, b, c, d) { -c * Math.cos(t/d * (Math::PI/2)) + c + b },
            out_sine: -> (t, b, c, d) { c * Math.sin(t/d * (Math::PI/2)) + b},
            sine: -> (t, b, c, d) { -c/2 * (Math.cos(Math::PI*t/d) - 1) + b },
            in_expo: -> (t, b, c, d) { (t==0) ? b : c * (2 ** (10 * (t/d - 1))) + b},
            out_expo: -> (t, b, c, d) { (t==d) ? b+c : c * (-2**(-10 * t/d) + 1) + b },
            expo: -> (t, b, c, d) { t == 0 ? b : (t == d ? b + c : (((t /= d/2) < 1) ? (c/2) * 2**(10 * (t-1)) + b : ((c/2) * (-2**(-10 * t-=1) + 2) + b))) },
            in_circ: -> (t, b, c, d) { -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b },
            out_circ: -> (t, b, c, d) { c * Math.sqrt(1 - (t=t/d-1)*t) + b },
            circ: -> (t, b, c, d) { ((t/=d/2) < 1) ? -c/2 * (Math.sqrt(1 - t*t) - 1) + b : c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b }
            }

# Creates array for fading (or easing)
# Example: zfade :circ, 0, 1, 10
# For visual aid see: https://easings.net/
def zfade(func,start,finish,duration)
  (0..duration).map { |t| $easing[func].call(t.to_f,start.to_f,(start>0 ? finish-1 : start<0 ? finish+1 : finish).to_f, duration.to_f) }
end

expo = (zfade :expo,0,10,30).ring.mirror
sine = (zfade :cubic,0,30,100).ring.mirror
quint = (zfade :quint,0,20,40).ring.mirror

live_loop :beat do
  play 60+expo.tick
  play 30+sine.look
  play 70+quint.look, amp: 0.1
  sleep 0.05
end

