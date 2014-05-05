# encoding: UTF-8

require 'find'

this_path = File.dirname(File.expand_path(__FILE__))

# parameters = '0.4 60 540 80 40 2900 4229 2 1245 6 0123456789 79 38 304 795 1003 300 2 705 50 ABCDE 77 38 846 1185 486 2659'
parameters = '0.4 60 540 80 40 2900 4229 1 0 6 0123456789 79 38 304 795 1003 300 2 685 50 ABCDE 77 38 846 1185 486 2659 1 0 5 0123456789 79 38 1528 809 978 250'
folder_path = '/Users/pauloacmelo/Downloads/CardsC/' # TOFILL
# folder_path = '/Users/pauloacmelo/Downloads/Teste5/' # TOFILL
file_to_be_processed_format = '.tif'

  def is_valid_result(result)
  result.split('').uniq.each do |c|
    unless %w[A B C D E W Z 0 1 2 3 4 5 6 7 8 9].include? c
      return false
    end
  end
  true
end

print "=> Compiling card scanner\n"
p "ruby '#{this_path}/../compile.rb'"
`ruby '#{this_path}/../compile.rb'`

print "=> Removing old files\n"
`find '#{folder_path}' -name '*.png' -exec rm '{}' \\;`

print "=> Converting to tif\n"
`find '#{folder_path}' -name '*.tif' -exec convert '{}' '{}' \\;`

print "=> Scanning cards\n"
lines = []

