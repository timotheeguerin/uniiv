require 'diff/lcs'

seq1 = %w(a b c e h j l m n p)
seq2 = %w(b c d e f j k l m r s t)

lcs = Diff::LCS.diff(seq1, seq2)

puts lcs