def test(folder_path, filename, expected)
  tif_path = File.join(folder_path, filename)
  filename = File.basename(filename, '.tif')
  normalized_path = File.join(folder_path, 'normalized_' + filename + '.png')

  if expected.size < 107
    expected = expected + 'Z'*(107-expected.size)
  end

  parameters = '0.4 60 540 80 40 1284 4847 1 0 7 0123456789 79 38 271 540 964 453 2 600 50 ABCDE 77 38 170 1054 473 3454'
   
  result = `../bin/run #{tif_path} #{normalized_path} #{parameters}`
  if result == expected
    p '=> Success!'
  else
    p '=> Error in file -> ' + tif_path
    p 'Result: ' + result
    p 'Expected: ' + expected
  end
end

p 'Testing files'
`ruby ../compile.rb`

folder_path = '/home/charlie/Desktop/card_processor_stuff/quick_test' 

test folder_path, '11012013180610.tif', '0047315BBCEDDEEBABEEECEDDBBAEABEACCDEDBBABCECEB'
test folder_path, '11012013180612.tif', '004Z312BBBACCBCDBBCEEABDDEBBACCCECDDEBABCEAECDA'
test folder_path, '11012013182145.tif', '0047299CBEBDECDABCDBEEDDACB'
test folder_path, '11012013182330.tif', '1016961ADEBEBBDACCDBEDDCECC'
test folder_path, '11012013182332.tif', '004W440ABWADDBBDDCEBEBDAEAA'
test folder_path, '11012013182334.tif', '0046443BDBCDCAECBDADBBCCDCD'
test folder_path, '11012013182336.tif', '0047101BBBCACCEEBCEBEECCEED'

test folder_path, '11012013174505.tif', 'ZZZZZZZABECCEEEDAADAECEBCEEAEADEBAAADDBECEEEEDE'
test folder_path, '11012013175133.tif', '1022824CBCBEBAEBADDEEDCACEEBABAEAEBDECEEEDADCDB' 
test folder_path, '11012013175139.tif', '1022823BBCABBAEDECDEBBDEEECAABBBEBCDABABADEDDDA'  
test folder_path, '11012013180225.tif', '0046715EDCADEDABACDEDCDDABCAACAAEAACACBBABBECEE' 

folder_path = '/home/charlie/Desktop/samples_tif'

test folder_path, 'sample1.tif', '0246864AEBDCBDAEDEEEBEEWEEBEEDEEEBEED'
test folder_path, 'sample2.tif', '0001234ABCZEZWCZBDEEEDCBBCDCZBCZBDAEC'
test folder_path, 'sample3.tif', '166Z921BCDEBABACAAZZZZBZZEZZBCCCCWCDE'
test folder_path, 'sample4.tif', 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'