should_be_answers = {
  230003 => "CECDABCBDEDAEEBDCCABDDBEDAEADCABDCDEDBAABCABCBCECAADEWAEEECECABCECDCZAABADBEDDACBEBBCAEACDZZZZZZZZZZ",
  230000 => "ABCDADADCECBECBACCABADBBDCEDADACEAEABEDCACCADDDAADBBEACEAEAEACAADDAEAECAACEADDBDBAACDCABEBZZZZZZZZZZ",
  230005 => "AECDECBEAEDBECAAEEADADECDCECABAAECECCEAEAABCECCECEBABCDCEAEDBAEEDACEDEACCDCAACDEDBACDDCAADZZZZZZZZZZ",
  228870 => "AECDEABDDDCBEDDBDCCBCDEDDCECACACBDCCBBCEACADDDDEABBDBACBADCCABBBDEBACEEBACAEAACDCBCDADABEDZZZZZZZZZZ",
  228948 => "EEDDABBACCCDEBAACDBDACEACAABBDDEABCDAEECDBACBDDEAZADDEBBACEBACDEEAACADECBBADBCAEDDCAABEDDCZZZZZZZZZZ",
  229881 => "AECDCBBDDECBCBAACCADADBEDCECADAEECDEBBDAEEEECDDEABEDBACCAEEBECABDDCEEDEBEACEAABBDBCBAEAAAEZZZZZZZZZZ",
  229975 => "AECBEEBDDCDBCCABCDBDZEBBDCEADAABDCAEDEACECDDEDEBACDDBBBACDADECBBDDDADDEBACDDEAAEDACCADAABEZZZZZZZZZZ",
  229980 => "EECDEEAADBABCCAAECADADCBDAEBABACECDBEBDCDCBAEDDEABCBBBDBCBDEAEDEDBCABECDCDDEECABDBCCEEAABCZZZZZZZZZZ",
  229982 => "CEBDEBBDDBDBECEBACACCDBDDAECDCAEDDDBBBCAECAECZZZZZCABBCBAAEEECDEBACDDEEBABDADBEEDDBACEABACZZZZZZZZZZ",
  229931 => "AEBDEBADDADBCDCBDCADACAEDDECABAEDCAEBEDAECACCDCEAEDBBABBCDABEABABEAAABBBAEDAABDBDDEBCDABEBZZZZZZZZZZ",
  229969 => "AEADEABEDCDBECACDCABCDEBDCECECCCEABDAAABECADCDCBCCCBBEBACDCDEBECABBDCBDAADCEABECEBACDDBABDZZZZZZZZZZ",
  228935 => "EEBAACADEECBACBBECACACACDCECBDAEEEDABEDEEEADCDDEAEEDBDCEDEDDBEABBDAEDDBBAADEAAACCBCCBBAABDZZZZZZZZZZ",
  228849 => "ADBEAEBEBBDACBABECADCAEBDCEDDBABBACDDDDDDCAEDDDDEBDCBBADADDDEEABEDCEDDEBAADACACBDBCCABAAECZZZZZZZZZZ",
  228855 => "EEAEEBBEDBDDBCAABAADEDBBDCEDACACBEACCBDCAECABCCEEDDACBEDADEAECAEDDBDEEDEDDEDEBDDCDDZEDCADDZZZZZZZZZZ",
  228892 => "EECAEABBDECDEACCCCACCDBCDDECACAEDBDEBBDAAEAEADDBABCABACAACCBACEBBDCEDDEBBAEAECABDCADADAABEZZZZZZZZZZ",
  228946 => "DEBDEBAECCBBEEECCCABCDADDCEDEBAEDBEBDEDCEDAACDCEEADECDCDDEAECEDBCDDADEEBECDEDECCBBCCAABBDCZZZZZZZZZZ",
  229176 => "AEEDAEADDBDBCAECBAACCABBDAEBEAADCECBBCDADEEBCDCBAAEBEAEEDCBABDABDCADACDEAEBABDACADCBDEADCCZZZZZZZZZZ",
  229176 => "AEEDAEADDBDBCAECBAACCABBDAEBEAADCECBBCDADEEBCDCBAAEBEAEEDCBABDABDCADACDEAEBABDACADCBDEADCCZZZZZZZZZZ",
  222396 => "AEACECABCAABAABBEBCEZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ",
  229238 => "ACEDABBADBCBECBAECADACBCDABEACAEDCABBCAEBCADBDDEAEDDBEBADDBAACDEBDCADDCBBEDADCCDABCBCDAABCZZZZZZZZZZ",
  229200 => "EECBECAADCADBACCEEAEABBDDACBCAAEDBEACBAEDBADCAECCCBDBAEBBDCAECADBECCBAEDDAAEDABBEDAECBAAEEZZZZZZZZZZ",
  229169 => "CECDBBBCACEBEDBCBBAEDDBCDCECACADDACCACDBECADBDDDABBBDDCDCCABCAABADAEBCBDABCADBECADAEACBDEAZZZZZZZZZZ",
  229171 => "CCDDECABDBCAEDBCEEACAABDDADCDCABEDDAEEAECCADBDDCACBAEAEBBCECCEAEBBDDAEDDDACABABBBECACBAAEEZZZZZZZZZZ",
  214881 => "AEACCEBDBCCCBCAEBDBBDBDEBBAAABCCAECCDCCECEDCECBBADAAACEBACEABEBACDECDDECAABBEDADCEDCACDCBCZZZZZZZZZZ",
  215080 => "BBACABEBACBDAEEDBBBCBABDDCDDCCAAAEADEAACAADDEBBBCDEBDDEBECABEACBCEDCEEDCCCCDDAAACEBABCCEEBZZZZZZZZZZ"
}

debug = true
Find.find(folder_path) do |file_path|
  next if File.extname(file_path) != file_to_be_processed_format
  id = File.basename(file_path, ".tif").to_i
  next if debug && ![215080, 214881, 228870, 228855, 229931, 230000, 230003].include?(id)

  normalized_path = File.join(File.dirname(file_path), 
    File.basename(file_path, file_to_be_processed_format) + '_normalized.png')

  result = `'#{this_path}/../bin/run' '#{file_path}' '#{normalized_path}' #{parameters}`
  # p result if debug
  result = result.split("\n")[-1][11..110]

  if result == should_be_answers[id]
    p "#{id}: OK!"
  else
    p "#{id}: Error (#{result})"
    p "#{id}: Error (#{should_be_answers[id]})"
  end
end
