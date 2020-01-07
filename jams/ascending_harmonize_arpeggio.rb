# harmonizing with chord tones
# https://www.reddit.com/r/musictheory/comments/dvaou1/what_are_the_best_intervals_to_harmonise_a_melody/f7bnv4b/

# harmonize down a third (or up a sixth) with C D E over E F G
#zplay 'i 2 v^7 3 i 4', chord_sleep: 0, harmonize: -3
# harmonize a third above with G A B  - A is a second over the G
#zplay 'i 2 v^7 3 i 4', chord_sleep: 0, harmonize: 3
# harmonize with chord tones G B C (fifth of C, third of G, tonic of C)
#zplay 'i 2 v^7 3 i 4', chord_sleep: 0, harmonize: {2=>3, 3=>4, 4=>4}
#z0 '3', harmonize: 'b5'


zplay '3', harmonize: '#3'
zplay '0', harmonize: '4', key: :f
zplay '0', harmonize: '4', key: :f, scale: :lydian

zplay '0', harmonize: 'b0'
zplay '0', harmonize: '0'
zplay '0', harmonize: '#0'
puts '==== 1 ==='
zplay '0', harmonize: 'b1'
zplay '0', harmonize: '1'
zplay '0', harmonize: '#1'
puts '==== 2 ==='
zplay '0', harmonize: 'b2'
zplay '0', harmonize: '2'
zplay '0', harmonize: '#2'
puts '==== 3 ==='

zplay '0', harmonize: 'b3'
zplay '0', harmonize: '3'
zplay '0', harmonize: '#3'
puts '==== 4 ==='

zplay '0', harmonize: 'b4'
zplay '0', harmonize: '4'
zplay '0', harmonize: '#4'
puts '==== 5 ==='

zplay '0', harmonize: 'b5'
zplay '0', harmonize: '5'
zplay '0', harmonize: '#5'
puts '==== 6 ==='

zplay '0', harmonize: 'b6'
zplay '0', harmonize: '6'
zplay '0', harmonize: '#6'
puts '==== 7 ==='

zplay '0', harmonize: 'b7'
zplay '0', harmonize: '7'
zplay '0', harmonize: '#7'
