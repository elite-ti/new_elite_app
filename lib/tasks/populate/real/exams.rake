# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do
        task add_exams_28NOV_1: :environment do
          p 'Adding exams'
          datetime = 'Mon, 28 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '2º Simulado - Ciclo 7 - '
          exam_name = 'Prova'
          array = [
            'C - 3ª Série + IME-ITA, IME-ITA - All - QUI(20): BECCDACADDADEECABADB'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_27NOV_2: :environment do
          p 'Adding exams'
          datetime = 'Mon, 27 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '2º Simulado - Ciclo 7 - '
          exam_name = 'Prova'
          array = [
            'C - 3ª Série + IME-ITA, IME-ITA - All - MAT(20): CCCAABDBDCBCCDBADCAC'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_26NOV: :environment do
          p 'Adding exams'
          datetime = 'Mon, 26 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '2º Simulado - Ciclo 7 - '
          exam_name = 'Prova'
          array = [
            'C - 3ª Série + IME-ITA, IME-ITA - All - POR(20) + ING(20): CACBEBEADBDECBCCEBDD BCBEABDEADEDBCCCBDCA'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_03DEC: :environment do
          p 'Adding exams'
          datetime = 'Mon, 03 Dec 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 4º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série Militar - All - POR(10) + ING(10) + RED(10): DBDBDEDDDA EDAACCABCB BCABBDCBBA',
            'C - 2ª Série Militar - All - POR(10) + ING(10) + RED(10): EAABDDDCEB CAEAEDECDA BCABBDCBBA',
            'C - 9º Ano Militar - All - POR(8) + ING(10) + RED(10): DCEBAAED AECADBECAA BCABBDCBBA'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_02DEC: :environment do
          p 'Adding exams'
          datetime = 'Mon, 02 Dec 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 4º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série Militar - All - MAT(10) + FIS(10): ABBBDDDCDA CEADDEBBAC',
            'C - 2ª Série Militar - All - MAT(10) + FIS(10): DBDABDCDDA DCBCBCBADE',
            'C - 9º Ano Militar - All - MAT(10) + FIS(10): ABBBDDDCDA CEADDEBBAC'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_29NOV_2: :environment do
          p 'Adding exams'
          datetime = 'Mon, 29 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '4º Bimestre - Subtitutiva - '
          exam_name = 'Prova'
          array = [
            'C - 9º Ano Forte - All - BIO(10) + FIS(10) + GEO(10) + HIS(10) + ING(10) + MAT(10) + POR(10) + QUI(10): ADDCCEECCB BAACBBAAEE CAAAACDDCB AACBDBCDBA DBBADCBBAA DCDDDBBCCA CBAEDBEDED ABBDBACADE - Manhã',
            'C - 9º Ano Forte - All - BIO(10) + FIS(10) + GEO(10) + HIS(10) + ING(10) + MAT(10) + POR(10) + QUI(10): DADCECECCB ABCABBAAEE ACAACADDCB AABCDBDCAB BDBADBCABA CDDDDBBACC BCEADBDEDE ABBBDCADAE - Tarde'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_29NOV: :environment do
          p 'Adding exams'
          datetime = 'Mon, 29 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 4º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 3ª Série + IME-ITA, IME-ITA - All - BIO(10) + QUI(10): BCEBBACEDD CEDEAECDCE',
            'C - 3ª Série + ESPCEX, AFA/ESPCEX - All - BIO(10) + QUI(10): BCEBBACEDD DBECAAEEBD'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_28NOV: :environment do
          p 'Adding exams'
          datetime = 'Mon, 28 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 4º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 3ª Série + IME-ITA, IME-ITA - All - FIL(10) + SOC(10): BCEADCADEA BCACDCDEAB',
            'C - 3ª Série + ESPCEX, AFA/ESPCEX - All - FIL(10) + SOC(10): BBACBCCEAB CCCACCBBBC',
            'C - 3ª Série + IME-ITA, IME-ITA - All - EDF(10): AAADBAEBEE',
            'C - 3ª Série + ESPCEX, AFA/ESPCEX - All - EDF(10): AAADBAEBEE'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_27NOV_1: :environment do
          p 'Adding exams'
          datetime = 'Mon, 27 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 4º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 3ª Série + IME-ITA, IME-ITA - All - HIS(10) + GEO(10): EECCCCABAC AECDDABBBD',
            'C - 3ª Série + ESPCEX, AFA/ESPCEX - All - HIS(10) + GEO(10): EECCCCABAC BEABCDDECD'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_25NOV_3: :environment do
          p 'Adding exams'
          datetime = 'Mon, 25 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 4º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 3ª Série + ESPCEX, AFA/ESPCEX - All - MAT(10) + FIS(10): DBEBDAEECE ACEBCCDCBE',
            'C - 3ª Série + IME-ITA, IME-ITA - All - MAT(10) + FIS(10): DBEBDAEECE CABDAADDCA'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_25NOV_3: :environment do
          p 'Adding exams'
          datetime = 'Mon, 25 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 4º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 3ª Série + ESPCEX - All - POR(10) + ING(10) + RED(10): BCBCBEBECE DCBCACDACE EADCECDDAB',
            'C - 3ª Série + IME-ITA - All - POR(10) + ING(10): BCBCBEBBCE CADBDDEEDD'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_25NOV_3: :environment do
          p 'Adding exams'
          datetime = 'Mon, 25 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 4º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 3ª Série + ESPCEX, AFA/ESPCEX - All - MAT(10) + FIS(10): DBEBDAEECE ACEBCCDCBE',
            'C - 3ª Série + IME-ITA, IME-ITA - All - MAT(10) + FIS(10): DBEBDAEECE CABDAADDCA'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_27NOV: :environment do
          p 'Adding exams'
          datetime = 'Mon, 27 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'P8 - '
          exam_name = 'Prova'
          array = [
            'C - 9º Ano Forte - All - POR(10) + BIO(10) + MAT(10) + GEO(10):  DCCEADCBEE DDBAAECDCA EBABEAEABE CCDAADCDCA - Manhã',
            'C - 9º Ano Forte - All - POR(10) + BIO(10) + MAT(10) + GEO(10):  CDCEDAECBE BDDAEACCDA BEBAAEAEEB DCCADACCDA - Tarde'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_25NOV_2: :environment do
          p 'Adding exams'
          datetime = 'Mon, 25 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'P8 - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM - All - EDF(10): DBACAEBCEC - Manhã',
            'C - 1ª Série ENEM - All - EDF(10): ECEEEAEBEC - Tarde',
            'C - 2ª Série ENEM - All - EDF(10): AACAECBCEB - Manhã',
            'C - 2ª Série ENEM - All - EDF(10): EEEAECBECE - Tarde',
            'C - 6º Ano - All - ESP(10): ACBCDEDABC - Manhã',
            'C - 6º Ano - All - ESP(10): BCEBBAEBEC - Tarde',
            'C - 6º Ano - All - ING(10): DEABCCDEAB - Manhã',
            'C - 6º Ano - All - ING(10): ACCDEABCDE - Tarde',
            'C - 7º Ano - All - ESP(10): DBBBCADCCC - Manhã',
            'C - 7º Ano - All - ESP(10): DCDEADBBEE - Tarde',
            'C - 7º Ano - All - ING(10): DAEBCABCDE - Manhã',
            'C - 7º Ano - All - ING(10): DEEDCABCDE - Tarde',
            'C - 8º Ano - All - ESP(10): AADCCEBABB - Manhã',
            'C - 8º Ano - All - ESP(10): ACDABECEBE - Tarde',
            'C - 8º Ano - All - ING(10): DBADBCBCBD - Manhã',
            'C - 8º Ano - All - ING(10): BCCBAABDBD - Tarde'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_25NOV_1: :environment do
          p 'Adding exams'
          datetime = 'Mon, 25 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '1º Simulado - Ciclo 7 - '
          exam_name = 'Prova'
          array = [
            'C - IME-ITA, 3ª Série + IME-ITA - All - FIS(20): DACDEBBCAACCEEDCBDCD'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_25NOV: :environment do
          p 'Adding exams'
          datetime = 'Mon, 25 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'P8 - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM - All - ESP(10) + MAT(10): CEABAECAED CBBDEBDECA - Manhã',
            'C - 1ª Série ENEM - All - ESP(10) + MAT(10): BBECDAEBBB ACBEDDEDCA - Tarde',
            'C - 2ª Série ENEM - All - ESP(10) + MAT(10): AECEECAEBD BEBEADADAD - Manhã',
            'C - 2ª Série ENEM - All - ESP(10) + MAT(10): EBDDCBAEAD EADAEDDADA - Tarde',
            'C - 6º Ano - All - HIS(10): CAEBBDDACB - Manhã',
            'C - 6º Ano - All - HIS(10): BEDBBAEDDC - Tarde',
            'C - 7º Ano - All - HIS(10): DAEEBCADCC - Manhã',
            'C - 7º Ano - All - HIS(10): BECADCCCDA - Tarde',
            'C - 8º Ano - All - HIS(10): ACAACAAABE - Manhã',
            'C - 8º Ano - All - HIS(10): BAACDBECBA - Tarde'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_22NOV_1: :environment do
          p 'Adding exams'
          datetime = 'Mon, 22 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'P8 - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM - All - HIS(10) + QUI(10): CCDDDDADBB ACCAECEDEB - Manhã',
            'C - 1ª Série ENEM - All - HIS(10) + QUI(10): CDAEBCCAEC AECACECBCD - Tarde',
            'C - 2ª Série ENEM - All - HIS(10) + QUI(10): CBBAECADEC ACCDDEDCDB - Manhã',
            'C - 2ª Série ENEM - All - HIS(10) + QUI(10): ADCAACAADB BDACADDECA - Tarde',
            'C - 6º Ano - All - GEO(10): DDBBBAAADD - Manhã',
            'C - 6º Ano - All - GEO(10): BABABBACAD - Tarde',
            'C - 7º Ano - All - GEO(10): DCEABDCACB - Manhã',
            'C - 7º Ano - All - GEO(10): BBCCABACBA - Tarde',
            'C - 8º Ano - All - GEO(10): BBBDCBADEA - Manhã',
            'C - 8º Ano - All - GEO(10): BACCAEABCA - Tarde'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_23NOV_1: :environment do
          p 'Adding exams'
          datetime = 'Mon, 23 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '4º Bimestre - 2ª Chamada'
          exam_name = 'Prova'
          array = [
            'C - 1ª Série Militar - All - FIS(10) + QUI(10) + BIO(10) + ING(10): CDDEAEDBAE CACAEDEBDB CAEADCCDAA BCBDBCAECC',
            'C - 2ª Série Militar - All - FIS(10) + QUI(10) + BIO(10) + ING(10): ADCCCCECEB BBCCEEBDBB DBDDCAAADE DBCCCECEED',
            'C - 9º Ano Militar - All - FIS(10) + QUI(10) + BIO(10) + ING(10): CDDEAEDBAE CBDBEECECC CAEADCCDAA DCADEDEDDC'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_22NOV: :environment do
          p 'Adding exams'
          datetime = 'Mon, 22 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '4º Bimestre - 2ª Chamada'
          exam_name = 'Prova'
          array = [
            'C - 1ª Série Militar - All - POR(10) + MAT(10) + HIS(10) + GEO(10) + RED(10): BCDBECDBEB DAEEBECBEE DEBAAECBEC CECABEDDBC ADBCDDBAEB',
            'C - 2ª Série Militar - All - POR(10) + MAT(10) + HIS(10) + GEO(10) + GEO(10): BDADDBEEBC ACCCDCAACA CAAEADAACD CDCECCBEDB CECCDEAAEB',
            'C - 9º Ano Militar - All - POR(10) + MAT(10) + HIS(10) + GEO(10) + RED(10): ABDDABEABD DAEEBECBEE DEBAAECBEC CECABEDDBC ADBCDDBAEB'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_23NOV: :environment do
          p 'Adding exams'
          datetime = 'Mon, 23 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'Bolsão 2014 - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM, 1ª Série Militar, 2ª Série ENEM, 2ª Série Militar - All - POR(15) + MAT(15): BAADEDCEBEDACDC DBDDBABBBACEDEA - Manhã',
            'C - 1ª Série ENEM, 1ª Série Militar, 2ª Série ENEM, 2ª Série Militar - All - POR(15) + MAT(15): CBAEAEDECEEBDED DDDBABBABCBEAED - Tarde',
            'C - 6º Ano - All - POR(15) + MAT(15): ECBCDAEECCDBECD BDDEABBDDACEBCD - Manhã',
            'C - 6º Ano - All - POR(15) + MAT(15): ADCDEBAEDDEBECB DEABBDABCEDBDDC - Tarde',
            'C - 7º Ano - All - POR(15) + MAT(15): DCCEDBCECDCACAE BEBBACAADCDBCED - Manhã',
            'C - 7º Ano - All - POR(15) + MAT(15): EDCAECDECECBCBA BBCABECAACDDBDE - Tarde',
            'C - 8º Ano - All - POR(15) + MAT(15): DCCEDBCECDCACAE BEBBACAADCDBCED - Manhã',
            'C - 8º Ano - All - POR(15) + MAT(15): EDCAECDECECBCBA BBCABECAACDDBDE - Tarde',
            'C - 9º Ano Militar, 9º Ano Forte - All - POR(15) + MAT(15): BEEACEBDBBCDECB DDEACDCEAADBCCB - Manhã',
            'C - 9º Ano Militar, 9º Ano Forte - All - POR(15) + MAT(15): CAABDECECBDEACC DAAEDCBCADDCEBC - Tarde',
            'C - AFA/EAAr/EFOMM, EsSA - All - POR(15) + MAT(15): BEEACEBDBBCDECB DDEACDCEAADBCCB - Manhã',
            'C - AFA/EAAr/EFOMM, EsSA - All - POR(15) + MAT(15): CAABDECECBDEACC DAAEDCBCADDCEBC - Tarde',
            'C - AFA/EN/EFOMM, ESPCEX, IME-ITA, AFA/ESPCEX - All - POR(15) + MAT(15): BAADEDCEBEDACDC DDADDCDBDBAAAEA - Manhã',
            'C - AFA/EN/EFOMM, ESPCEX, IME-ITA, AFA/ESPCEX - All - POR(15) + MAT(15): CBBEEEDACEADADE DADBDCBDADADAAE - Tarde',
            'C - Pré-Vestibular Biomédicas, Pré-Vestibular Manhã, Pré-Vestibular Noite - All - POR(15) + MAT(15): DEBCCBBCBEACEAB BCADBECADAABAEA - Manhã',
            'C - Pré-Vestibular Biomédicas, Pré-Vestibular Manhã, Pré-Vestibular Noite - All - POR(15) + MAT(15): EACCCCADCAADAAC BADDCECBAAABAEA - Tarde'
          ]
          create_exams_bolsao(array, datetime, cycle_name, exam_name)
        end
        task add_exams_21NOV_5: :environment do
          p 'Adding exams'
          datetime = 'Mon, 21 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '4º Bimestre - Prova Bimestral - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série Militar - Ilha do Governador - QUI(10) + FIS(10) + RED(10): EBEABCCCBA ADDADBDACE CBDDBCCDCD',
            'C - 2ª Série Militar - Ilha do Governador - QUI(10) + FIS(10) + RED(10): CADBEBBADC BABBEEDBBE ACCADCCBBC',
            'C - 9º Ano Militar - Ilha do Governador - QUI(10) + FIS(10) + RED(10): CAEDEBCCDA ADDADCDACE CBDDBCCDCD'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_21NOV_4: :environment do
          p 'Adding exams'
          datetime = 'Mon, 21 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '4º Bimestre - Prova Bimestral - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série Militar - Ilha do Governador - QUI(10) + FIS(10) + RED(10): EBEABCCCBA ADDADBDACE CBDDBCCDCD',
            'C - 2ª Série Militar - Ilha do Governador, Madureira I - QUI(10) + FIS(10) + RED(10): CADBEBBADC BABBEEDBBE ACCADCCBBC',
            'C - 9º Ano Militar - Ilha do Governador, Madureira III - QUI(10) + FIS(10) + RED(10): CAEDEBCCDA ADDADCDACE CBDDBCCDCD'            
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_21NOV_3: :environment do
          p 'Adding exams'
          datetime = 'Mon, 21 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '4º Bimestre - Prova Bimestral - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série Militar - Tijuca, Madureira III - QUI(10) + FIS(10) + RED(10): EBEABCCCBA ADDADBDACE CBDDBCCDCD',
            'C - 2ª Série Militar - Tijuca, Madureira III - QUI(10) + FIS(10) + RED(10): CADBEBBADC BABBEEDBBE ACCADCCBBC',
            'C - 9º Ano Militar - Tijuca, Madureira I - QUI(10) + FIS(10) + RED(10): CAEDEBCCDA ADDADCDACE CBDDBCCDCD'            
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_21NOV_2: :environment do
          p 'Adding exams'
          datetime = 'Mon, 21 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '4º Bimestre - Prova Bimestral - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série Militar - All - RED(10): CBDDBCCDCD',
            'C - 2ª Série Militar - All - RED(10): ACCADCCBBC',
            'C - 9º Ano Militar - All - RED(10): CBDDBCCDCD',
            'C - 1ª Série Militar - All - QUI(10) + FIS(10): EBEABCCCBA ADDADBDACE',
            'C - 2ª Série Militar - All - QUI(10) + FIS(10): CADBEBBADC BABBEEDBBE',
            'C - 9º Ano Militar - All - QUI(10) + FIS(10): CAEDEBCCDA ADDADCDACE'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_21NOV: :environment do
          p 'Adding exams'
          datetime = 'Mon, 21 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'P8 - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM - All - FIS(10) + ING(10): CBBBCCBEBD DABBCCBEED - Manhã',
            'C - 1ª Série ENEM - All - FIS(10) + ING(10): AAACCEBDAC DBABBEBCCE - Tarde',
            'C - 2ª Série ENEM - All - FIS(10) + ING(10): DDADBEDABD DCCCACAADB - Manhã',
            'C - 2ª Série ENEM - All - FIS(10) + ING(10): ABBBEBBEAB CACAADBDCC - Tarde',
            'C - 6º Ano - All - CIE(10): ACCDCAECBB - Manhã',
            'C - 6º Ano - All - CIE(10): ACCDCAEECB - Tarde',
            'C - 7º Ano - All - CIE(10): EBCDEADADE - Manhã',
            'C - 7º Ano - All - CIE(10): EBCDCADBBE - Tarde',
            'C - 8º Ano - All - CIE(10): CBAEECDCDD - Manhã',
            'C - 8º Ano - All - CIE(10): CCAECECECA - Tarde',
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_19NOV_3: :environment do
          p 'Adding exams'
          datetime = 'Mon, 19 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '4º Bimestre - Prova Bimestral - '
          exam_name = 'Prova'
          array = [
            'C - 9º Ano Forte - All - HIS(10) + FIS(10) + QUI(10) + ING(10):  EADABAEBBE DECCDCBDCD DDBDABDCBA CEBCADCDBA - Manhã',
            'C - 9º Ano Forte - All - HIS(10) + FIS(10) + QUI(10) + ING(10):  DEABABAEEB CDECCDCBDD BDDBDABDCA BCEACCDADB - Tarde',
            'C - Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - POR(15) + LES(4) + MAT(6) + FIS(6) + QUI(6) + BIO(5) + HIS(6) + GEO(10) + FIL(3) + SOC(2):  ABCCAACBCDDAABA BAAC CDCADC DDBBCB CADBBD DABDD CAAAAA BDADCABCCB AAE BA'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_11OUT_3: :environment do
          p 'Adding exams'
          datetime = 'Fri, 11 Oct 2013 14:00:00 BRT -03:00'
          cycle_name = '3º Bimestre - 2ª Chamada (Alternativa) - '
          exam_name = 'Prova'
          array = [
            'C - 9º Ano Militar, 1ª Série Militar - Tijuca - FIS(8) + BIO(8) + HIS(8): ACBECEDA ECDECEEB DCABBAAB'
          ]
          create_exams(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_19NOV_2: :environment do
          p 'Adding exams'
          datetime = 'Mon, 19 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = '4º Bimestre - Prova Bimestral - '
          exam_name = 'Prova'
          array = [
            'C - 9º Ano Militar - All - HIS(10) + GEO(10) + BIO(10): DEBAAECBEC DECCBEDDBC DBDEAEDCDD',
            'C - 1ª Série Militar - All - HIS(10) + GEO(10) + BIO(10): DEBAAECBEC DECCBEDDBC DBDEAEDCDD',
            'C - 2ª Série Militar - All - HIS(10) + GEO(10) + BIO(10): CAAEABAACD CACECCBEBD ABCBAAAABC'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)          
        end
        task add_exams_19NOV: :environment do
          p 'Adding exams'
          datetime = 'Mon, 19 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'P8 - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM - All - GEO(10) + POR(10): CDEECEBADA BCAAECBEBE - Manhã',
            'C - 1ª Série ENEM - All - GEO(10) + POR(10): DCDCBACBDE CBACAEEBEB - Tarde',
            'C - 2ª Série ENEM - All - GEO(10) + POR(10): AEDCEADADB DBACACEEDC - Manhã',
            'C - 2ª Série ENEM - All - GEO(10) + POR(10): DCDBEBEAAA ADBCCEACDE - Tarde',
            'C - 6º Ano - All - POR(10): CBDBABCDCA - Manhã',
            'C - 6º Ano - All - POR(10): DCBBCABADC - Tarde',
            'C - 7º Ano - All - POR(10): CBBDBEECED - Manhã',
            'C - 7º Ano - All - POR(10): BCBBDCEEED - Tarde',
            'C - 8º Ano - All - POR(10): EACBEEBAEE - Manhã',
            'C - 8º Ano - All - POR(10): CEBABEEAEE - Tarde'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)          
        end
        task add_exams_18NOV_4: :environment do
          p 'Adding exams'
          datetime = 'Mon, 18 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'P8 - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM - Madureira II - BIO(10) + LIT(10) + RED(8): CCCCBBADAB ABECDCEABC CDACECAC - Manhã',
            'C - 1ª Série ENEM - Madureira II - BIO(10) + LIT(10) + RED(8): CCECDBADDB BAECABECDC BDDECDAC - Tarde',
            'C - 2ª Série ENEM - Madureira II - BIO(10) + LIT(10) + RED(8): ABDDBBDDEE DACCEEDAAB DDCBCACC - Manhã',
            'C - 2ª Série ENEM - Madureira II - BIO(10) + LIT(10) + RED(8): BBDBBBDAEA BBEEDCDEEA CACBACCA - Tarde',
            'C - 6º Ano - Madureira II - MAT(10) + RED(8): ACDAECACDA EBACBCCD - Manhã',
            'C - 6º Ano - Madureira II - MAT(10) + RED(8): BDEBCABABE BABCBDAC - Tarde',
            'C - 7º Ano - Madureira II - MAT(10) + RED(8): AACBEBCAAD ACBBDEAA - Manhã',
            'C - 7º Ano - Madureira II - MAT(10) + RED(8): CBEABEDBEE BADBADEA - Tarde',
            'C - 8º Ano - Madureira II - MAT(10) + RED(8): DCCDBCADBC ACBEDABA - Manhã',
            'C - 8º Ano - Madureira II - MAT(10) + RED(8): EDBDCABBAD BEAECDAD - Tarde'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)          
        end
        task add_exams_18NOV_3: :environment do
          p 'Adding exams'
          datetime = 'Mon, 18 Nov 2013 14:00:00 BRT -03:00'
          cycle_name = 'P8 - '
          exam_name = 'Prova'
          array = [
            'C - 8º Ano - All - MAT(10): EDBDCABBAD - Tarde'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)          
        end
        task add_exams_18NOV_2: :environment do
           p 'Adding exams'
           datetime = 'Mon, 18 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = 'P8 - '
           exam_name = 'Prova'
           array = [
            'C - 1ª Série ENEM - All - BIO(10) + LIT(10): CCCCBBADAB ABECDCEABC - Manhã',
            'C - 1ª Série ENEM - All - RED(8): CDACECAC - Manhã',
            'C - 1ª Série ENEM - All - BIO(10) + LIT(10): CCECDBADDB BAECABECDC - Tarde',
            'C - 1ª Série ENEM - All - RED(8): BDDECDAC - Tarde',
            'C - 2ª Série ENEM - All - BIO(10) + LIT(10): ABDDBBDDEE DACCEEDAAB - Manhã',
            'C - 2ª Série ENEM - All - RED(8): DDCBCACC - Manhã',
            'C - 2ª Série ENEM - All - BIO(10) + LIT(10): BBDBBBDAEA BBEEDCDEEA - Tarde',
            'C - 2ª Série ENEM - All - RED(8): CACBACCA - Tarde',
            'C - 6º Ano - All - MAT(10): ACDAECACDA - Manhã',
            'C - 6º Ano - All - MAT(10): BDEBCABABE - Tarde',
            'C - 6º Ano - All - RED(8): EBACBCCD - Manhã',
            'C - 6º Ano - All - RED(8): BABCBDAC - Tarde',
            'C - 7º Ano - All - MAT(10): AACBEBCAAD - Manhã',
            'C - 7º Ano - All - MAT(10): CBEABEDBEE - Tarde',
            'C - 7º Ano - All - RED(8): ACBBDEAA - Manhã',
            'C - 7º Ano - All - RED(8): BADBADEA - Tarde',
            'C - 8º Ano - All - MAT(10): DCCDBCADBC - Manhã',
            'C - 8º Ano - All - RED(8): ACBEDABA - Manhã',
            'C - 8º Ano - All - RED(8): BEAECDAD - Tarde'
           ]
           create_exams_school(array, datetime, cycle_name, exam_name)          
        end
         task add_exams_18NOV: :environment do
           p 'Adding exams'
           datetime = 'Mon, 18 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = '4º Bimestre - Prova Bimestral - '
           exam_name = 'Prova'
           array = [
            'C - 1ª Série Militar - All - POR(10) + MAT(10) + ING(10): CDCEAEDADC BDCDBBBADA AECECBBADA',
            'C - 2ª Série Militar - All - POR(10) + MAT(10) + ING(10): EBBDADEACA CCBAAAABBD EBEDBADDED',
            'C - 9º Ano Militar - All - POR(10) + MAT(10) + ING(10): DEDBCDCEEC EDCDBBBCDB CAEDCDBCDA'
           ]
           create_exams_school(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_11NOV_2: :environment do
           p 'Adding exams'
           datetime = 'Mon, 11 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = '4º Bimestre - 2ª Chamada - '
           exam_name = 'Prova'
           array = [
             'C - 3ª Série + AFA/ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8):  BCEDAAEB CDCEAEDA BBBADBEA CECBCDDC DEBAAECD DAECCCBC BEBACAEB ECDAEDDB'
           ]
           create_exams(array, datetime, cycle_name, exam_name)          
         end      
         task add_exams_11NOV: :environment do
           p 'Adding exams'
           datetime = 'Mon, 11 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = '4º Bimestre - 2ª Chamada - '
           exam_name = 'Prova'
           array = [
            'C - 3ª Série + IME-ITA - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8):  BCEDAAEB ECBCBEAE CEABDCAD CEDDDABB DBDBCADA BEAADCBD AEAEEBEA ECDAEDDB',
            'C - 3ª Série + ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8):  BCEDAAEB CDCEAEDA ECCEEEDC CECBCDDC DEBAAEDC DAECCCBC CDBACDAD ECDAEDDB',
            'C - 3ª Série + AFA/ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8):  BCEDAAEB CDCEAEDA BBBADBEA CECBCDDC DEBAAECD DAECCCBC BEBACAEB ECDAEDDB'
           ]
           create_exams(array, datetime, cycle_name, exam_name)          
         end      
         task add_exams_09NOV: :environment do
           p 'Adding exams'
           datetime = 'Mon, 09 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = 'Bolsão 2014 - '
           exam_name = 'Prova'
           array = [
             'C - 1ª Série ENEM, 1ª Série Militar, 2ª Série ENEM, 2ª Série Militar - All - POR(15) + MAT(15):  CACDBCECAECCEDC EEEDECBCECDCDCD - Manhã',
             'C - 1ª Série ENEM, 1ª Série Militar, 2ª Série ENEM, 2ª Série Militar - Bangu, Madureira I, Madureira II, Madureira III, Nova Iguaçu, Tijuca - POR(15) + MAT(15):  DBDECCEDBADCAED DECEEEBECCCDDDC - Tarde',
             'C - 6º Ano - All - POR(15) + MAT(15):  ADBCEEBCBDEEAAD DBBAADCDBCCBBCA - Manhã',
             'C - 6º Ano - Bangu, Madureira I, Madureira II, Madureira III, Nova Iguaçu, Tijuca - POR(15) + MAT(15):  CEBABCEDDDEBBDE CEBEBDCADDDAABB - Tarde',
             'C - 7º Ano, 8º Ano - All - POR(15) + MAT(15):  ACEBABAEDBACADE DBBAADCDBCDBEEC - Manhã',
             'C - 7º Ano, 8º Ano - Bangu, Madureira I, Madureira II, Madureira III, Nova Iguaçu, Tijuca - POR(15) + MAT(15):  BEDDDCABEBCDACB CEBEBDCABDDCDEC - Tarde',
             'C - 9º Ano Militar, 9º Ano Forte - All - POR(15) + MAT(15):  BCDEBCACEABEBCA ABBADCBBDBEEBDD - Manhã',
             'C - 9º Ano Militar, 9º Ano Forte - Bangu, Madureira I, Madureira II, Madureira III, Nova Iguaçu, Tijuca - POR(15) + MAT(15):  CDEABDACABBECDA BEBBAADCBBEDBDD - Tarde',
             'C - AFA/EAAr/EFOMM, AFA/EN/EFOMM, ESPCEX, EsSA, IME-ITA, AFA/ESPCEX - All - POR(15) + MAT(15):  ECBEEDACADDACBA DEDCDEDCEBCEBBB - Manhã',
             'C - AFA/EAAr/EFOMM, AFA/EN/EFOMM, ESPCEX, EsSA, IME-ITA, AFA/ESPCEX - Bangu, Madureira I, Madureira II, Madureira III, Nova Iguaçu, Tijuca - POR(15) + MAT(15):  ADCAAEBDBADBDBB EDDDECECDBECBBB - Tarde',
             'C - Pré-Vestibular Biomédicas, Pré-Vestibular Manhã, Pré-Vestibular Noite - All - POR(15) + MAT(15):  ECBEEDACADDACBA BEDCDEECEECEBBC - Manhã',
             'C - Pré-Vestibular Biomédicas, Pré-Vestibular Manhã, Pré-Vestibular Noite - Bangu, Madureira I, Madureira II, Madureira III, Nova Iguaçu, Tijuca - POR(15) + MAT(15):  DBBDDDEBACDCABD EBCDEEDCCEEEBCB - Tarde'
           ]
           create_exams_bolsao(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_05NOV_3: :environment do
           p 'Adding exams'
           datetime = 'Mon, 05 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = 'P7 (Geografia) - '
           exam_name = 'Prova'
           array = [
             'C - 9º Ano Forte - Campo Grande II - GEO(40): AAAAAAAAAA AAAAAAAAAA AAAAAAAAAA AAAAAACAD - Manhã',
           ]
           create_exams_school(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_05NOV_2: :environment do
           p 'Adding exams'
           datetime = 'Mon, 05 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = 'P7 - '
           exam_name = 'Prova'
           array = [
             'C - 9º Ano Forte - Campo Grande II - POR(10) + MAT(10) + BIO(10) + GEO(10): DEACEBDAEB ACCCCBCDDD CBCDABBBEE ABACDBCAEE - Manhã',
             'C - 9º Ano Forte - Campo Grande II - POR(10) + MAT(10) + BIO(10) + GEO(10): AEDECDBABE CACCBCDCDD CBCADBBBEE BAADCBACEE - Tarde'
           ]
           create_exams_school(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_05NOV: :environment do
           p 'Adding exams'
           datetime = 'Mon, 05 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = 'P7 - '
           exam_name = 'Prova'
           array = [
             'C - 9º Ano Forte - All - POR(10) + MAT(10) + BIO(10) + GEO(10): DEACEBDAEB ACCCCBCDDD CBCDABBBEE ABACDBCAEE',
             'U - 9º Ano Forte - Campo Grande II - POR(10) + MAT(10) + BIO(10) + GEO(10): AEDECDBABE CACCBCDCDD CBCADBBBEE BAADCBACEE'
           ]
           create_exams(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_04NOV_2: :environment do
           p 'Adding exams'
           datetime = 'Mon, 04 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = '4º Bimestre - Prova Bimestral - '
           exam_name = 'Prova'
           array = [
             'C - 3ª Série + AFA/ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): BDDAEBCC BCDBEBAB BEBBDBEC BDEEBECA DEBAAECD EDDDECBD CBDEDDEA DDADBAAA'
           ]
           create_exams(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_04NOV: :environment do
           p 'Adding exams'
           datetime = 'Mon, 04 Nov 2013 14:00:00 BRT -03:00'
           cycle_name = '4º Bimestre - Prova Bimestral - '
           exam_name = 'Prova'
           array = [
             'C - 3ª Série + IME-ITA - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): BDDAEBCC BCDAEBAC ACDBBCAE BDEEBECA DEBAAECD CBCAEDCD AEDEDEDD DDADBAAA',
             'C - 3ª Série + ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): BDDAEBCC BCDBEBAB BEBBDBEC CECBCDDA DEBAAECD ADACDECE EBCBDBAD DDADBAAA',
             'C - 3ª Série + AFA/ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): BDDAEBCC BCDBEBAB BEBBDBEC BDEEBECA DEBAAECD EDDDECBD CBDEDDEA DDADBAAA'
           ]
           create_exams(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_14OUT_3: :environment do
           p 'Adding exams'
           datetime = 'Mon, 14 Oct 2013 14:00:00 BRT -03:00'
           cycle_name = '4º Bimestre - Teste Bimestral - '
           exam_name = 'Prova'
           array = [
             'C - 3ª Série + ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8):  CEADAAEA CBCDDADC CDCACEBD CDEDCCCA DDCCCDDE BEADABDD CBACDDBA EACADCAB'
           ]
           create_exams(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_14OUT_2: :environment do
           p 'Adding exams'
           datetime = 'Mon, 14 Oct 2013 14:00:00 BRT -03:00'
           cycle_name = '4º Bimestre - Teste Bimestral - '
           exam_name = 'Prova'
           array = [
             'C - 3ª Série + AFA/ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8):  CEADAAEA CBCDDADC CDCACEBD CDEDCCCA DDCCCDDE BEADABDD ADAABBDB EACADCAB'
           ]
           create_exams(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_14OUT: :environment do
           p 'Adding exams'
           datetime = 'Mon, 14 Oct 2013 14:00:00 BRT -03:00'
           cycle_name = '4º Bimestre - Teste Bimestral - '
           exam_name = 'Prova'
           array = [
             'C - 3ª Série + IME-ITA - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8):  CEADAAEA CDEBAABC CEDEBEDA CDBABBBD DBCAECEB BEADABDD EBBBCDBC EACADCAB',
             'C - 3ª Série + ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8):  CEADAAEA CBCDDADC CDCACEBD CDEDCCCA DDCCCDDE BEADABDD CBACDDBA EACADCAB',
             'C - 3ª Série + AFA/ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8):  CEADAAEA CBCDDADC CDCACEBD CDEDCCCA DDCCCDDE BEADABDD ADAABBDB EACADCAB'
           ]
           create_exams(array, datetime, cycle_name, exam_name)          
         end
         task add_exams_28OUT: :environment do
          p 'Adding exams'
          datetime = 'Mon, 28 Oct 2013 14:00:00 BRT -03:00'
          cycle_name = 'P7 - '
          exam_name = 'Prova'
          array = [
            'C - 9º Ano Forte - All - QUI(10) + FIS(10) + HIS(10):  DDCEACADCB DAAEDDBCBE ECCCADCCEA - Manhã',
            'C - 9º Ano Forte - All - QUI(10) + FIS(10) + HIS(10):  BDCEDDCAAC ECDEADADBB ACDCCECACE - Tarde'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_29OUT: :environment do
          p 'Adding exams'
          datetime = 'Mon, 29 Oct 2013 14:00:00 BRT -03:00'
          cycle_name = 'Ciclo 4 - Simulado 3 - '
          exam_name = 'Prova'
          array = [
            'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - POR(20) + ING(3) + MAT(25) + FIS(6) + QUI(7) + BIO(5) + HIS(9) + GEO(10) + FIL(1) + SOC(1):  AECBEBEDBCCBADCDBBDE CCB CCBBCDDBBDCDACADBBEBADCAB DABCEE EABBBBD EBCED AABEBAEEE CCAEEEBBBE A D'
          ]
          create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_22OUT: :environment do
          p 'Adding exams'
          datetime = 'Mon, 22 Oct 2013 14:00:00 BRT -03:00'
          cycle_name = '3º Bimestre - 2ª Chamada - '
          exam_name = 'Prova'
          array = [
            'C - ESPCEX ,3ª Série + ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): ACEABEBA ADBAACCA BDDAEBAC BADABBEB EDACBDAC BBCAEABC CBBAEDCD BABCEECE',
            'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): ACEABEBA ADBAACCA BDACDADB BADABBEB EDACBDAC BBCAEABC CDEAEBAA BABCEECE',
            'C - IME-ITA, 3ª Série + IME-ITA - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): ACEABEBA CBDAEBCD CABEACED CDBABDAE EBEDAAED BBCAEABC CDEAEBAA BABCEECE'
          ]
          create_exams(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_25OUT: :environment do
          p 'Adding exams'
          datetime = 'Sun, 25 Out 2013 14:00:00 BRT -03:00'
          cycle_name = 'Simulado EN - '
          exam_name = 'Prova'
          array = [
            'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM, AFA/ESPCEX, 3ª Série + AFA/ESPCEX, IME-ITA, 3ª Série + IME-ITA - All - MAT(20) + FIS(20): CCCADCDABADCEDABBBBA DBAEABACCEDBAAEBBCDD'
          ]
          create_exams(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_24OUT: :environment do
          p 'Adding exams'
          datetime = 'Sun, 24 Out 2013 14:00:00 BRT -03:00'
          cycle_name = 'Simulado EN - '
          exam_name = 'Prova'
          array = [
            'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM, AFA/ESPCEX, 3ª Série + AFA/ESPCEX, IME-ITA, 3ª Série + IME-ITA - All - POR(20) + ING(20): BAAEDAEDACBBCDADCBDE AEACADCEBBECABDEACCD'
          ]
          create_exams(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_16OUT: :environment do
          p 'Adding exams'
          datetime = 'Sun, 16 Out 2013 14:00:00 BRT -03:00'
          cycle_name = 'Concurso interno - IME - '
          exam_name = 'Prova'
          array = [
            'C - 2ª Série Militar - All - MAT(15) + FIS(15) + QUI(10): EDBCDBAECDDAEBD BDDCCCABCAACEDC CBDEDAACED',
            'U - 2ª Série Militar - Madureira III - MAT(15) + FIS(15) + QUI(10): ACAEBECADABCACB AEABEABDECEABBA BEEABCEADA'
          ]
          create_exams(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_11OUT_2: :environment do
          p 'Adding exams'
          datetime = 'Sun, 11 Out 2013 14:00:00 BRT -03:00'
          cycle_name = '3º Bimestre - 2ª Chamada'
          exam_name = 'Prova'
          array = [
            'C - 9º Ano Militar, 1ª Série Militar - All - HIS(8) + FIS(8) + QUI(8) + BIO(8): AAAAAAAA AAAAAAAA AAAAAAAA AAAAAAAA'
          ]
          create_exams(array, datetime, cycle_name, exam_name)
        end      

        task add_exams_11OUT: :environment do
          p 'Adding exams'
          datetime = 'Sun, 11 Out 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 3º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM - All - MAT(10) + BIO(10): DDBDBCCEEE BCECBDDABA',
            'C - 2ª Série ENEM - All - MAT(10) + BIO(0): EBECAECEAD ',
            'C - 6º Ano - All - MAT(10): DBEAECCDBD',
            'C - 7º Ano - All - MAT(10): EDDACBADAD',
            'C - 8º Ano - All - MAT(10): DCDDDDDBEA'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_10OUT: :environment do
          p 'Adding exams'
          datetime = 'Sun, 10 Out 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 3º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM - All - FIS(10) + LIT(10): AEAECECCDDCCCEDEADAE',
            'C - 2ª Série ENEM - All - FIS(10) + LIT(10): BEBEABECEDDAABDCCCEB',
            'C - 6º Ano - All - POR(10): DECBCBCCDD',
            'C - 7º Ano - All - POR(10): BACDBDDEBB',
            'C - 8º Ano - All - POR(10): BDBCDCDDEB'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_09OUT: :environment do
          p 'Adding exams'
          datetime = 'Sun, 09 Out 2013 14:00:00 BRT -03:00'
          cycle_name = 'Recuperação - 3º Bimestre - '
          exam_name = 'Prova'
          array = [
            'C - 1ª Série ENEM - All - HIS(10) + QUI(10): CBABEBBCDE CDCBDCABAA',
            'C - 2ª Série ENEM - All - HIS(10) + QUI(10): CCAEBBDABA ADBCEEAADD',
            'C - 6º Ano - All - CIE(10) + HIS(10): DACEBCDEAA AACDCBCBAC',
            'C - 7º Ano - All - CIE(10) + HIS(10): BBECBABACE ADCCBAEBCA',
            'C - 8º Ano - All - CIE(10) + HIS(10): ECBDDEBBAC ABECDBDBAC'
          ]
          create_exams_school(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_19OUT: :environment do
          p 'Adding exams'
          datetime = 'Sun, 19 Oct 2013 14:00:00 BRT -03:00'
          cycle_name = 'Bolsão 2014 - '
          exam_name = 'Prova'
          array = [
            'C - 6º Ano - All - MAT(15) + POR(15): ECBCDAEECCBDECD BDDEABBDDACEBCD - Manhã',
            'C - 7º Ano, 8º Ano - All - MAT(15) + POR(15): DCCEDBCECDCACAE BEBBACAADCDBCED - Manhã',
            'C - 9º Ano Militar, 9º Ano Forte - All - MAT(15) + POR(15): BEEACEBDBBCDECB DDEACDCEAADBCCB - Manhã',
            'C - 1ª Série ENEM, 1ª Série Militar, 2ª Série ENEM, 2ª Série Militar - All - MAT(15) + POR(15): BAADEDCEBEDACDC DBDDBABBBACEDEA - Manhã',
            'C - AFA/EAAr/EFOMM, AFA/EN/EFOMM, ESPCEX, EsSA, IME-ITA, AFA/ESPCEX - All - MAT(15) + POR(15): BAADEDCEBEDACDC DDADDCDBDBAAAEA - Manhã',
            'C - Pré-Vestibular Biomédicas, Pré-Vestibular Manhã, Pré-Vestibular Noite - All - MAT(15) + POR(15): DEBCCBBCBEACEAB BCADBECADAABAEA - Manhã',
            'C - 6º Ano - All - MAT(15) + POR(15): ADCDEBAEDDEBECB DEABBDABCEDBDDC - Tarde',
            'C - 7º Ano, 8º Ano - All - MAT(15) + POR(15): EDCAECDECECBCBA BBCABECAACDDBDE - Tarde',
            'C - 9º Ano Militar, 9º Ano Forte - All - MAT(15) + POR(15): CAABDECECBDEACC DAAEDCBCADDCEBC - Tarde',
            'C - 1ª Série ENEM, 1ª Série Militar, 2ª Série ENEM, 2ª Série Militar - All - MAT(15) + POR(15): CBAEAEDECEEBDED DDDBABBABCBEAED - Tarde',
            'C - AFA/EAAr/EFOMM, AFA/EN/EFOMM, ESPCEX, EsSA, IME-ITA, AFA/ESPCEX - All - MAT(15) + POR(15): CBBEEEDACEADADE DADBDCBDADADAAE - Tarde',
            'C - Pré-Vestibular Biomédicas, Pré-Vestibular Manhã, Pré-Vestibular Noite - All - MAT(15) + POR(15): EACCCCADCAADAAC BADDCECBAAABAEA - Tarde'
          ]
          create_exams_bolsao(array, datetime, cycle_name, exam_name)
        end      
        task add_exams_08OUT: :environment do
        p 'Adding exams'
        datetime = 'Sun, 08 Out 2013 14:00:00 BRT -03:00'
        cycle_name = 'Recuperação - 3º Bimestre - '
        exam_name = 'Prova'
        array = [
          'C - 1ª Série ENEM - All - GEO(10) + POR(10): EAECDBBBCE EACADCDDAB',
          'C - 2ª Série ENEM - All - GEO(10) + POR(10): BCAEDCBEBC BAECEDCADC',
          'C - 6º Ano - All - GEO(10): EADACCDACB',
          'C - 7º Ano - All - GEO(10): EABDAACABC',
          'C - 8º Ano - All - GEO(10): AACADCACAB'
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_02OUT_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 02 Out 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 6º Ano - All - RED(8): ACDDBCCA - Manhã',
          'C - 6º Ano - All - RED(8): EBCEADAB - Tarde',
          'C - 7º Ano - All - RED(8): BECDEBAB - Manhã',
          'C - 7º Ano - All - RED(8): BABCDCBA - Tarde',
          'C - 8º Ano - All - RED(8): ADBCECDB - Manhã',
          'C - 8º Ano - All - RED(8): DAEACECB - Tarde'
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_06OUT: :environment do
        p 'Adding exams'
        datetime = 'Sun, 06 Out 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 4 - '
        exam_name = '2º Simulado'
        array = [
          'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - LES(5) + POR(40) + MAT(45): BCABE DADDDEBBCAEAAACAEDBAADCCACABAACADCEDDACE DCADDBECADEDDDCEBDBEACEECCBDDADCECCAAECDABEBA',
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_05OUT: :environment do
        p 'Adding exams'
        datetime = 'Sun, 05 Out 2013 14:00:00 BRT -03:00'
        cycle_name = 'Simulado Especial - '
        exam_name = '2º Simulado'
        array = [
          'C - 9º Ano Militar - All - MAT(20): DCBDCBAEEBEDDBCACCDB',
          'C - 1ª Série Militar - All - MAT(20): DCBDCBAEEBEDDBCACCDB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        cycle_name = 'Ciclo 4 - '
        exam_name = '1º Simulado'
        array = [
          'C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - HIS(18) + GEO(27) + BIO(15) + QUI(15) + FIS(15): DAECDDBECECDDDABDA ADCECBDDBADDACACCDDAEBECADD ABADDDBACAAEECE ECDBEACEDEDBADE EACECCEECDCBAED',
          'C - 2ª Série Militar - All - HIS(10) + GEO(10) + BIO(10) + QUI(10): BCCBDCEBEA CECECCEBDD BCBEABCECC ADEBCCBCDA',
          'U - 2ª Série Militar - Madureira III - HIS(10) + GEO(9) + BIO(10) + QUI(10): DABEABDACD CBACAABACA AECACEADAB BCAEAEABAE'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        cycle_name = '3º Bimestre - '
        exam_name = 'Substitutiva P5/P6'
        array = [
          'C - 9º Ano Forte - All - BIO(10) + FIS(10) + GEO(10) + HIS(10) + ING(10) + MAT(10) + POR(10) + QUI(10): DEABCCBBAA BACDCDDCBB DDCBBAECBE BABADBDDAC CBBAACACAC BAADDCCAEC BACABBADDC ACCCBBAECD'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        cycle_name = 'Ciclo 6 - '
        exam_name = '2º Simulado'
        array = [
          'C - IME-ITA, 3ª Série + IME-ITA - All - MAT(15) + QUI(8) + FIS(15): CCEDECEDABDECCA EEAAABCDA BECEDBACDDBCEEA'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_04OUT: :environment do
        p 'Adding exams'
        datetime = 'Sun, 04 Out 2013 14:00:00 BRT -03:00'
        cycle_name = '3º Bimestre - '
        exam_name = '2ª Chamada'
        array = [
          'C - 1ª Série Militar - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): EAEECCCA DCBCDBAA ABADDEEB BEDBDEAA DBCAECEB CBCCBCEC EBDBAABC DDDBBCCA',
          'C - 9º Ano Militar - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): EAEECCCA DCBCDBAA ADEBCEDB BEDBDEAA DBCAECEB CBCCBCEC AEBDCACB DDDBBCCA'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_16SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 16 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 1ª Série ENEM - All - FIL(10): DCACBADBDA - Tarde',
          'C - 1ª Série ENEM - All - SOC(10): BACDDCDBEC - Tarde',
          'C - 1ª Série ENEM - All - FIL(10): CDAADBCCAE - Manhã',
          'C - 1ª Série ENEM - All - SOC(10): EEDAEBABCD - Manhã',
          'C - 2ª Série ENEM - All - FIL(10): DCBABDCABD - Manhã',
          'C - 2ª Série ENEM - All - SOC(10): EDCCADDDAB - Manhã',
          'C - 2ª Série ENEM - All - FIL(10): DAABBACABD - Tarde',
          'C - 2ª Série ENEM - All - SOC(10): BECAEDCCAE - Tarde'
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_02OUT: :environment do
        p 'Adding exams'
        datetime = 'Sun, 02 Out 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 1ª Série ENEM - All - EDF(10): ACEEDCABCD - Manhã',
          'C - 1ª Série ENEM - All - EDF(10): DAECBADBAB - Tarde',
          'C - 1ª Série ENEM - All - RED(8): CECCEBDA - Manhã',
          'C - 1ª Série ENEM - All - RED(8): EBCEBCEC - Tarde',
          'C - 2ª Série ENEM - All - EDF(10): BDEAEDBCDE - Manhã',
          'C - 2ª Série ENEM - All - EDF(10): DAEEBADEAB - Tarde',
          'C - 2ª Série ENEM - All - RED(8): CCDAAECD - Manhã',
          'C - 2ª Série ENEM - All - RED(8): EBCEBDEA - Tarde',
          'C - 6º Ano - All - ESP(10): BEEACBDABC - Manhã',
          'C - 6º Ano - All - ESP(10): AECDDCBEBA - Tarde',
          'C - 6º Ano - All - ING(10): ABABCABAEB - Manhã',
          'C - 6º Ano - All - ING(10): DACAABBBEB - Tarde',
          'C - 7º Ano - All - ESP(10): EBDCADBEEB - Manhã',
          'C - 7º Ano - All - ESP(10): DAABBADDCE - Tarde',
          'C - 7º Ano - All - ING(10): ADBEEABCBA - Manhã',
          'C - 7º Ano - All - ING(10): AAEBCDDBCA - Tarde',
          'C - 8º Ano - All - ESP(10): DCAADBBEAC - Manhã',
          'C - 8º Ano - All - ESP(10): ABDECACDCE - Tarde',
          'C - 8º Ano - All - ING(10): ACBDABCDDC - Manhã',
          'C - 8º Ano - All - ING(10): ADBDAEBCAB - Tarde'
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_27SET_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 27 Set 2013 14:00:00 BRT -03:00'
        cycle_name = '3º Bimestre - '
        exam_name = 'Prova Bimestral'
        array = [
          'C - 2ª Série Militar - All - GEO(8) + HIS(8) + QUI(8) + BIO(8): CDCABCEC DEACEDBC AAACCCBD BDEEADCD'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_26SET_3: :environment do
        p 'Adding exams'
        datetime = 'Sun, 26 Set 2013 14:00:00 BRT -03:00'
        cycle_name = '3º Bimestre - '
        exam_name = 'Prova Bimestral'
        array = [
          'C - 2ª Série Militar - All - MAT(8) + POR(8) + ING(8) + FIS(8): ABCDCDAB DBEBDDBB CBABEAEE DAACCDCE',
          'C - AFA/EFOMM/ESPCEX, 3ª Série + AFA/EFOMM/ESPCEX, ESPCEX, 3ª Série + ESPCEX - All - GEO(8) + HIS(8) + QUI(8) + BIO(8): ACDBCDDB EDACBABB EDEECEEB BBEEEBCD'                                              
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_25SET_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 25 Set 2013 14:00:00 BRT -03:00'
        cycle_name = '3º Bimestre - '
        exam_name = 'Prova Bimestral'
        array = [
          'C - AFA/EFOMM/ESPCEX, 3 Série + AFA/EFOMM/ESPCEX, ESPCEX ,3ª Série + ESPCEX - All - MAT(8) + POR(8) + ING(8) + FIS(8): CDBEECBA CADAECAE BCABBAEE BCBCCDCE'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_30SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 30 Set 2013 14:00:00 BRT -03:00'
        cycle_name = '3º Bimestre - '
        exam_name = 'Prova Bimestral'
        array = [
          'C - 1ª Série Militar - All - FIS(8) + GEO(8) + HIS(8) + QUI(8): BCEADBBA BBEABACE BBBEDADC ADEDDCAA',
          'C - 1ª Série Militar - All - QUI(8): CCAEBDDB',
          'C - CN/EPCAR, 9º Ano Militar - All - FIS(8) + GEO(8) + HIS(8) + QUI(8): BCEADBBA BBEABACE BBBEDADC ADEDDCAA',
          'C - CN/EPCAR, 9º Ano Militar - All - QUI(8): CCAEBDDB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_28SET_4: :environment do
        p 'Adding exams'
        datetime = 'Sun, 28 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 4 - '
        exam_name = 'Simulado'
        array = [
          'C - AFA/EAAr/EFFOM - All - POR(25) + ING(25) + MAT(25) + FIS(25): BDBDABCDCBDCDBDEAACCBEBED CAEDCDBCEEBECCECDEAECCDBD CADBCACDEACBCBBDBEBADDEBD AECDADDDCDABECDDEADDCDCEC'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_28SET_3: :environment do
        p 'Adding exams'
        datetime = 'Sun, 28 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 6 - '
        exam_name = 'Simulado'
        array = [
          'C - IME-ITA, 3ª Série + IME-ITA - All - MAT(15) + QUI(10) + FIS(15): EDADEAEDDDDBABA BDBACCEDDA BDEACDCDBCEACEA' 
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_28SET_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 28 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 10 - '
        exam_name = 'Simulado'
        array = [
          'C - EsSA - All - MAT(12) + POR(12) + HIS(6) + GEO(6): BBBBDCBBCECE CECCDAECDBCB DDEECC EECAEB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
         task add_exams_28SET_1: :environment do
        p 'Adding exams'
        datetime = 'Sun, 28 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [ 
          'C - 9º Ano Forte - All - POR(10) + BIO(10) + MAT(10) + GEO(10): DCBCEEDEEA BACEACBCEB BACDEDAABD BBCBBAAEDE'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_28SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 28 Set 2013 14:00:00 BRT -03:00'
        cycle_name = '3º Bimestre - '
        exam_name = 'Prova Bimestral'
        array = [
          'C - 2ª Série Militar - All - POR(8) + MAT(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8) + ING(8): BACEDCCB EACCBEAA DACABCEC AAECBEBE BBCEADEA ECDAECAE DAABBCAC BDEEBDDA',
          'C - 1ª Série Militar - All - MAT(8) + BIO(8) + ING(8) + POR(8): DDDBACBB BDBEBDBC BCDBCECC DAEBAECA',
          'C - 9º Ano Militar - All - MAT(8) + BIO(8) + ING(8) + POR(8): DDDBACBB BDBEBDBC BCAEDADE DAEBAECA',
          'C - IME-ITA, 3ª Série + IME-ITA - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): BDBBBAAD BCEADEDB AECDBEBE EEBCBDDA DDEAACDD DBAEACAA DDAEBBDC BBEEEBCD'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
        end
        task add_exams_27SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 27 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 1ª Série ENEM - All - ESP(10) + MAT(10): AEBBDCCAEE CEABAACEEB - Tarde',
          'C - 2ª Série ENEM - All - ESP(10) + MAT(10): CBCDCEDEAA DEBBBDDABE - Tarde',
          'C - 6º Ano - All - HIS(10): EABCECEBBC - Tarde',
          'C - 7º Ano - All - HIS(10): AABAACBAEB - Tarde',
          'C - 8º Ano - All - HIS(10): DABECBBCBC - Tarde',
          'C - 1ª Série ENEM - All - ESP(10) + MAT(10): ACDABDABBA EBBDCCEBBB - Manhã',
          'C - 2ª Série ENEM - All - ESP(10) + MAT(10): EDCCCEECBA DBDDBCACDB - Manhã',
          'C - 6º Ano - All - HIS(10): CEEEBBCAEA - Manhã',
          'C - 7º Ano - All - HIS(10): AABAAADAAA - Manhã',
          'C - 8º Ano - All - HIS(10): ABABDCDACD - Manhã' 
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_26SET_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 26 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 1ª Série ENEM - All - HIS(10) + QUI(10): ABCBBADCAC DCDCEAEDBE - Tarde',
          'C - 2ª Série ENEM - All - HIS(10) + QUI(10): BCEDBCDAAC BACABECDCE - Tarde',
          'C - 6º Ano - All - GEO(10): AEDABDCAAB - Tarde',
          'C - 7º Ano - All - GEO(10): DCACBBAACB - Tarde',
          'C - 8º Ano - All - GEO(10): AEEEBBDAAD - Tarde' 
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_26SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 26 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 1ª Série ENEM - All - HIS(10) + QUI(10): CCCCBEBECE EBEBABCACA - Manhã',
          'C - 2ª Série ENEM - All - HIS(10) + QUI(10): CEDDBACAEC DBCECCAEDD - Manhã',
          'C - 6º Ano - All - GEO(10): CDABABCEEB - Manhã',
          'C - 7º Ano - All - GEO(10): BDABDBECAB - Manhã',
          'C - 8º Ano - All - GEO(10): DAEDAAAABE - Manhã'
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
        end
        task add_exams_25SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 25 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 1ª Série ENEM - All - FIS(10) + ING(10): BAADDBBBDD DABDCECBBA - Manhã',
          'U - 1ª Série ENEM - São Gonçalo II - FIS(10) + ING(10): BAADDBBBDD DABDCECBBA - Manhã',
          'C - 1ª Série ENEM - All - FIS(10) + ING(10): EDCECDDEDA DAADEEBCCA - Tarde',
          'C - 2ª Série ENEM - All - FIS(10) + ING(10): AEEEAADCDD BDDCDDBDAE - Manhã',
          'C - 2ª Série ENEM - All - FIS(10) + ING(10): ACAEBBEBEE DCCDDDCEBA - Tarde',
          'C - 6º Ano - All - CIE(10): DABCEECCAA - Manhã',
          'U - 6º Ano - Bangu - CIE(10): DABCEECCAA - Manhã',
          'C - 6º Ano - All - CIE(10): DCBCEEACAA - Tarde',
          'C - 7º Ano - All - CIE(10): EDACDEADAA - Manhã',
          'C - 7º Ano - All - CIE(10): EDACADADAA - Tarde',
          'C - 8º Ano - All - CIE(10): CAACEDBCBA - Manhã',
          'C - 8º Ano - All - CIE(10): CBBCBCAECA - Tarde'
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
      end
      task add_exams_24SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 24 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 6º Ano - All - POR(10): BBEACCDCEA - Manhã',
          'C - 6º Ano - All - POR(10): BEBCADCACE - Tarde',
          'C - 7º Ano - All - POR(10): CEBEBEACBE - Manhã',
          'C - 7º Ano - All - POR(10): AECEBEBEBC - Tarde',
          'C - 8º Ano - All - POR(10): DBBAEDCCBE - Manhã',
          'C - 8º Ano - All - POR(10): BDAEBCDEBC - Tarde',
          'C - 1ª Série ENEM - All - POR(10) + GEO(10): AADBCDAEBE BDEDCCEABD - Manhã',
          'C - 1ª Série ENEM - All - POR(10) + GEO(10): BCDAEBEAAD BEEABDAABD - Tarde',
          'C - 2ª Série ENEM - All - POR(10) + GEO(10): EBCCDABECD CECEBECADE - Manhã',
          'C - 2ª Série ENEM - All - POR(10) + GEO(10): CEBCBDDACE DBBACEADCE - Tarde'
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
      end
      task add_exams_23SET_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 23 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 8º Ano - All - MAT(10): CAEBDAECCB - Tarde',
          'C - 8º Ano - All - MAT(10): EADAEDADAA - Manhã',
          'C - 7º Ano - All - MAT(10): ACDABACAEB - Tarde',
          'C - 7º Ano - All - MAT(10): ADABACBBAC - Manhã',
          'C - 6º Ano - All - MAT(10): CCAACEDEDC - Tarde',
          'C - 1ª Série ENEM - All - BIO(10) + LIT(10): BEDBDAAEAE DDECAAEADE - Manhã',
          'C - 1ª Série ENEM - All - BIO(10) + LIT(10): BDDEDBACAE AEADEDECDA - Tarde',
          'C - 2ª Série ENEM - All - BIO(10) + LIT(10): BAABCACDBE CCBACDCABA - Manhã',
          'C - 2ª Série ENEM - All - BIO(10) + LIT(10): BEABBCCDBA DCCDDBBAAA - Tarde'
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
      end
      task add_exams_23SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 23 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'P6 - '
        exam_name = 'Prova'
        array = [
          'C - 6º Ano - All - MAT(10): AAAAAAAAAA - Manhã'
        ]
        create_exams_school(array, datetime, cycle_name, exam_name)
      end
      task add_exams_21SET_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 21 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          'C - 9º Ano Militar - All - MAT(20): AAAAAAAAAAAAAAAAAAAA',
          'C - 1ª Série Militar - All - MAT(20): AAAAAAAAAAAAAAAAAAAA'
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end
      task add_exams_21SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 21 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          'C - AFA/EAAr/EFOMM - All - MAT(25) + POR(25) + FIS(25) + ING(25): DCDCCAADDDBDCBDBCBABDCBBD DABADCBCBDABADDDAACBDBCAC DABCBCAADADABABDACBDAAACD DCDCBCAADCABADDAADCAAACBC',
          'C - 9º Ano Forte - All - QUI(10) + FIS(10) + HIS(10) + ING(10): ECEABCEBDE DCDCDDADCA BDBCDADEBB ACADACCAED',
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - POR(20) + ING(20): BEBBDACDCCEEBAADBBAA DCACAACBCAEBEDEBABAD',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - POR(20) + ING(20): BEBBDACDCCEEBAADBBAA DCACAACBCAEBEDEBABAD',
          'C - IME-ITA, 3ª Série + IME-ITA - POR(15) + ING(25): BDEAADCACBAEBAD CECEAEDBCABCEACBDDACACBDC'
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end      
      task add_exams_20SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 20 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          'C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM, AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + FIS(20): BEBDCDAACEDBBBCEDDDC ACEDDDEBCADEEDADCBDC',
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end      
      task add_exams_17SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 17 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 3 - '
        exam_name = 'Simulado 5'
        array = [
          'C - 2ª Série Militar - All - MAT(10) + FIS(10) + POR(10) + ING(10): CBCCCCEAEA DDCDEADEBC CCAEECCEAC BCCABCACAA',
          'U - 2ª Série Militar - Madureira I - MAT(10) + FIS(10) + POR(10) + ING(10): DCADEECBBC EABABCACCB BECBBAEBDD DAEEDADEED'
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end      
      task add_exams_14SET: :environment do
        p 'Adding exams'
        datetime = 'Sun, 14 Set 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 7 - '
        exam_name = 'Simulado 2'
        array = [
          'C - AFA/EAAr/EFOMM - All - MAT(25) + POR(25) + FIS(25) + ING(25): CBBABCCDACAABBBDAEDECDBDB CEBADBCEDACDBBCEDDDABBACC CBABADAADBCCDDBCDDBBACBBD BABDDCABABDCEADACDBDBDECD',
          'C - EsSA - All - MAT(12) + POR(12) + HIS(6) + GEO(6): AAAAAAAAAAAA ABEDBECECACC CAABEA AACAAD',
          'C - 1ª Série Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): BADBDCABECCEDCCABEDE EACAAD EBEDAC CBDEDE CAAEEA EBBDBE',
          'C - 9º Ano Militar - All - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): BADBDCABECCEDCCABEDE EACAAD EBEDAC CBDEDE EDCECE EBBDBE',
          'U - 1ª Série Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): CDAECAEDBABBBAECECAC BCBEBA CDCABA ECACAD ABEDAC EDCAAC',
          'U - 9º Ano Militar - Madureira III - POR(20) + GEO(6) + HIS(6) + FIS(6) + QUI(6) + BIO(6): DEACBAEEABDABDAEDABA AEDCBA ACBADA ADAACB AEBCAB EDEACB'
        ]
        create_exams(array, datetime, cycle_name, exam_name)        
      end
      task add_exams_19AUG: :environment do
        p 'Adding exams'
        datetime = 'Sun, 19 Aug 2013 14:00:00 BRT -03:00'
        cycle_name = '3º Bimestre - '
        exam_name = 'Teste Bimestral'
        array = [
          'C - IME-ITA, 3ª Série + IME-ITA - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): BCEEECAC BCDDADAB DCBDBDAB CBCDADAE BACBEBEC DBACDEEC BAECCABC DBBDAEDE',
          'C - ESPCEX, 3ª Série + ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): BCEEECAC DCBAECBD ABCECBAC ACBDBABC CBEBBCEA EDDCEDCE BDACBCBE DBBDAEDE',
          'C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(8) + POR(8) + ING(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8): BCEEECAC DCBAECBD ABCECBAC ACBDBABC CBEBBCEA EDDCEDCE BDACBCBE DBBDAEDE'
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_31AUG: :environment do
        p 'Adding exams'
        datetime = 'Sun, 31 Aug 2013 14:00:00 BRT -03:00'
        cycle_name = 'Ciclo 1 - '
        exam_name = 'Simulado'
        array = [
          "C - AFA/EAAr/EFOMM - All - MAT(25) + POR(25) + FIS(25) + ING(25): AAECDCBEDCBADDDCDDDAABCAC ACECEBEBCDBDAEBCADBCEDDAA CADACCBDBABBDCBDBCBADDADD BABAEAAABCDEDECBDAECAACEB",
          "C - AFA/EN/EFOMM, 3ª Série + AFA/EN/EFOMM - All - MAT(20) + FIS(20): AAAAAAAAAAAAAAAAAAAA BBECACABCDBDABBBDDAE",
          "C - 1ª Série Militar - All - MAT(20): DADCBCADEDDBDABBECEA",
          "U - 1ª Série Militar - Madureira III - MAT(20): ADAEEDCACBBEADEEBDCB",
          "C - 9º Ano Militar - All - MAT(20): DADCBCADEDDBDABBECEA",
          "U - 9º Ano Militar - Madureira III - MAT(20): ADAEEDCACBBEADEEBDCB",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): ECCDDBDDCDBEDBCAEBCA DAEEECAEEDAE BACAEAACCDCD ACEDBBDEAAAC",
          "C - ESPCEX, 3ª Série + ESPCEX - All - MAT(20) + HIS(12) + GEO(12) + ING(12): ECCDDBDDCDBEDBCAEBCA DAEEECAEEDAE BACAEAACCDCD ACEDBBDEAAAC",
          "C - Pré-Vestibular Manhã, 3ª Série + Pré-Vestibular Manhã, Pré-Vestibular Biomédicas, 3ª Série + Pré-Vestibular Biomédicas, Pré-Vestibular Noite - All - POR(15) + LES(6) + MAT(6) + FIS(6) + QUI(6) + BIO(5) + HIS(6) + GEO(10): BDADCDCABDCDABB ABBDCD CBCCAC CBDABD BDADBC DCDCC ADBAAA DAAABDCCAC",
          "C - 2ª Série Militar - All - QUI(10) + HIS(10) + GEO(10) + BIO(10): BADDECBAEA ADABEBEBED DDBCEAECEE DABEDECADA",
          "U - 2ª Série Militar - Madureira I - QUI(10) + HIS(10) + GEO(10) + BIO(10): CEAEABECBC EBCDACDACA CBCEDCBABD ACECABAEBC",
          "C - AFA/ESPCEX, 3ª Série + AFA/ESPCEX - All - MAT(20) + FIS(20):  AAAAAAAAAAAAAAAAAAAA BBECACABCDBDABBBDDAE"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_24AUG_2: :environment do
        p 'Adding exams'
        datetime = 'Sun, 24 Aug 2013 14:00:00 BRT -03:00'
        cycle_name = '3º Bimestre - '
        exam_name = 'P5'
        array = [
          "C - 9º Ano Forte - All - POR(10) + BIO(10) + MAT(10) + GEO(10): DADCDDEDAC ACBCCADACA AEDBDCBDAD CCDABACCAA"
        ]
        create_exams(array, datetime, cycle_name, exam_name)
      end
      task add_exams_24AUG: :environment do
        p 'Adding exams'
        datetime = 'Sun, 24 Aug 2013 14:00:00 BRT -03:00'
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
          "C - 9º Ano Militar - All - POR(8) + MAT(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8) + ING(8): AADDDCCC BABAADED AAAAAEEE BBADDEAE ADABBBDD CDBBCAAC BABCCBCC DCEACADD",
          "C - 1ª Série Militar - All - POR(8) + MAT(8) + GEO(8) + HIS(8) + FIS(8) + QUI(8) + BIO(8) + ING(8):  AADDDCCC BABAADED AAAAAEEE BBADDEAE ADABBBDD CDBBCAAC BABCCBCC CEBCBCBB",
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

      def create_exams_school(array, datetime, cycle_name, exam_name)
        ActiveRecord::Base.transaction do 
          array.each do |line|
            action, product_names, campus_names, exam_attributes, shift = line.split(' - ')
            product_names = product_names.gsub(/ \(\S*\)/, '')
            p product_names
            product_years = product_names.split(', ').map do |p| ProductYear.where(name: p + ' - 2013').first! end
            campuses = (campus_names == 'All' ? Campus.all : Campus.where(name: campus_names.split(', ')))
            subjects, correct_answers = exam_attributes.split(': ')
            p subjects
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
              if shift.nil?
                shift_string = ''
              else
                shift_string = " (#{shift})"
              end
              exam_cycle = ExamCycle.where(
                name: cycle_name + product_year.product.name + shift_string + " - #{subjects}").first_or_create!(
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

      def create_exams_bolsao(array, datetime, cycle_name, exam_name)
        ActiveRecord::Base.transaction do 
          array.each do |line|
            action, product_names, campus_names, exam_attributes, shift = line.split(' - ')
            product_names = product_names.gsub(/ \(\S*\)/, '')
            p product_names
            product_years = product_names.split(', ').map do |p| ProductYear.where(name: p + ' - 2014').first! end
            campuses = (campus_names == 'All' ? Campus.all : Campus.where(name: campus_names.split(', ')))
            subjects, correct_answers = exam_attributes.split(': ')
            p subjects
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
              if shift.nil?
                shift_string = ''
              else
                shift_string = "#{shift} - "
              end              
              exam_cycle = ExamCycle.where(
                name: cycle_name + shift_string + product_year.product.name + " - #{subjects}").first_or_create!(
                is_bolsao: true, product_year_id: product_year.id)

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