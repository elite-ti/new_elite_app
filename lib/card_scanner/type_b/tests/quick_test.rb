# encoding: UTF-8
require 'find'

def test(folder_path, filename, expected)
  tif_path = File.join(folder_path, filename)
  filename = File.basename(filename, '.tif')
  normalized_path = File.join(folder_path, 'normalized_' + filename + '.png')

  if expected.size < 107
    expected = expected + 'Z'*(107-expected.size)
  end

  parameters = '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3464'
  errors = []
   
  result = `../bin/run '#{tif_path}' '#{normalized_path}' #{parameters}`
  if result == expected
    print '.'
  else
    print 'F'
    errors << [
      'File:     ' + tif_path,
      'Result:   ' + result,
      'Expected: ' + expected,
    ]
  end

  errors.each do |error|
    2.times { print "\n" }
    print error[0] + "\n"
    print error[1] + "\n"
    print error[2] + "\n"
  end
end

print "=> Testing files\n"
`ruby ../compile.rb`

# folder_path = '/home/charlie/Desktop/card_processor_stuff/quick_test' 

# test folder_path, '11012013180610.tif', '0047315BBCEDDEEBABEEECEDDBBAEABEACCDEDBBABCECEB'
# test folder_path, '11012013180612.tif', '004Z312BBBACCBCDBBCEEABDDEBBACCCECDDEBABCEAECDA'
# test folder_path, '11012013182145.tif', '0047299CBEBDECDABCDBEEDDACB'
# test folder_path, '11012013182330.tif', '1016961ADEBEBBDACCDBEDDCECC'
# test folder_path, '11012013182332.tif', '004W440ABWADDBBDDCEBEBDAEAA'
# test folder_path, '11012013182334.tif', '0046443BDBCDCAECBDADBBCCDCD'
# test folder_path, '11012013182336.tif', '0047101BBBCACCEEBCEBEECCEED'

# test folder_path, '11012013174505.tif', 'ZZZZZZZABECCEEEDAADAECEBCEEAEADEBAAADDBECEEEEDE'
# test folder_path, '11012013175133.tif', '1022824CBCBEBAEBADDEEDCACEEBABAEAEBDECEEEDADCDB' 
# test folder_path, '11012013175139.tif', '1022823BBCABBAEDECDEBBDEEECAABBBEBCDABABADEDDDA'  
# test folder_path, '11012013180225.tif', '0046715EDCADEDABACDEDCDDABCAACAAEAACACBBABBECEE' 

# folder_path = '/home/charlie/Desktop/card_processor_stuff/bugged_files' 

# test folder_path, '11012013174904.tif', ''
# test folder_path, '11012013174906.tif', ''
# test folder_path, '11012013174908.tif', ''
# test folder_path, '11012013174910_001.tif', ''
# test folder_path, '11012013174912.tif', ''
# test folder_path, '11012013174914.tif', ''
# test folder_path, '11012013174916.tif', ''
# test folder_path, '11012013174918.tif', ''

folder_path = '/home/charlie/Desktop/cards_by_campus/' 
Find.find(folder_path) do |path|
  next if File.extname(path) != '.tif'

  test File.dirname(path), File.basename(path), ''
end

# test '/home/charlie/Desktop/', '1° Ano Militar23022013161139_003.tif', ''

