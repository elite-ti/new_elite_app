# encoding: UTF-8

namespace :product_year do

  task populate_erp_code_on_product_year: :environment do
    set_product_years_erp_code('Não regular - 2014', 'Não regular')
    set_product_years_erp_code('1ª Série Militar - 2014', '1ª Série Militar')
    set_product_years_erp_code('1ª Série ENEM - 2014', '1ª Série ENEM')
    set_product_years_erp_code('2ª Série Militar - 2014', '2ª Série Militar')
    set_product_years_erp_code('2ª Série ENEM - 2014', '2ª Série ENEM')
    set_product_years_erp_code('3ª Série + ESPCEX - 2014', '3ª Série + ESPCEX')
    set_product_years_erp_code('3ª Série + IME-ITA - 2014', '3ª SÉRIE IME/ITA')
    set_product_years_erp_code('3ª Série + Pré-Vestibular Biomédicas - 2014', '3ª SÉRIE BIOMÉDICA')
    set_product_years_erp_code('3ª Série + Pré-Vestibular Manhã - 2014', '3ª Série + Pré-Vestibular Manhã')
    set_product_years_erp_code('6º Ano - 2014', '6º Ano')
    set_product_years_erp_code('7º Ano - 2014', '7º Ano')
    set_product_years_erp_code('8º Ano - 2014', '8º Ano')
    set_product_years_erp_code('9º Ano Forte - 2014', '9º Ano Forte')
    set_product_years_erp_code('9º Ano Militar - 2014', '9º Ano Militar')
    set_product_years_erp_code('AFA/EAAr/EFOMM - 2014', 'AFA/EEAr/EFOMM')
    set_product_years_erp_code('AFA/EN/EFOMM - 2014', 'AFA/EN/EFOMM')
    set_product_years_erp_code('ESPCEX - 2014', 'ESPCEX')
    set_product_years_erp_code('EsSA - 2014', 'EsSA')
    set_product_years_erp_code('IME-ITA - 2014', 'IME/ITA')
    set_product_years_erp_code('IME-ITA Especial - 2014', 'IME-ITA Especial')
    set_product_years_erp_code('Pré-Vestibular Biomédicas - 2014', 'BIOMÉDICA')
    set_product_years_erp_code('Pré-Vestibular Manhã - 2014', 'Pré-Vestibular Manhã')
    set_product_years_erp_code('Pré-Vestibular Noite - 2014', 'Pré-Vestibular Noite')
    set_product_years_erp_code('AFA/ESPCEX - 2014', 'AFA/EFOMM/EsPCEx')
    set_product_years_erp_code('CN/EPCAR - 2014', 'COLÉGIO NAVAL/EPCAR')
    set_product_years_erp_code('Escolas Técnicas - 2014', 'Escolas Técnicas')
    set_product_years_erp_code('3ª Série + AFA/ESPCEX - 2014', '3ª SÉRIE AFA/EFOMM/EsPCEx')
    set_product_years_erp_code('3ª Série + AFA/EN/EFOMM - 2014', '3ª Série + AFA/EN/EFOMM')
  end

  task populate_erp_code_on_campus: :environment do
    set_campus_erp_code("Bangu", "11")
    set_campus_erp_code("Campo Grande I", "13")
    set_campus_erp_code("Campo Grande II", "12")
    set_campus_erp_code("Ilha do Governador", "18")
    set_campus_erp_code("Madureira I", "6")
    set_campus_erp_code("Madureira II", "7")
    set_campus_erp_code("Madureira III", "9")
    set_campus_erp_code("NorteShopping", "1")
    set_campus_erp_code("Nova Iguaçu", "14")
    set_campus_erp_code("São Gonçalo I", "3")
    set_campus_erp_code("São Gonçalo II", "2")
    set_campus_erp_code("Taquara", "16")
    set_campus_erp_code("Tijuca", "4")
    set_campus_erp_code("Valqueire", "8")
  end  

  task populate_status_on_student: :environment do
    total = Student.all.size
    count = 0
    Student.where("id > 0").includes(:enrollments).each do |student|
      count = count + 1
      p "#{count}/#{total}"
      if student.enrollments.select{|enrollment| enrollment.status == "Matriculado"}.size == 0
        student.status = "Inativo"
      else
        student.status = "Ativo"
      end
      student.save
    end
  end
end

def set_product_years_erp_code(product_year_name, erp_code)
  py = ProductYear.find_by_name(product_year_name)
  py.erp_code = erp_code
  py.save
end

def set_campus_erp_code(campus_name, erp_code)
  campus = Campus.find_by_name(campus_name)
  campus.erp_code = erp_code
  campus.save
end