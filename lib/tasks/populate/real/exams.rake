# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do
      task add_exams_23AUG: :environment do
        p 'Adding exams'
        datetime = 'Sun, 23 Aug 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - POR(20) + ING(20): DEEEBBDBCEBBCABEEBBA EEEBBEADCACBEEABCEEE",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + QUI(14) + FIS(7): DBEABADDDDDABCDBADEA ACDCBACBABCBAA DAEEACEBEC",
          "C - ESPCEX, 3ª Série + ESPCEX - All - POR(20) + QUI(14) + FIS(7): DBEABADDDDDABCDBADEA ACDCBACBABCBAA DAEEACEBEC",
          "C - 1ª Série Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): BCECBDCECBCBEDEEEEAD EDAAAA CABBEC DCCEAC CAAEEA CCAEEA",
          "U - 1ª Série Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): AAABABBCDCEDDEACCBEE ACEBBB EBEADB ACDACE ECBDAE ADECBE",
          "C - 9º Ano Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): BCECBDCECBCBEDEEEEAD EDAAAA CABBEC DCCEAC CBEDBA CCAEEA",
          "U - 9º Ano Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): EABDEAEBACECABACBACE CAECBC ADECBA ECAAEB AEACEC BAEBAC",
          "C - 2ª Série Militar - All - POR(10) + ING(10): CDBEEAAEEB ABEDCDDCED",
          "U - 2ª Série Militar - Madureira I - POR(10) + ING(10): ABECADCBAE ECACABCABA",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + ING(20): DEEEBBDBCEBBCABEEBBA EEEBBEADCACBEEABCEEE"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_17AUG: :environment do
        p 'Adding exams'
        datetime = 'Sun, 17 Aug 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - EsSA - All - MAT(12) + POR(12) + HIS(6) + GEO(6): AAEABDAAACCD DCABCBCBEBBD ABEACC BDECCA",
          "C - 1ª Série Militar - All - MAT(20): CEBBCDBEADDDABCCDDBD",
          "U - 1ª Série Militar - Madureira III - MAT(20): EACEBACBDCABEEABECAB",
          "C - 9º Ano Militar - All - MAT(20): CEBBCDBEADDDABCCDDBD",
          "U - 9º Ano Militar - Madureira III - MAT(20): EACEBACBDCABEEABECAB",
          "C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - POR(15) + LES(6) + MAT(6) + FIS(6) + QUI(6) + BIO(5) + HIS(6) + GEO(10): BDCBCCDCBDCDACC BCBCAD ACDDDB CBCADA BBBCBB BBCAB BDCACA DADDCDBCAD"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_10AUG: :environment do
        p 'Adding exams'
        datetime = 'Sun, 08 Aug 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - 9º Ano Forte - All - QUI(10) + FIS(10) + HIS(10): CACDCEEABC ABCEDEACDE DADBBAAECE",
          "C - 2ª Série Militar - All - HIS(10) + GEO(10) + BIO(10): BDBECBCACD BACEDACCCB CEBBECADBA",
          "C - IME-ITA, 3ª Série + IME-ITA - All - MAT(15) + FIS(15) + QUI(10): EDBCDBAECDDAEBD CDEABEADBCECDBA CBDCAEDAEE",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): DCCDBCCCEEECEBDADDBE AACEEACCEDCB ABCBDCEAEACB BAECCCBDDDEA",
          "C - AFA/EAAr/EFOMM - All - POR(20) + ING(20): AEDCBEDEACBDBEAECADB EBCDEABDDEEEBBEAECDA",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + ING(20): BBEEBDCDCACDABBBCDCA ACBCCDDBADADCDBDBCAD",
          "C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - POR(20) + ING(20): BBEEBDCDCACDABBBCDCA ACBCCDDBADADCDBDBCAD",
          "C - 9º Ano Militar - All - POR(0) + MAT(7) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8) + ING(8): AADDDCCC BABAADED AAAAAEEE BBADDEAE ADABBBDD CDBBCAAC BABCCBCC DCEACADD",
          "C - 1ª Série Militar - All - POR(0) + MAT(7) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8) + ING(8):  AADDDCCC BABAADED AAAAAEEE BBADDEAE ADABBBDD CDBBCAAC BABCCBCC CEBCBCBB",
          "C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - LES(5) + POR(40) + MAT(45): EDEEA BAECADCBADAECBDDEADBEEBAABDEACCDCEBADABA DBABACBBECACDECADEAAECEBCCEDBDCEBBBEECDBBAECD",
          "C - 2ª Série Militar - Madureira III - HIS(10) + GEO(10) + BIO(10): ECAABEDBBA ECEBCBAEAE AACEBDCECE"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_04AUG: :environment do
        p 'Adding exams'
        datetime = 'Sun, 04 Aug 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - LES(5) + POR(40) + MAT(45): EDEEA BAECADCBADAECBDDEADBEEBAABDEACCDCEBADABA DBABACBBECACDECADEAAECEBCCEDBDCEBBBEECDBBAECD"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_03AUG: :environment do
        p 'Adding exams'
        datetime = 'Sun, 03 Aug 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - HIS(18) + GEO(27) + BIO(15) + QUI(15) + FIS(15): EBBCCEBBAEAAAEAEBC DDBDAEBCCCCCCDDBEBEAEAAAEDB DBECBADAEBBDDBE EADDADCCDBCBDBD CABECCADEECADDB",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + QUI(12) + FIS(12): ABCCADCBBDDEEBDBCDCB ACDEDEBABAEB CDACECDEADAA",
          "C - ESPCEX, 3ª Série + ESPCEX - All - POR(20) + QUI(12) + FIS(12): ABCCADCBBDDEEBDBCDCB ACDEDEBABAEB CDACECDEADAA",
          "C - AFA/EAAr/EFOMM - All - MAT(20) + FIS(20): DCABBBCEEAEAAADCDADC CCDBBCBDECDECADBAAAE",
          "C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20): DCABBBCEEAEAAADCDADC CCDBBCBDECDECADBAAAE",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + FIS(20): DCABBBCEEAEAAADCDADC CCDBBCBDECDECADBAAAE",
          "C - IME-ITA, 3ª Série + IME-ITA - All - MAT(20): BDECDDCCEABBBBEABDCD"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_20JUL_3: :environment do
        p 'Adding exams'
        datetime = 'Sun, 20 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - EsSA - All - MAT(12) + POR(12) + HIS(6) + GEO(6): DDBEEEDACDDD BDDDCDBDEAEA CEDECC BEDDBB"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_20JUL_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 20 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - CN/EPCAR, 9º Ano Militar - All - POR(16) + MAT(16) + ING(16): DCBBBBCDBBACAADD CBCCABCCDDBBBDDA DBABACBDCCDBCBCB",
          "U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(16) + MAT(16) + ING(16): BDACADBACCDBDBAB ADBACDBABADCDABC CADDCBAADDBABCAD"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_20JUL: :environment do
        p 'Adding exams'
        datetime = 'Sun, 20 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - CN/EPCAR, 9º Ano Militar - All - POR(16) + MAT(16) + ING(16): DCBBBBCDBBACAADD CBCCABCCDDBBBDDA DBABACBDCCDBCBCB CADDCBAADDBABCAD",
          "C - 1ª Série Militar - All - POR(16) + MAT(16) + ING(16): BACDAAACADCBCDAC BDABCDBABBACCAAC DACABBADCABCBADB",
          "C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM, ESPCEX, 3ª Série + ESPCEX, IME-ITA, 3ª Série + IME-ITA, AFA/EAAr/EFOMM, AFA/ESPCEX, 3ª Série + AFA/ESPCEX, EsSA - All - MAT(16) + FIS(16) + POR(16) + ING(16): ACCDDBDBBDCADDBC DADCDBBCBBCCBAAB DCDCABCACDDBCDCD CBBACDAADCBACCAC",
          "U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(16) + MAT(16) + ING(16): BDACADBACCDBDBAB ADBACDBABADCDABC",
          "U - 1ª Série Militar - Madureira III - POR(16) + MAT(16) + ING(16): DCBBBBCDBBACAADD CBCCABCCDDBBBDDA BDBCDABCABCBABCD"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_13JUL: :environment do
        p 'Adding exams'
        datetime = 'Sun, 13 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Recuperação'
        array = [
          "C - 1ª Série Militar - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): CBDBDADA DADCDACA DECEADBC DABCBAAD AACADCAE DAEAECEB BEECCDAE BBBBAABA",
          "C - CN/EPCAR, 9º Ano Militar - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): CBDBDADA DADCDACA CBACCBAE DABCBAAD AACADCAE DAEAECEB BEECCDAE BBBBAABA",
          "C - 1ª Série Militar - All - POR(16) + MAT(16) + ING(16): EABBCDECEAECACEA CBBDBBCCDAABCCEA CCADDBBACCDBCDDD",
          "C - CN/EPCAR, 9º Ano Militar - All - POR(16) + MAT(16) + ING(16): EABBCDECEAECACEA CBBDBBCCDAABCCEA BACCDBCDDDCEBACA",
          "C - IME-ITA, 3ª Série + IME-ITA - All - MAT(20): CBDCCEEBBBCBDDCDCBDC",
          "C - 9º Ano Forte - All - BIO(10) + FIS(10) + GEO(10) + HIS(10) + ING(10) + MAT(10) + POR(10) + QUI(10): AADBCDEDDB DECBACCDDC CADBCCDAAB AABCCAACAA EBABCECBBD EDECDDACCB CEDACEBCBD DBCBAAEDCB",
          "U - 1ª Série Militar - Madureira III - POR(16) + MAT(16) + ING(16): CEDCAEBEACBAEBCB DECAECDEACDCADAE ABCBACABADBABCBA",
          "U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(16) + MAT(16) + ING(16): AECAABCADDBBCBDB DDCACAEEBCCDDEAB DCDDCCAAABBCDBDE"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_12JUL: :environment do
        p 'Adding exams'
        datetime = 'Sun, 12 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Recuperação'
        array = [
          "C - 2ª Série Militar - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): CEAAEEDE ABECDCBD ACAEBCBC BAACEDAE AABDDDCC DCDDACEA ADCABEAD BCABACDD"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_11JUL: :environment do
        p 'Adding exams'
        datetime = 'Sun, 11 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Concurso interno AFA'
        array = [
          "C - 2ª Série Militar - All - MAT(16) + FIS(16) + POR(16) + ING(16): EBBCACCADDBDCBEB ADBCDDBABDBDDBBC BDCCDADABDCBADDD DCADACDDCADBDDDD",
          "U - 2ª Série Militar - Bangu - MAT(16) + FIS(16) + POR(16) + ING(16): DDBDCBEBEBBCACCA BDBDDBBCADBCDDBA DDBDCCDADABDCBAD DCADBDDDDDCADACD"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_06JUL_3: :environment do
        p 'Adding exams'
        datetime = 'Sun, 06 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - CN/EPCAR, 9º Ano Militar - All - MAT(20): EBCDACAAABAAEEBDABEB"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_06JUL_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 06 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - 1ª Série Militar - All - MAT(20): EBCDACAAABAAEEBDABEB"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_05JUL: :environment do
        p 'Adding exams'
        datetime = 'Sun, 05 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Recuperação'
        array = [
          "C - IME-ITA, 3ª Série + IME-ITA - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): DDDCCBBC CCDBDDCA EABAEAAB BCBACEBA ECDDBECE ADBCBBAC BAACEEAE DBBBEAED",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): DDDCCBBC ACDACBAE DCABECAC ADABBEEC ABBEADDC ADBCBBAC BAACEEAE DBBBEAED",
          "C - ESPCEX, 3ª Série + ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): DDDCCBBC ACDACBAE CCDBDABB ADABBEEC ABBEADDC ADBCBBAC BAACEEAE DBBBEAED"      
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_06JUL: :environment do
        p 'Adding exams'
        datetime = 'Sun, 06 Jul 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P17'
        array = [
          "C - 1ª Série Militar - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): DDACDADC ADCDEAAC EABBEBDC EECCCABE BCCCDEBA BEADEABD EBBCDDEC BBDCDEAD",
          "C - CN/EPCAR, 9º Ano Militar - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): DDACDADC ADCDEAAC EACABDEB EECCCABE BCCCDEBA BEADEABD EBBCDDEC BBDCDEAD",
          "C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(16) + FIS(16) + POR(16) + ING(16): BBAADDCDADDDBDAD CBDCAECBBDACBACD CACBADDBADBDBADC DCBDADDDCDDABABC",
          "C - ESPCEX, 3ª Série + ESPCEX - All - POR(20) + QUI(12) + FIS(12): CAABCEEBECBDECECBCDA CEBEAAEDDBBE DBECEDCDCEAC",
          "C - IME-ITA, 3ª Série + IME-ITA - All - POR(20) + ING(20): AECAEEAABDCCECDCEAAB CEBDCAEDDAEBCABBDECD",
          "C - AFA/EAAr/EFOMM - All - MAT(16) + FIS(16) + POR(16) + ING(16): BBAADDCDADDDBDAD CBDCAECBBDACBACD CACBADDBADBDBADC DCBDADDDCDDABABC",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + QUI(12) + FIS(12): CAABCEEBECBDECECBCDA CEBEAAEDDBBE DBECEDCDCEAC",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(16) + FIS(16) + POR(16) + ING(16): BBAADDCDADDDBDAD CBDCAECBBDACBACD CACBADDBADBDBADC DCBDADDDCDDABABC",
          "C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - POR(8) + MAT(8) + FIS(8) + QUI(8) + BIO(8) + HIS(8) + GEO(8) + ING(8) + ESP(8) + FIL(8) + SOC(8): CBAEDDBE ABEDCACC CCDCDACA EBCDCDDE DDBDDABB DCAEDBBE EDADBACB BCEDBABB CBDBBACA EDEBECAA BCCACCCD"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_30JUN: :environment do
        p 'Adding exams'
        datetime = 'Sun, 30 Jun 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P16'
        array = [
          'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - POR(45) + MAT(45): DDCBCDAEBBEACDCCEEBDCDCABEAABAAEBBACCEABEABED AADBABEDCDEDCDBDECBDABDBBABECBBABBCBACBBACCBD'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_29JUN_2: :environment do
        p 'Adding exams'
        datetime = 'Sat, 29 Jun 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P15'
        array = [
          'C - IME-ITA, 3ª Série + IME-ITA - All - FIS(20): DXACABEECCEDBCDCADAB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_29JUN: :environment do
        p 'Adding exams'
        datetime = 'Sat, 29 Jun 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P15'
        array = [
          'C - EsSA - All - MAT(12) + POR(12) + HIS(6) + GEO(6): CEDCEDDDDABC AEBACBCBCEEB DBAEAC CAEEEC',
          'C - AFA/EAAr/EFOMM - All - POR(25) + ING(25) + MAT(25) + FIS(25): DCEDABBECABDCAABDBACEECDB BABAEAABBCDEDECBDAEAAACDB CBCDCCCADBBBCDDBBDDBCBBAA BCBECCAAADDBACAABBDAEDDEB',
          'C - ESPCEX, 3ª Série + ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): DADEDDCCDAEACBBCEEAD BCCEDDEADBDA DBDECCCADECB ABEDADCDDBAA',
          'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - HIS(18) + GEO(22) + FIL(3) + SOC(2) + BIO(15) + QUI(15) + FIS(15): CBCEEDDDEACBAEAEDE ACDCACBADECCDBACEBBBCA EDB BC ADEBCDAADDCDDCB DCEABDCCCBECBDE EEEDECCBCEBCDAB',
          'C - 9º Ano Forte - All - POR(10) + BIO(10) + MAT(10) + GEO(10): CDADBDCDEC DBCCCDBBCB CEEBAEACBB CECDABDEEA',
          'C - CN/EPCAR, 9º Ano Militar - All - POR(16) + MAT(16) + ING(16): BCCDDCDDBDACBCBA DBABABBAABDBDDBB BADDCBDCCBDAAACB',
          'C - 1ª Série Militar - All - POR(16) + MAT(16) + ING(16): BCCDDCDDBDACBCBA DBABABBAABDBDDBB DCCCCDABBBAADCCA',
          'C - 2ª Série Militar - All - POR(8) + MAT(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8) + ING(8): CCBCEEAB ECDACBCC BAAEDDEE DDADAEEB CDDECDDE DDEABACA DBCDDAAC BDEDAABA',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20): DDDEEBAAEABCECBBDDBA ACADBBCDAEBCCCAEDDCD',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): DDBBBBCDEDAACADEABCB BCCEDDEADBDA DBDECCCADECB ABEDADCDDBAA',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + FIS(20): DDDEEBAAEABCECBBDDBA ACADBBCDAEBCCCAEDDCD',
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(16) + MAT(16) + ING(16): BDACBCBABCCDDCDD ABDBDDBBDBABABBA AACBCBDCCBDABADD',
          'U - 1ª Série Militar - Madureira III - POR(16) + MAT(16) + ING(16): BDACBCBABCCDDCDD ABDBDDBBDBABABBA CCDABBBAADCCADCC'          
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_25JUN: :environment do
        p 'Adding exams'
        datetime = 'Sat, 25 Jun 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Prova Bimestral 2º Bimestre'
        array = [
          'C - 1ª Série Militar - All - BIO(8) + FIS(8) + GEO(8) + HIS(8) + ING(8) + MAT(8) + POR(8) + QUI(8): ABDEEDAD BBDCEBBE AAACEDDB BADEBCEA ABCBDDCD ABBBADAB EABDDDCA ACDECABE',
          'C - 2ª Série Militar - All - BIO(8) + FIS(8) + GEO(8) + HIS(8) + ING(8) + MAT(8) + POR(8) + QUI(8): ACECDCDD CEACCEDD EAAEECCB ABECCCEA DBCAEABB BDAEAEBC ABDEEBDC EBBDBBCE',
          'C - CN/EPCAR, 9º Ano Militar - All - BIO(8) + FIS(8) + GEO(8) + HIS(8) + ING(8) + MAT(8) + POR(8) + QUI(8): ABDEEDAD BBDCEBBE AAACEDDB BADEBCEA EDACBDEC ABBBADAB EABDDDCA ACDECABE ',
          'U - 1ª Série Militar - Campo Grande II - BIO(8) + FIS(8) + GEO(8) + HIS(8) + ING(8) + MAT(8) + POR(8) + QUI(8): BECADCDC AAEDCCDA BDCAABBC ADEAABCC DDEAEBBC ECCDBABD ABCCBADD CACEDBEA',
          'U - 2ª Série Militar - Campo Grande I - BIO(8) + FIS(8) + GEO(8) + HIS(8) + ING(8) + MAT(8) + POR(8) + QUI(8): DCDDACEC CEDDCEAC ECCBEAAE CCEAABEC EABBDBCA AEBCBDAE EBDCABDE BBCEEBBD'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_15JUN: :environment do
        p 'Adding exams'
        datetime = 'Sat, 15 Jun 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P14'
        array = [
          'C - 9º Ano Forte - All - QUI(10) + FIS(10) + HIS(10) + ING(10): DBDBADCCAB CEDDCEEDEB CBDBDBCDBD DCCACBCCAD',
          'C - AFA/EAAr/EFOMM - All - MAT(25) + POR(25) + FIS(25) + ING(25): ADDAABDADDBBBCBCCDAACBADA DCDACCDABDCAAADCABBBDBCDD BBACDEDBDEBDABBEABBBBCBEB ABADBAADCCDCBCBADDABACDAA',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + QUI(12) + FIS(12): CEADBEDBEDBDACDCBBEB BCCEAEDBCEAC DDBEBDDAAABB',
          'C - ESPCEX, 3ª Série + ESPCEX - All - POR(20) + QUI(12) + FIS(12): ECECABDCCCDBDABCCBAA BCCEAEDBCEAC DDBEBDDAAABB',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + ING(20): ECECABDCCCDBDABCCBAA CDCEDBECAEAAAAABEBAE',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - POR(20) + ING(20): CEADBEDBEDBDACDCBBEB CDCEDBECAEAAAAABEBAE'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_08JUN: :environment do
        p 'Adding exams'
        datetime = 'Sat, 08 Jun 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P13'
        array = [
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(16) + FIS(16) + POR(16) + ING(16): CACDBBDABBDACADC ADBDCCCCABADBADD CADBCDDACBDABCBD BBBABCABACACDBAD',
          'C - EsSA - All - MAT(12) + POR(12) + HIS(6) + GEO(6): CDBCEDBACBBD ABCDADCEACDE EDDBEA DBCCBA',
          'C - 1ª Série Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): EAEBDEBDEADACBCACDED DCAEAB DBCDDA DAADAD AECDCB CADDDC',
          'C - CN/EPCAR, 9º Ano Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): EAEBDEBDEADACBCACDED DCAEAB DBCDDA DAADAD ECAEDB CADDDC',
          'C - 2ª Série Militar - All - MAT(10) + FIS(10) + POR(10) + ING(10): CCCBADACDE ACDCDCDCAD CEDCBADCEA DCBEBAECBE',
          'C - IME-ITA, 3ª Série + IME-ITA - All - POR(15) + ING(25): CEBADADACCCACBD AAEAEBDACEDBDBDEABEECBDAE',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(16) + FIS(16) + POR(16) + ING(16): CACDBBDABBDACADC ADBDCCCCABADBADD CADBCDDACBDABCBD BBBABCABACACDBAD',
          'U - 1ª Série Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): ACBCACDEDEAEBDEBDEAD EABDCA DDADBC DADDAA DCBAEC DDCCAD',
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): ACBCACDEDEAEBDEBDEAD AEABDC DDADBC DADDAA AEECDB DDCCAD',
          'U - 2ª Série Militar - Madureira I - MAT(10) + FIS(10) + POR(10) + ING(10): DACDECCCBA DCDCADACDC CEABCDAECD BCDECEABEB',
          'U - 2ª Série Militar - NorteShopping - MAT(10) + FIS(10) + POR(10) + ING(10): CAAADCCECB CDDADCCCAD ADBACDCECE BDCEEBCABE'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end            
      task add_exams_01JUN: :environment do
        p 'Adding exams'
        datetime = 'Sat, 01 Jun 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P12'
        array = [
          'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - MAT(60): DBADCCBCDBBCABADBCBABDDABBCABCADCCBCADDDCDBAAAABABBCCDCDABDB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end            
      task add_exams_25MAI: :environment do
        p 'Adding exams'
        datetime = 'Sat, 25 Mai 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P11'
        array = [
          'C - 9º Ano Forte - All - POR(10) + BIO(10) + MAT(10) + GEO(10): BAEACCBDBD DABEBEECDE CCCBDBDCDB CBDBADDEBB',
          'C - 1ª Série Militar - All - MAT(20): EEACEDDDECBCADCBADBA',
          'C - CN/EPCAR, 9º Ano Militar - All - MAT(20): EEACDDDDECBCADCBDEBB',
          'C - AFA/EAAr/EFOMM - All - MAT(20) + FIS(20): ABCCDAAECBBCCACCBDCA DDCDCCBCBADDCDABAECE',
          'C - ESPCEX, 3ª Série + ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): CDEAACABECCBACAACBBC BBEABCCBDBDA CEDBABAEBECC BCBDBBBBEAEA',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): CDEAACABECCBACAACBBC BBEABCCBDBDA CEDBABAEBECC BCBDBBBBEAEA',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20): CBDCDAAECBBCCACCBDCA DDCDCCBCBADDCDADAECE',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + FIS(20): CBDCDAAECBBCCACCBDCA DDCDCCBCBADDCDADAECE',
          'C - 2ª Série Militar - All - QUI(10) + HIS(10) + GEO(10) + BIO(10): ABABCDECBB BBEABCAAAE EEBACACECE AABDECBBBA',
          'U - 2ª Série Militar - Madureira I - QUI(10) + HIS(10) + GEO(10) + BIO(10): DECBBABABC AAAEBBEABC ACECEEEBAC CBBBAAABDE',
          'U - 1ª Série Militar - Madureira III - MAT(20): BCADCBADBAEEACEDDDEC',
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - MAT(20): BCADCBDEBBEEACDDDDEC'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end            
      task add_exams_18MAI: :environment do
        p 'Adding exams'
        datetime = 'Sat, 18 Mai 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P10'
        array = [
          'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - POR(15) + LES(6) + MAT(6) + FIS(6) + QUI(6) + BIO(5) + HIS(6) + GEO(10): DBADCCBCDBBCABA DBCBAB DDABBC ABCADC CBCADD DCDBA AAABAB BCCDCDABDB',
          'C - ESPCEX, 3ª Série + ESPCEX - All - POR(20) + QUI(12) + FIS(12): ABBBABEEBCDEBCECCADB DAABEDACAADA ABAAACBEEAAC',
          'C - AFA/EAAr/EFOMM - All - POR(20) + ING(20):  DCADBABCDEBCCBDCBAAE CCDDDBDCBADAEBBDBCED',
          'C - 3ª Série + AFA/ESPCEX, AFA/ESPCEX - All - POR(20) + QUI(12) + FIS(12): BDACCEEAADEDDBACEAEB DAABEDACAADA ABAAACBEEAAC',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - POR(20) + ING(20): DCADBABCDEBCCBDCBAAE CCDDDBDCBADAEBBDBCED',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + ING(20): DCADBABCDEBCCBDCBAAE CCDDDBDCBADAEBBDBCED',
          'C - 2ª Série Militar - All - MAT(10) + POR(10) + ING(10): AAAAAAAAAA DCBEAAEACC DEBACBACBA',
          'C - 1ª Série Militar - All - POR(16) + MAT(16) + ING(16): CDAABCACDADBCBDB CCBADDDBBCDBDCAB CDBABBCADBABBAAB',
          'C - CN/EPCAR, 9º Ano Militar - All - POR(16) + MAT(16) + ING(16): CDAABCACDADBCBDB CCBADDDBBCDBDCAB CDBABBCADBABBAAB',
          'U - 1ª Série Militar - Madureira III - POR(16) + MAT(16) + ING(16): ABCDACCABCDADBBD BCDBDCABCCBADDDB CADBABBAABCDBABB',
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(16) + MAT(16) + ING(16): ABCDACCABCDADBBD BCDBDCABCCBADDDB CADBABBAABCDBABB',
          'U - 2ª Série Militar - Madureira I - MAT(10) + POR(10) + ING(10): AAAAAAAAAA EAADCBAECC BEDCAABCAB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end            
      task add_exams_11MAI: :environment do
        p 'Adding exams'
        datetime = 'Sat, 11 Mai 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P9'
        array = [
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20) + POR(20) + ING(20): BDDADDBCABACDDADCBCC AADCCDAADABABBADCAAB BCDABCADCABBCCAAADCB DCBCAABAACDBDBABDCBA',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + FIS(20) + POR(20) + ING(20): BDDADDBCABACDDADCBCC AADCCDAADABABBADCAAB BCDABCADCABBCCAAADCB DCBCAABAACDBDBABDCBA',
          'C - ESSA - All - MAT(12) + POR(12) + HIS(6) + GEO(6) + : CECDAADBDCDB BEABBCBADECD CBACDA AACCEE',
          'C - 1ª Série Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): DAEBAEBBDBDDBADDABBC EBADAA BDBEAB EEABAC ABDECA CDAACE',
          'C - CN/EPCAR, 9º Ano Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): DAEBAEBBDBDDBADDABBC EBADAA BDBEAB EEABAC ADEBCB CDAACE',
          'C - 9º Ano Forte - All - QUI(10) + FIS(10) + HIS(10): DDCADCCBBB DEDEBDECD AEEACBABDB',
          'U - 9º Ano Forte - NorteShopping - QUI(10) + FIS(10) + HIS(10): DDCADCCBBB DEDEBBDECD AEEACBABDB',
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): BDBDDBADDABBDAEBAEBC AADAEB EABBDB BACEEA BCBADE ACECDA',
          'U - 1ª Série Militar - Madureira I - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): BDBDDBADDABBCDAEBAEB DAAEBA EABBDB BACEEA ECAABD ACECDA',
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end            
      task add_exams_04MAI_3: :environment do
        p 'Adding exams'
        datetime = 'Sat, 04 Mai 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P8'
        array = [
          'C - AFA/EAAr/EFOMM, IME-ITA, 3ª Série + IME-ITA, ESPCEX, 3ª Série + ESPCEX, AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM, 3ª Série + AFA/ESPCEX, AFA/ESPCEX - All - MAT(10): DDECDCEEED',
          'C - AFA/EAAr/EFOMM, IME-ITA, 3ª Série + IME-ITA, ESPCEX, 3ª Série + ESPCEX, AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM, 3ª Série + AFA/ESPCEX, AFA/ESPCEX - All - POR(10): CACDBCDACB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end            
      task add_exams_04MAI_2: :environment do
        p 'Adding exams'
        datetime = 'Sat, 04 Mai 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P8'
        array = [
          'C - 9º Ano Forte - All - BIO(10) + FIS(10) + GEO(10) + HIS(10) + ING(10) + MAT(10) + POR(10) + QUI(10): CDACACDBCD ABCCCDDBCD EABDADCBCD DDECBAAAAE ADCADEDBCA AEDBABCCDD EADDCCEEAD ACDCEBADAC',
          'C - AFA/EAAr/EFOMM, IME-ITA, 3ª Série + IME-ITA, ESPCEX, 3ª Série + ESPCEX, AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM, 3ª Série + AFA/ESPCEX, AFA/ESPCEX - All - MAT(10) + POR(10): DDECDCEEED CACDBCDACB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end            
      task add_exams_04MAI: :environment do
        p 'Adding exams'
        datetime = 'Sat, 04 Mai 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P8'
        array = [
          'C - CN/EPCAR, 9º Ano Militar - All - MAT(20): ABEBCAEBADBCBBCCEDCA',
          'C - 1ª Série Militar - All - MAT(20): ABEBCAEBADBCBBCCEDCA',
          'C - 2ª Série Militar - All - HIS(10) + GEO(10) + BIO(10): CCAABCDDCA ACEABEBDCC CEADBDDCDC',
          'C - AFA/EAAr/EFOMM - All - MAT(25) + POR(25) + FIS(25) + ING(25):  ADCABDDBACBDDBEEABCAACECC CBABBBCCCABBAADDDCDDCCADA AAAACDDCCBDDCCBCCBDBDBCAA BADAADADACCCBABBABDCABDBD',
          'C - IME-ITA, 3ª Série + IME-ITA - All - MAT(15) + QUI(10) + FIS(15): DDADAAABBAEADEA EACBDADEEB DBDCDEDDCDDABAD',
          'C - ESPCEX, 3ª Série + ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): ECEDBBBCDECDDCDBCABE ECDECDCABCAD DBDEEDAAEEAD ABECDCEADBCD',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20): CBBCCDDDDBDAACEDBEEA BAAECDACBDADBAEDDEBB',
          'C - 3ª Série + AFA/ESPCEX, AFA/ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): DBDACCEDDCABCCBDEAAA ECDECDCABCAD DBDEEDAAEEAD ABECDCEADBCD',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + FIS(20): BADDCEDBDCEDCAEBDCCE BAAECDACBDADBAEDDEBB',
          'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - POR(40) + ING(5) + MAT(45): CABBAEBEEDDCDDAAEEBCADBBBAEDCDACCBDBDCAE ACCCE EBDECDDEBDBCCCBECAAEBDCCAAAAAADCBCDCBDAEEBCED',
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - MAT(20): BCBBCCEDCAABEBCAEBAD',
          'U - 1ª Série Militar - Madureira III - MAT(20): BCBBCCEDCAABEBCAEBAD',
          'U - 2ª Série Militar - Madureira I - HIS(10) + GEO(10) + BIO(10): CDDCACCAAB EBDCCACEAB DDCDCCEADB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end            
      task add_exams_27ABR: :environment do
        p 'Adding exams'
        datetime = 'Sat, 27 Apr 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P7'
        array = [
          'C - AFA/ESPCEX (ESPCEX), 3ª Série + AFA/ESPCEX (ESPCEX) - All - POR(20) + QUI(12) + FIS(12): ADBCEEECDABDAADBEACC DBAEACCEDAAB CDCAAEEDCBCB',
          'C - ESPCEX, 3ª Série + ESPCEX - All - POR(20) + QUI(12) + FIS(12): ADBCEEECDABDAADBEACC DBAEACCEDAAB CDCAAEEDCBCB',
          'C - EsSA - All - MAT(12) + POR(12) + HIS(6) + GEO(6): EBDECCDAAEBD CADBDBECBDAD CBBADB CEADBC',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - POR(20) + ING(20): CECDEEDACBCDABCACBCE CCDAAABDACEDEECDACAA',
          'C - AFA/ESPCEX (EFOMM), 3ª Série + AFA/ESPCEX (EFOMM) - All - POR(20) + ING(20): CECDEEDACBCDABCACBCE CCDAAABDACEDEECDACAA',
          'C - IME-ITA, 3ª Série + IME-ITA - All - QUI(20): CBBBAEADAECDACCAADDC',
          'C - 9º Ano Forte - All - POR(10) + BIO(10) + MAT(10) + GEO(10): BAAEBDAAAB CCBCEEBCCD EBDEDEDBBB AACCEDCEDD'
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end      
      task add_exams_20ABR: :environment do
        p 'Adding exams'
        datetime = 'Sat, 20 Apr 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P7'
        array = [
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20) + POR(20) + ING(20): AADDCABDAABBBBDBABDD DDBDCCACBADDDCBCBCBD DBCABDDDABDDCDBADBBD BDBBCCAABCDBCCAADCBC',
          'C - AFA/EAAr/EFOMM - All - MAT(20) + POR(20) + FIS(20) + ING(20):  AADDCABDAABBBBDBABDD DDBDCCACBADDDCBCBCBD DBCABDDDABDDCDBADBBD BDBBCCAABCDBCCAADCBC',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + FIS(20) + POR(20) + ING(20): AADDCABDAABBBBDBABDD DDBDCCACBADDDCBCBCBD DBCABDDDABDDCDBADBBD BDBBCCAABCDBCCAADCBC',
          'C - 1ª Série Militar - All - POR(15) + MAT(15) + ING(10): CABDCCADABDADDB BCAECCDCEDBACAC BDDBCAADCB',
          'C - CN/EPCAR, 9º Ano Militar - All - POR(15) + MAT(15) + ING(10): CABDCCADABDADDB BCAECCDCEDBACAC DBBDACACCB',
          'C - IME-ITA, 3ª Série + IME-ITA - All - MAT(20): ACCBEDACAEDCEDABADDB', # + MAT(10)
          'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - HIS(18) + GEO(22) + FIL(3) + SOC(2) + BIO(16) + QUI(14) + FIS(15): EEABBECECAECACBDAE BDECDCDCBDAEBBCCBCAAEA DAC AB AECAEDADDDCCBADB BEACDCCEBBACDC AAAAABDAEEBCEAE',
          'U - 1ª Série Militar - Madureira III - POR(15) + MAT(15) + ING(10): BDADDBDCCADACAB DCEDBACACBCAECC DBBDDCBCAA',
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(15) + MAT(15) + ING(10): DCCADABDADDBCAB DCEDBACACBCAECC ACACCBDBBD'
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end      
      task add_exams_13ABR_2: :environment do
        p 'Adding exams'
        datetime = 'Sat, 13 Apr 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P6'
        array = [
          'C - 9º Ano Forte - All - QUI(10) + FIS(10) + HIS(10) + ING(10):  DEADEEBCBD ECCDCABCDB EEBCCBBACB BACDBDBEDB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end      
      task add_exams_13ABR: :environment do
        p 'Adding exams'
        datetime = 'Sat, 13 Apr 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P6'
        array = [
          'C - AFA/EAAr/EFOMM - All - MAT(25) + POR(25) + FIS(25) + ING(25):  BBCDABCCAACBCCBDCBCCCCCDB ACBBCACDBACCAABDDCACBBBBA ABCCDBBDCADABDDBADBCDCAAC ADCAABBDCDBDDBABDBDBADDCB',
          'C - 3ª Série + AFA/ESPCEX, AFA/ESPCEX - All - MAT(20) + HIS(12) + GEO(11) + ING(12): BBDABACBDCDAAAADDBCC CABCBBBACDEC DAEADEEDDBC DADCCDACDEBC',
          'C - ESPCEX, 3ª Série + ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): EBAECAEABABDAEDEEBEE DCADCEEDBCCD DAEADDEEDDBC DADCCDACDEBC',
          'C - IME-ITA, 3ª Série + IME-ITA - All - POR(20) + ING(20): DADEBCAAEEEABEDEDAAD BBEDAECCDBECCBADEAEB',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20): BBDABACBDCDAAAADDBCC EBDDEADABADCBCDBACBB',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + ING(20): BBDABACBDCDAAAADDBCC EBDDEADABADCBCDBACBB'          
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end      
      task add_exams_06ABR: :environment do
        p 'Adding exams'
        datetime = 'Sat, 6 Apr 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P5'
        array = [
          'C - 2ª Série Militar - All - GEO(10): CCABBABCEC',
          'C - AFA/EAAr/EFOMM - All - MAT(25) + POR(25) + FIS(25) + ING(25):  DDDDEEADEEBDACEBBCCC ACBBCACDBACCAABDDCACBBBBA ABCCDBBDCADABDDBADBCDCAAC ADCAABBDCDBDDBABDBDBADDCB',
          'C - 3ª Série + AFA/ESPCEX (ESPCEX), AFA/ESPCEX (ESPCEX) - All - POR(20) + QUI(12) + FIS(12): CAEDBAEEEAECBAECCBEA DCDABCDEAECD DADAEBEEBECA', # MODELO ESPCEX
          'C - ESPCEX, 3ª Série + ESPCEX - All - POR(20) + QUI(12) + FIS(12): CAEDBAEEEAECBAECCBEA DCDABCDEAECD DADAEBEEBECA',
          'C - EsSA - All - MAT(12) + POR(12) + HIS(6) + GEO(6): AAECDBCBCECE ACBBCACBACAC EABBDE AADADE', 
          'C - IME-ITA, 3ª Série + IME-ITA - All - FIS(20): DACBBECDACEADBDCBAB', # + FIS(10)
          'C - 1ª Série Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): CEDEBAACDBDBABBDBBCA AACADD ACBDCC CBBADE BEDDEB ABCDED',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - POR(20) + ING(20): CABDBDECBADCBCACBEAE CACBEBCBABBAECBDACBD',
          'C - AFA/ESPCEX (EFOMM), 3ª Série + AFA/ESPCEX (EFOMM) - All - POR(20) + ING(20): CABDBDECBADCBCACBEAE CACBEBCBABBAECBDACBD', # MODELO EFOMM
          'C - CN/EPCAR, 9º Ano Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): CEDEBAACDBDBABBDBBCA AACADD ACBDCC CBBADE EDABCB ABCDED', 
          'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - POR(15) + ING(6) + MAT(6) + FIS(6) + QUI(6) + BIO(5) + HIS(6) + GEO(10): DCAAADBACBBBABA BDBACD DABCAD BCADCC CDDCBA BDADC CCCADE DAADBCBBCB ',
          'C - 2ª Série Militar - All - MAT(15) + FIS(15): DCBECCDBDBCACCD ADAABAEEEABDCCC',
          'U - 1ª Série Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): ACDBDBABBDBBCACEDEBA ADDAAC DCCACB ADECBB DEBBED DEDABC',
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): ACDBDBABBDBBCACEDEBA ADDAAC DCCACB ADECBB BCBEDA DEDABC'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end

      task add_exams_2: :environment do
        p 'Adding exams'
        datetime = 'Sat, 23 Mar 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P3'
        array = [
          'C - CN/EPCAR, 9º Ano Militar - All - MAT(20): DDDDEEADEEBDACEBBCCC', 
          'C - 9º Ano Forte - All - POR(10) + BIO(10) + MAT(10) + GEO(10): EDCDCDDDCB ECDABBDEAD BBAEDABEAD CCBAACABDC',
          'C - 1ª Série Militar - All - MAT(20): DDDDEEADEEBDACEBBCCC', 
          'C - 2ª Série Militar - All - QUI(10) + HIS(10) + BIO(10): BCABECDBAA DBBEEEEBCB ADAEABACEB',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20) + POR(20) + ING(20): BECCBDECDAACBBCDCBBD DEAEBCADADEACBADBEEB CBABBBCCADCBADACACAA CBCCCDDABCDEDECBDAEC', 
          'C - AFA/EAAr/EFOMM - All - FIS(20) + MAT(20): DEAEBCADADEACBADBEEB BEDDBDCACEADBCACCEDC', 
          'C - Pré-Vestibular, 3ª Série + Pré-Vestibular - All - POR(15) + ING(6) + MAT(6) + FIS(6) + QUI(6) + BIO(5) + HIS(6) + GEO(10)- DADABDCDDBDABAC ACABAA ABCADB BDADBD BBDDAD BBDAB DBBDDA CDDAADCBBA',
          'C - IME-ITA, 3ª Série + IME-ITA - All - POR(15) + ING(15): ACADBCBEBEDAACA DACBDECBEAACBBB',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + FIS(20) + POR(20) + ING(20): ABACDCCBDAACCCBDADAE DEAEBCADADEACBADBEEB CBABBBCCADCBADACACAA CBCCCDDABCDEDECBDAEC',
          'U - 1ª Série Militar - Madureira III - MAT(20): BDACEBBCCCDDDDEEADEE',
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - MAT(20): BDACEBBCCCDDDDEEADEE',
          'U - 2ª Série Militar - Madureira I - QUI(10) + HIS(10) + BIO(10): ECDBAABCAB EEEBCBDBBE BACEBADAEA',
          'U - 9º Ano Forte - São Gonçalo II - POR(10) + BIO(10) + MAT(10) + GEO(10): EDCDCDDDCB ECDABBDEAD BBAEDABEAD CCBAACABDC'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_madureira_exams: :environment do 
        p 'Adding exams'
        datetime = 'Sat, 16 Mar 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P2'
        array = [
          'U - CN/EPCAR, 9º Ano Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): CDECBEAEDDCAEBEBCCDD CDBEAE BECAAB AEDCEA DAEBBD DBABCC',
          'U - 1ª Série Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): CDECBEAEDDCAEBEBCCDD CDBEAE BECAAB AEDCEA EBCCEA DBABCC',
          'U - 2ª Série Militar - Madureira I - POR(10) + ING(10): BDDCEACCAD CDCDCEEDDA'] # MAT(10)
        create_exams(array, datetime, cycle_name, exam_name)
      end

      task add_missing_exam: :environment do 
        p 'Adding missing exam'
        datetime = 'Sat, 16 Mar 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P2'
        array = [
          'C - 9º Ano Forte - All - QUI(10) + FIS(10) + HIS(10): BCBABEBBBD BDDEEDDBAB BAADBDACBB']
        create_exams(array, datetime, cycle_name, exam_name)
      end

      task add_exams: :environment do
        p 'Adding exams'
        datetime = 'Sat, 16 Mar 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'P2'
        array = [
          'C - CN/EPCAR, 9º Ano Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): DDCAEBEBCCCDECBEAEDD EAECDB AABBEC CEAAED BBDDAE BCCDBA',
          'C - 1ª Série Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): DDCAEBEBCCCDECBEAEDD EAECDB AABBEC CEAAED CEAEBC BCCDBA',
          'C - ESPCEX, 3ª Série + ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): DAADEBCDCCCECDECBEDC BABBBEABBBDC BACEDCBCABDB BABAEAAACCEB',
          'C - 2ª Série Militar - All - POR(10) + ING(10): DBDCEACDCA DCDCECADDE', # MAT(10)
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20): DCCEDCCDEBEABCADCCBC ABDBDCCADEAAECEBCCDC', 
          'C - IME-ITA, 3ª Série + IME-ITA - All - QUI(10): ADABDDAAAA', # QUI(5)
          'C - AFA/ESPCEX (ESPCEX), 3ª Série + AFA/ESPCEX (ESPCEX) - All - MAT(20) + HIS(12) + GEO(12) + ING(12): DCCEDCCDEBEABCADCCBC BABBBEABBBDC BACEDCBCABDB BABAEAAACCEB',
          'C - AFA/ESPCEX (EFOMM), 3ª Série + AFA/ESPCEX (EFOMM) - All - MAT(20) + FIS(20): DCCEDCCDEBEABCADCCBC ABDBDCCADEAAECEBCCDC']
        create_exams(array, datetime, cycle_name, exam_name)
      end

      def create_exams(array, datetime, cycle_name, exam_name)
        ActiveRecord::Base.transaction do 
          array.each do |line|
            action, product_names, campus_names, exam_attributes = line.split(' - ')
            product_names = product_names.gsub(/ \(\S*\)/, '')
            p product_names
            product_years = product_names.split(', ').map do |p| ProductYear.where(name: p + ' - 2013').first! end
            campuses = (campus_names == 'All' ? Campus.all : Campus.where(name: campus_names.split(', ')))
            subjects, correct_answers = exam_attributes.split(': ')
            subject_hash = Hash[*subjects.gsub(')', '').split(' + ').map do |s| s.split('(') end.flatten]
            correct_answers = correct_answers.gsub(' ', '')
            exam = Exam.create!(
              name: cycle_name + exam_name, 
              correct_answers: correct_answers, 
              options_per_question: 5)

            starting_at = 1
            subject_hash.each_pair do |subject_code, number_of_questions|
              number_of_questions = number_of_questions.to_i
              subject = Subject.where(code: subject_code).first!

              subject_question_ids = 
                ExamQuestion.where(
                  number: (starting_at..(starting_at + number_of_questions - 1)),
                  exam_id: exam.id).map(&:question).map(&:id)

              subject_topic = 
                Topic.where(name: subject.name, subject_id: subject.id).
                first_or_create!(subtopics: 'All')

              subject_question_ids.each do |subject_question_id|
                QuestionTopic.create!(
                  question_id: subject_question_id,
                  topic_id: subject_topic.id)
              end
              starting_at = starting_at + number_of_questions
            end

            product_years.each do |product_year|
              exam_cycle = ExamCycle.where(
                name: cycle_name + product_year.name).first_or_create!(
                is_bolsao: false, product_year_id: product_year.id)

              campuses.each do |campus|
                super_klazz = SuperKlazz.where(product_year_id: product_year.id, campus_id: campus.id).first
                next if super_klazz.nil?
                
                if action == 'C'
                  ExamExecution.create!(
                    exam_cycle_id: exam_cycle.id, 
                    super_klazz_id: super_klazz.id,
                    datetime: datetime,
                    exam_id: exam.id)
                elsif action == 'U'
                  exam_execution = ExamExecution.where(exam_cycle_id: exam_cycle.id, super_klazz_id: super_klazz.id).first
                  exam_execution.update_attribute :exam_id, exam.id
                end
              end
            end
          end
        end 
      end
    end
  end
end