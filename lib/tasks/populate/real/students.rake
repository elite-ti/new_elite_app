# encoding: UTF-8
namespace :db do
  namespace :populate do
    namespace :real do 
      task students: :environment do
        p 'Populating students'
        ActiveRecord::Base.transaction do 
          read_csv('students').map do |campus_name, student_name, product_campus_turno|
            Student.create!(name: student_name.strip)

            campus = find_campus(campus_name)

            product_name, campus_name, turno = product_campus_turno.split('-').map(&:strip)
            product = find_product(product_name)
            turno_code = translate_turno(turno)

            if product.present? and campus.present? and turno_code.present?

            end
          end
        end
      end

      def find_campus(campus_name)
        campus_name = {
          "Elite Bangu" => 'Bangu',
          "Elite Campo Grande I" => 'Campo Grande I',
          "Elite Campo Grande II" => 'Campo Grande II',
          "Elite Ilha do Governador" => 'Ilha do Governador',
          "Elite Madureira I" => 'Madureira I',
          "Elite Madureira II" => 'Madureira II',
          "Elite Madureira III" => 'Madureira III',
          "Elite Norte Shopping" => 'Norte Shopping',
          "Elite Nova Iguaçu" => 'Nova Iguaçu',
          "Elite São Gonçalo I" => 'São Gonçalo I',
          "Elite São Gonçalo II" => 'São Gonçalo II',
          "Elite Taquara" => 'Taquara',
          "Elite Tijuca I" => 'Tijuca',
          "Elite Vila Valqueire" => 'Valqueire',
          "NAO INFORMADO" => nil
        }[campus_name]

        return nil if campus_name.nil?
        Campus.where(name: campus_name).first!
      end

      def find_product(product_name)
        product_name = {
          "1ª ANO" => '1ª Série ENEM',
          "1ª ANO MILITAR" => '1ª Série Militar',
          "1ª SERIE" => '1ª Série ENEM',
          "1ª SERIE MILITAR" => '1ª Série Militar',
          "1ª SÉRIE" => '1ª Série ENEM',
          "1ª SÉRIE ENEM" => '1ª Série ENEM',
          "1º  SERIE ENEM" => '1ª Série ENEM',
          "1º ANO" => '1ª Série ENEM',
          "1º ANO MILITAR" => '1ª Série Militar',
          "1º SERIE" => '1ª Série ENEM',
          "1º SERIE ENEM" => '1ª Série ENEM',
          "1º SERIE MILITAR" => '1ª Série Militar',
          "2ª SERIE ENEM" => '2ª Série ENEM',
          "2ª SERIE MILITAR" => '2ª Série Militar',
          "2ª SÉRIE MILITAR" => '2ª Série Militar',
          "2º  SERIE" => '2ª Série ENEM',
          "2º  SERIE ENEM" => '2ª Série ENEM',
          "2º ANO" => '2ª Série ENEM',
          "2º ANO MILITAR" => '2ª Série Militar',
          "2º SERIE" => '2ª Série ENEM',
          "2º SERIE ENEM" => '2ª Série ENEM',
          "2º SERIE MILITAR" => '2ª Série Militar',
          "3 º ANO BIO" => '3ª Série + Pré-Vestibular Biomédicas',
          "3 º SERIE PRE VESTIBULAR" => '3ª Série + Pré-Vestibular Manhã',
          "3ª SERIE AF/EF/EsP" => '',
          "3ª SERIE BIOMEDICA" => '3ª Série + Pré-Vestibular Biomédicas',
          "3ª SERIE MILITAR" => '',
          "3ª SERIE PRE" => '3ª Série + Pré-Vestibular Manhã',
          "3ª SÉRIE AF/EF/EsPCEX" => '',
          "3ª SÉRIE PRÉ MILITAR" => '',
          "3º  SERIE PRE" => '3ª Série + Pré-Vestibular Manhã',
          "3º ANO BIO" => '3ª Série + Pré-Vestibular Biomédicas',
          "3º ANO BIOMEDICA" => '3ª Série + Pré-Vestibular Biomédicas',
          "3º ANO PRE" => '3ª Série + Pré-Vestibular Manhã',
          "3º SERIE BIO" => '3ª Série + Pré-Vestibular Biomédicas',
          "3º SERIE PRE" => '3ª Série + Pré-Vestibular Manhã',
          "6 ª ANO" => '6º Ano',
          "6ª ANO" => '6º Ano',
          "6ª ANO NORTE SHOPPING" => '6º Ano',
          "6º ANO" => '6º Ano',
          "7ª" => '7º Ano',
          "7ª ANO" => '7º Ano',
          "7ª ANO NORTE SHOPPING" => '7º Ano',
          "7º ANO" => '7º Ano',
          "8ª  ANO" => '8º Ano',
          "8ª ANO" => '8º Ano',
          "9 ª ANO MILITAR" => '9º Ano Militar',
          "9ª ANO" => '',
          "9ª ANO FORTE" => '9º Ano Forte',
          "9ª ANO MILITAR" => '9º Ano Militar',
          "9º  ANO FORTE" => '9º Ano Forte',
          "9º ANO MILITAR" => '9º Ano Militar',
          "AF/EE/EF" => '',
          "AF/EF/Es" => '',
          "AF/EF/EsP" => '',
          "AF/EF/EsPCEX" => '',
          "AF/EN/EF" => '',
          "AF/EN/EsP" => '',
          "CN/EPCAR" => '',
          "CN/EPCAr" => '',
          "CN/EPICAR" => '',
          "ET" => '',
          "EsPCEx" => 'ESPCEX',
          "EsSA" => 'EsSA',
          "EsSa" => 'EsSA',
          "IME/ITA" => 'IME-ITA',
          "PV" => '',
          "PVBIO" => 'Pré-Vestibular Biomédicas',
          "SEM TURMA" => nil
        }[product_name]

        return nil if product_name.nil?
        Product.where(name: product_name).first!
      end

      def translate_turno(turno)
        {
          "MANHA" => '',
          "MANHÃ" => '',
          "NOITE" => '',
          "NOME_TURMA" => '',
          "TARDE" => '',
          "VILA VALQUEIRE" => ''
        }[turno]
      end
    end
  end
end

# Third row campuses
# "ANO VILA VALQUEIRE"
# "BAGU"
# "BANGU"
# "CAMPO GRANDE"
# "CAMPO GRANDE 1"
# "CAMPO GRANDE 2"
# "CAMPO GRANDE I"
# "CAMPO GRANDE II"
# "ILHA"
# "ILHA DO GOVERNADOR"
# "MADUREIRA"
# "MADUREIRA 1"
# "MADUREIRA 2"
# "MADUREIRA 3"
# "MADUREIRA I"
# "MADUREIRA II"
# "MADUREIRA III"
# "MANHÃ"
# "MILITAR"
# "MILITAR ILHA DO GOVERNADOR"
# "NORTE SHOPPING"
# "NOVA IGUAÇU"
# "SAO GONÇALO II"
# "SÃO GONÇALO"
# "SÃO GONÇALO  1"
# "SÃO GONÇALO 1"
# "SÃO GONÇALO 2"
# "SÃO GONÇALO I"
# "SÃO GONÇALO II"
# "TAQUARA"
# "TIJUCA"
# "TIJUCA 1"
# "TIJUCA I"
# "VESTIBULAR"
# "VILA VALQUEIRE"
# "VILA VALQUIERE"
