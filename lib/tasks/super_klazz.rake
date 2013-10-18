# encoding: UTF-8

namespace :super_klazz do
  task create_2014_super_klazzes: :environment do
    ActiveRecord::Base.transaction do 
      p ['Pré-Vestibular Manhã','Campo Grande I'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','Campo Grande I')
      p ['8º Ano','Campo Grande II'].join ' - '
      create_super_klazz('8º Ano','Campo Grande II')
      p ['Pré-Vestibular Manhã','Campo Grande II'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','Campo Grande II')
      p ['Pré-Vestibular Biomédicas','Campo Grande I'].join ' - '
      create_super_klazz('Pré-Vestibular Biomédicas','Campo Grande I')
      p ['Pré-Vestibular Manhã','Bangu'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','Bangu')
      p ['1ª Série Militar','Bangu'].join ' - '
      create_super_klazz('1ª Série Militar','Bangu')
      p ['1ª Série ENEM','Bangu'].join ' - '
      create_super_klazz('1ª Série ENEM','Bangu')
      p ['7º Ano','Campo Grande II'].join ' - '
      create_super_klazz('7º Ano','Campo Grande II')
      p ['1ª Série ENEM','Campo Grande II'].join ' - '
      create_super_klazz('1ª Série ENEM','Campo Grande II')
      p ['9º Ano Forte','Campo Grande II'].join ' - '
      create_super_klazz('9º Ano Forte','Campo Grande II')
      p ['AFA/EN/EFOMM','Bangu'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','Bangu')
      p ['ESPCEX','Bangu'].join ' - '
      create_super_klazz('ESPCEX','Bangu')
      p ['9º Ano Militar','Bangu'].join ' - '
      create_super_klazz('9º Ano Militar','Bangu')
      p ['6º Ano','Bangu'].join ' - '
      create_super_klazz('6º Ano','Bangu')
      p ['7º Ano','Bangu'].join ' - '
      create_super_klazz('7º Ano','Bangu')
      p ['1ª Série Militar','Campo Grande II'].join ' - '
      create_super_klazz('1ª Série Militar','Campo Grande II')
      p ['9º Ano Militar','Campo Grande I'].join ' - '
      create_super_klazz('9º Ano Militar','Campo Grande I')
      p ['AFA/EN/EFOMM','Campo Grande I'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','Campo Grande I')
      p ['2ª Série Militar','Campo Grande I'].join ' - '
      create_super_klazz('2ª Série Militar','Campo Grande I')
      p ['EsSA','Campo Grande I'].join ' - '
      create_super_klazz('EsSA','Campo Grande I')
      p ['Pré-Vestibular Noite','Campo Grande I'].join ' - '
      create_super_klazz('Pré-Vestibular Noite','Campo Grande I')
      p ['6º Ano','Campo Grande II'].join ' - '
      create_super_klazz('6º Ano','Campo Grande II')
      p ['2ª Série ENEM','Bangu'].join ' - '
      create_super_klazz('2ª Série ENEM','Bangu')
      p ['9º Ano Forte','Bangu'].join ' - '
      create_super_klazz('9º Ano Forte','Bangu')
      p ['1ª Série Militar','Campo Grande I'].join ' - '
      create_super_klazz('1ª Série Militar','Campo Grande I')
      p ['AFA/EAAr/EFOMM','Campo Grande I'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Campo Grande I')
      p ['8º Ano','Bangu'].join ' - '
      create_super_klazz('8º Ano','Bangu')
      p ['2ª Série Militar','Bangu'].join ' - '
      create_super_klazz('2ª Série Militar','Bangu')
      p ['2ª Série ENEM','Campo Grande II'].join ' - '
      create_super_klazz('2ª Série ENEM','Campo Grande II')
      p ['ESPCEX','Campo Grande I'].join ' - '
      create_super_klazz('ESPCEX','Campo Grande I')
      p ['IME-ITA','Campo Grande I'].join ' - '
      create_super_klazz('IME-ITA','Campo Grande I')
      p ['Pré-Vestibular Noite','Madureira III'].join ' - '
      create_super_klazz('Pré-Vestibular Noite','Madureira III')
      p ['2ª Série ENEM','Madureira II'].join ' - '
      create_super_klazz('2ª Série ENEM','Madureira II')
      p ['8º Ano','Madureira II'].join ' - '
      create_super_klazz('8º Ano','Madureira II')
      p ['1ª Série ENEM','Madureira II'].join ' - '
      create_super_klazz('1ª Série ENEM','Madureira II')
      p ['EsSA','Madureira I'].join ' - '
      create_super_klazz('EsSA','Madureira I')
      p ['IME-ITA','Madureira I'].join ' - '
      create_super_klazz('IME-ITA','Madureira I')
      p ['9º Ano Forte','Madureira I'].join ' - '
      create_super_klazz('9º Ano Forte','Madureira I')
      p ['2ª Série Militar','Madureira I'].join ' - '
      create_super_klazz('2ª Série Militar','Madureira I')
      p ['7º Ano','Madureira II'].join ' - '
      create_super_klazz('7º Ano','Madureira II')
      p ['6º Ano','Madureira II'].join ' - '
      create_super_klazz('6º Ano','Madureira II')
      p ['Pré-Vestibular Manhã','Madureira I'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','Madureira I')
      p ['ESPCEX','Madureira III'].join ' - '
      create_super_klazz('ESPCEX','Madureira III')
      p ['9º Ano Militar','Madureira III'].join ' - '
      create_super_klazz('9º Ano Militar','Madureira III')
      p ['Pré-Vestibular Biomédicas','Madureira I'].join ' - '
      create_super_klazz('Pré-Vestibular Biomédicas','Madureira I')
      p ['1ª Série Militar','Madureira III'].join ' - '
      create_super_klazz('1ª Série Militar','Madureira III')
      p ['AFA/EN/EFOMM','Madureira III'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','Madureira III')
      p ['AFA/EAAr/EFOMM','Madureira III'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Madureira III')
      p ['9º Ano Forte','Nova Iguaçu'].join ' - '
      create_super_klazz('9º Ano Forte','Nova Iguaçu')
      p ['1ª Série ENEM','Nova Iguaçu'].join ' - '
      create_super_klazz('1ª Série ENEM','Nova Iguaçu')
      p ['9º Ano Militar','Nova Iguaçu'].join ' - '
      create_super_klazz('9º Ano Militar','Nova Iguaçu')
      p ['2ª Série ENEM','Nova Iguaçu'].join ' - '
      create_super_klazz('2ª Série ENEM','Nova Iguaçu')
      p ['1ª Série Militar','Nova Iguaçu'].join ' - '
      create_super_klazz('1ª Série Militar','Nova Iguaçu')
      p ['2ª Série Militar','Nova Iguaçu'].join ' - '
      create_super_klazz('2ª Série Militar','Nova Iguaçu')
      p ['Pré-Vestibular Noite','Nova Iguaçu'].join ' - '
      create_super_klazz('Pré-Vestibular Noite','Nova Iguaçu')
      p ['Pré-Vestibular Manhã','Nova Iguaçu'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','Nova Iguaçu')
      p ['Pré-Vestibular Biomédicas','Nova Iguaçu'].join ' - '
      create_super_klazz('Pré-Vestibular Biomédicas','Nova Iguaçu')
      p ['AFA/EN/EFOMM','Nova Iguaçu'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','Nova Iguaçu')
      p ['ESPCEX','Nova Iguaçu'].join ' - '
      create_super_klazz('ESPCEX','Nova Iguaçu')
      p ['AFA/EAAr/EFOMM','Nova Iguaçu'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Nova Iguaçu')
      p ['1ª Série Militar','Valqueire'].join ' - '
      create_super_klazz('1ª Série Militar','Valqueire')
      p ['AFA/EN/EFOMM','Valqueire'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','Valqueire')
      p ['ESPCEX','Valqueire'].join ' - '
      create_super_klazz('ESPCEX','Valqueire')
      p ['8º Ano','Valqueire'].join ' - '
      create_super_klazz('8º Ano','Valqueire')
      p ['Pré-Vestibular Manhã','Valqueire'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','Valqueire')
      p ['1ª Série ENEM','Taquara'].join ' - '
      create_super_klazz('1ª Série ENEM','Taquara')
      p ['2ª Série ENEM','Valqueire'].join ' - '
      create_super_klazz('2ª Série ENEM','Valqueire')
      p ['9º Ano Militar','Valqueire'].join ' - '
      create_super_klazz('9º Ano Militar','Valqueire')
      p ['7º Ano','Valqueire'].join ' - '
      create_super_klazz('7º Ano','Valqueire')
      p ['6º Ano','Valqueire'].join ' - '
      create_super_klazz('6º Ano','Valqueire')
      p ['Pré-Vestibular Biomédicas','Valqueire'].join ' - '
      create_super_klazz('Pré-Vestibular Biomédicas','Valqueire')
      p ['2ª Série Militar','Valqueire'].join ' - '
      create_super_klazz('2ª Série Militar','Valqueire')
      p ['9º Ano Forte','Taquara'].join ' - '
      create_super_klazz('9º Ano Forte','Taquara')
      p ['6º Ano','Taquara'].join ' - '
      create_super_klazz('6º Ano','Taquara')
      p ['8º Ano','Taquara'].join ' - '
      create_super_klazz('8º Ano','Taquara')
      p ['1ª Série ENEM','Valqueire'].join ' - '
      create_super_klazz('1ª Série ENEM','Valqueire')
      p ['Pré-Vestibular Manhã','Taquara'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','Taquara')
      p ['1ª Série Militar','Taquara'].join ' - '
      create_super_klazz('1ª Série Militar','Taquara')
      p ['2ª Série Militar','Taquara'].join ' - '
      create_super_klazz('2ª Série Militar','Taquara')
      p ['AFA/EAAr/EFOMM','Taquara'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Taquara')
      p ['9º Ano Forte','Valqueire'].join ' - '
      create_super_klazz('9º Ano Forte','Valqueire')
      p ['7º Ano','Taquara'].join ' - '
      create_super_klazz('7º Ano','Taquara')
      p ['Pré-Vestibular Biomédicas','Taquara'].join ' - '
      create_super_klazz('Pré-Vestibular Biomédicas','Taquara')
      p ['ESPCEX','Taquara'].join ' - '
      create_super_klazz('ESPCEX','Taquara')
      p ['9º Ano Militar','Taquara'].join ' - '
      create_super_klazz('9º Ano Militar','Taquara')
      p ['AFA/EN/EFOMM','Taquara'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','Taquara')
      p ['2ª Série ENEM','Taquara'].join ' - '
      create_super_klazz('2ª Série ENEM','Taquara')
      p ['Pré-Vestibular Noite','Taquara'].join ' - '
      create_super_klazz('Pré-Vestibular Noite','Taquara')
      p ['2ª Série ENEM','Ilha do Governador'].join ' - '
      create_super_klazz('2ª Série ENEM','Ilha do Governador')
      p ['Pré-Vestibular Manhã','Ilha do Governador'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','Ilha do Governador')
      p ['Pré-Vestibular Manhã','Tijuca'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','Tijuca')
      p ['ESPCEX','Tijuca'].join ' - '
      create_super_klazz('ESPCEX','Tijuca')
      p ['6º Ano','NorteShopping'].join ' - '
      create_super_klazz('6º Ano','NorteShopping')
      p ['9º Ano Forte','NorteShopping'].join ' - '
      create_super_klazz('9º Ano Forte','NorteShopping')
      p ['8º Ano','NorteShopping'].join ' - '
      create_super_klazz('8º Ano','NorteShopping')
      p ['AFA/EAAr/EFOMM','Ilha do Governador'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Ilha do Governador')
      p ['1ª Série Militar','Ilha do Governador'].join ' - '
      create_super_klazz('1ª Série Militar','Ilha do Governador')
      p ['Pré-Vestibular Noite','Ilha do Governador'].join ' - '
      create_super_klazz('Pré-Vestibular Noite','Ilha do Governador')
      p ['Pré-Vestibular Noite','Tijuca'].join ' - '
      create_super_klazz('Pré-Vestibular Noite','Tijuca')
      p ['1ª Série ENEM','NorteShopping'].join ' - '
      create_super_klazz('1ª Série ENEM','NorteShopping')
      p ['1ª Série ENEM','Tijuca'].join ' - '
      create_super_klazz('1ª Série ENEM','Tijuca')
      p ['Pré-Vestibular Manhã','NorteShopping'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','NorteShopping')
      p ['1ª Série Militar','Tijuca'].join ' - '
      create_super_klazz('1ª Série Militar','Tijuca')
      p ['8º Ano','Tijuca'].join ' - '
      create_super_klazz('8º Ano','Tijuca')
      p ['AFA/EAAr/EFOMM','Tijuca'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Tijuca')
      p ['9º Ano Militar','Ilha do Governador'].join ' - '
      create_super_klazz('9º Ano Militar','Ilha do Governador')
      p ['ESPCEX','NorteShopping'].join ' - '
      create_super_klazz('ESPCEX','NorteShopping')
      p ['2ª Série ENEM','NorteShopping'].join ' - '
      create_super_klazz('2ª Série ENEM','NorteShopping')
      p ['1ª Série ENEM','Ilha do Governador'].join ' - '
      create_super_klazz('1ª Série ENEM','Ilha do Governador')
      p ['9º Ano Militar','Tijuca'].join ' - '
      create_super_klazz('9º Ano Militar','Tijuca')
      p ['2ª Série Militar','Tijuca'].join ' - '
      create_super_klazz('2ª Série Militar','Tijuca')
      p ['Pré-Vestibular Biomédicas','Tijuca'].join ' - '
      create_super_klazz('Pré-Vestibular Biomédicas','Tijuca')
      p ['AFA/EN/EFOMM','Ilha do Governador'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','Ilha do Governador')
      p ['ESPCEX','Ilha do Governador'].join ' - '
      create_super_klazz('ESPCEX','Ilha do Governador')
      p ['7º Ano','Tijuca'].join ' - '
      create_super_klazz('7º Ano','Tijuca')
      p ['2ª Série ENEM','Tijuca'].join ' - '
      create_super_klazz('2ª Série ENEM','Tijuca')
      p ['6º Ano','Tijuca'].join ' - '
      create_super_klazz('6º Ano','Tijuca')
      p ['9º Ano Forte','Tijuca'].join ' - '
      create_super_klazz('9º Ano Forte','Tijuca')
      p ['7º Ano','NorteShopping'].join ' - '
      create_super_klazz('7º Ano','NorteShopping')
      p ['IME-ITA','Tijuca'].join ' - '
      create_super_klazz('IME-ITA','Tijuca')
      p ['Pré-Vestibular Biomédicas','NorteShopping'].join ' - '
      create_super_klazz('Pré-Vestibular Biomédicas','NorteShopping')
      p ['AFA/EN/EFOMM','NorteShopping'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','NorteShopping')
      p ['1ª Série Militar','NorteShopping'].join ' - '
      create_super_klazz('1ª Série Militar','NorteShopping')
      p ['9º Ano Militar','NorteShopping'].join ' - '
      create_super_klazz('9º Ano Militar','NorteShopping')
      p ['2ª Série Militar','NorteShopping'].join ' - '
      create_super_klazz('2ª Série Militar','NorteShopping')
      p ['AFA/EAAr/EFOMM','São Gonçalo I'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','São Gonçalo I')
      p ['Pré-Vestibular Noite','São Gonçalo I'].join ' - '
      create_super_klazz('Pré-Vestibular Noite','São Gonçalo I')
      p ['AFA/EN/EFOMM','São Gonçalo I'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','São Gonçalo I')
      p ['ESPCEX','São Gonçalo I'].join ' - '
      create_super_klazz('ESPCEX','São Gonçalo I')
      p ['9º Ano Militar','São Gonçalo I'].join ' - '
      create_super_klazz('9º Ano Militar','São Gonçalo I')
      p ['1ª Série Militar','São Gonçalo I'].join ' - '
      create_super_klazz('1ª Série Militar','São Gonçalo I')
      p ['2ª Série Militar','São Gonçalo I'].join ' - '
      create_super_klazz('2ª Série Militar','São Gonçalo I')
      p ['Pré-Vestibular Manhã','São Gonçalo I'].join ' - '
      create_super_klazz('Pré-Vestibular Manhã','São Gonçalo I')
      p ['1ª Série ENEM','São Gonçalo II'].join ' - '
      create_super_klazz('1ª Série ENEM','São Gonçalo II')
      p ['2ª Série ENEM','São Gonçalo II'].join ' - '
      create_super_klazz('2ª Série ENEM','São Gonçalo II')
      p ['7º Ano','São Gonçalo II'].join ' - '
      create_super_klazz('7º Ano','São Gonçalo II')
      p ['8º Ano','São Gonçalo II'].join ' - '
      create_super_klazz('8º Ano','São Gonçalo II')
      p ['6º Ano','São Gonçalo II'].join ' - '
      create_super_klazz('6º Ano','São Gonçalo II')
      p ['9º Ano Forte','São Gonçalo II'].join ' - '
      create_super_klazz('9º Ano Forte','São Gonçalo II')
      p ['IME-ITA Especial','Madureira III'].join ' - '
      create_super_klazz('IME-ITA Especial','Madureira III')
      p ['IME-ITA Especial','Tijuca'].join ' - '
      create_super_klazz('IME-ITA Especial','Tijuca')
      p ['3ª Série + ESPCEX','Bangu'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','Bangu')
      p ['3ª Série + ESPCEX','Campo Grande I'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','Campo Grande I')
      p ['3ª Série + ESPCEX','Madureira III'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','Madureira III')
      p ['3ª Série + ESPCEX','Nova Iguaçu'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','Nova Iguaçu')
      p ['3ª Série + ESPCEX','Valqueire'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','Valqueire')
      p ['3ª Série + ESPCEX','Taquara'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','Taquara')
      p ['3ª Série + ESPCEX','Tijuca'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','Tijuca')
      p ['3ª Série + ESPCEX','NorteShopping'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','NorteShopping')
      p ['3ª Série + ESPCEX','Ilha do Governador'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','Ilha do Governador')
      p ['3ª Série + ESPCEX','São Gonçalo I'].join ' - '
      create_super_klazz('3ª Série + ESPCEX','São Gonçalo I')
      p ['3ª Série + IME-ITA','Campo Grande I'].join ' - '
      create_super_klazz('3ª Série + IME-ITA','Campo Grande I')
      p ['3ª Série + IME-ITA','Madureira I'].join ' - '
      create_super_klazz('3ª Série + IME-ITA','Madureira I')
      p ['3ª Série + IME-ITA','Tijuca'].join ' - '
      create_super_klazz('3ª Série + IME-ITA','Tijuca')
      p ['3ª Série + Pré-Vestibular Biomédicas','Campo Grande I'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Biomédicas','Campo Grande I')
      p ['3ª Série + Pré-Vestibular Biomédicas','Madureira I'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Biomédicas','Madureira I')
      p ['3ª Série + Pré-Vestibular Biomédicas','Nova Iguaçu'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Biomédicas','Nova Iguaçu')
      p ['3ª Série + Pré-Vestibular Biomédicas','Valqueire'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Biomédicas','Valqueire')
      p ['3ª Série + Pré-Vestibular Biomédicas','Taquara'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Biomédicas','Taquara')
      p ['3ª Série + Pré-Vestibular Biomédicas','Tijuca'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Biomédicas','Tijuca')
      p ['3ª Série + Pré-Vestibular Biomédicas','NorteShopping'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Biomédicas','NorteShopping')
      p ['3ª Série + Pré-Vestibular Manhã','Campo Grande I'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','Campo Grande I')
      p ['3ª Série + Pré-Vestibular Manhã','Campo Grande II'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','Campo Grande II')
      p ['3ª Série + Pré-Vestibular Manhã','Bangu'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','Bangu')
      p ['3ª Série + Pré-Vestibular Manhã','Madureira I'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','Madureira I')
      p ['3ª Série + Pré-Vestibular Manhã','Nova Iguaçu'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','Nova Iguaçu')
      p ['3ª Série + Pré-Vestibular Manhã','Valqueire'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','Valqueire')
      p ['3ª Série + Pré-Vestibular Manhã','Taquara'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','Taquara')
      p ['3ª Série + Pré-Vestibular Manhã','Ilha do Governador'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','Ilha do Governador')
      p ['3ª Série + Pré-Vestibular Manhã','Tijuca'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','Tijuca')
      p ['3ª Série + Pré-Vestibular Manhã','NorteShopping'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','NorteShopping')
      p ['3ª Série + Pré-Vestibular Manhã','São Gonçalo I'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Manhã','São Gonçalo I')
      p ['AFA/ESPCEX','Madureira I'].join ' - '
      create_super_klazz('AFA/ESPCEX','Madureira I')
      p ['AFA/ESPCEX','NorteShopping'].join ' - '
      create_super_klazz('AFA/ESPCEX','NorteShopping')
      p ['AFA/ESPCEX','Nova Iguaçu'].join ' - '
      create_super_klazz('AFA/ESPCEX','Nova Iguaçu')
      p ['AFA/ESPCEX','Ilha do Governador'].join ' - '
      create_super_klazz('AFA/ESPCEX','Ilha do Governador')
      p ['AFA/ESPCEX','Bangu'].join ' - '
      create_super_klazz('AFA/ESPCEX','Bangu')
      p ['AFA/ESPCEX','Taquara'].join ' - '
      create_super_klazz('AFA/ESPCEX','Taquara')
      p ['AFA/ESPCEX','Valqueire'].join ' - '
      create_super_klazz('AFA/ESPCEX','Valqueire')
      p ['CN/EPCAR','Campo Grande I'].join ' - '
      create_super_klazz('CN/EPCAR','Campo Grande I')
      p ['AFA/ESPCEX','São Gonçalo I'].join ' - '
      create_super_klazz('AFA/ESPCEX','São Gonçalo I')
      p ['3ª Série + AFA/ESPCEX','Madureira I'].join ' - '
      create_super_klazz('3ª Série + AFA/ESPCEX','Madureira I')
      p ['9º Ano Militar','Projeto Colibri'].join ' - '
      create_super_klazz('9º Ano Militar','Projeto Colibri')
      p ['AFA/EN/EFOMM','Tijuca'].join ' - '
      create_super_klazz('AFA/EN/EFOMM','Tijuca')
      p ['2ª Série Militar','Ilha do Governador'].join ' - '
      create_super_klazz('2ª Série Militar','Ilha do Governador')
      p ['2ª Série Militar','São Gonçalo II'].join ' - '
      create_super_klazz('2ª Série Militar','São Gonçalo II')
      p ['6º Ano','Ilha do Governador'].join ' - '
      create_super_klazz('6º Ano','Ilha do Governador')
      p ['7º Ano','Ilha do Governador'].join ' - '
      create_super_klazz('7º Ano','Ilha do Governador')
      p ['8º Ano','Ilha do Governador'].join ' - '
      create_super_klazz('8º Ano','Ilha do Governador')
      p ['9º Ano Forte','Ilha do Governador'].join ' - '
      create_super_klazz('9º Ano Forte','Ilha do Governador')
      p ['AFA/EAAr/EFOMM','Campo Grande I'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Campo Grande I')
      p ['AFA/EAAr/EFOMM','Ilha do Governador'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Ilha do Governador')
      p ['AFA/EAAr/EFOMM','Madureira III'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Madureira III')
      p ['AFA/EAAr/EFOMM','Nova Iguaçu'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Nova Iguaçu')
      p ['AFA/EAAr/EFOMM','São Gonçalo I'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','São Gonçalo I')
      p ['AFA/EAAr/EFOMM','Taquara'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Taquara')
      p ['AFA/EAAr/EFOMM','Tijuca'].join ' - '
      create_super_klazz('AFA/EAAr/EFOMM','Tijuca')
      p ['AFA/ESPCEX','Bangu'].join ' - '
      create_super_klazz('AFA/ESPCEX','Bangu')
      p ['AFA/ESPCEX','Madureira III'].join ' - '
      create_super_klazz('AFA/ESPCEX','Madureira III')
      p ['AFA/ESPCEX','Ilha do Governador'].join ' - '
      create_super_klazz('AFA/ESPCEX','Ilha do Governador')
      p ['AFA/ESPCEX','NorteShopping'].join ' - '
      create_super_klazz('AFA/ESPCEX','NorteShopping')
      p ['AFA/ESPCEX','São Gonçalo I'].join ' - '
      create_super_klazz('AFA/ESPCEX','São Gonçalo I')
      p ['AFA/ESPCEX','Taquara'].join ' - '
      create_super_klazz('AFA/ESPCEX','Taquara')
      p ['AFA/ESPCEX','Valqueire'].join ' - '
      create_super_klazz('AFA/ESPCEX','Valqueire')
      p ['EsSA','Bangu'].join ' - '
      create_super_klazz('EsSA','Bangu')
      p ['EsSA','Ilha do Governador'].join ' - '
      create_super_klazz('EsSA','Ilha do Governador')
      p ['EsSA','Madureira III'].join ' - '
      create_super_klazz('EsSA','Madureira III')
      p ['EsSA','Nova Iguaçu'].join ' - '
      create_super_klazz('EsSA','Nova Iguaçu')
      p ['EsSA','São Gonçalo I'].join ' - '
      create_super_klazz('EsSA','São Gonçalo I')
      p ['EsSA','Taquara'].join ' - '
      create_super_klazz('EsSA','Taquara')
      p ['EsSA','Tijuca'].join ' - '
      create_super_klazz('EsSA','Tijuca')
      p ['IME-ITA','Nova Iguaçu'].join ' - '
      create_super_klazz('IME-ITA','Nova Iguaçu')
      p ['3ª Série + IME-ITA','Nova Iguaçu'].join ' - '
      create_super_klazz('3ª Série + IME-ITA','Nova Iguaçu')
      p ['Pré-Vestibular Noite','Bangu'].join ' - '
      create_super_klazz('Pré-Vestibular Noite','Bangu')
      p ['3ª Série + Pré-Vestibular Biomédicas','Bangu'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Biomédicas','Bangu')
      p ['Pré-Vestibular Biomédicas','Bangu'].join ' - '
      create_super_klazz('Pré-Vestibular Biomédicas','Bangu')
      p ['3ª Série + Pré-Vestibular Biomédicas','Ilha do Governador'].join ' - '
      create_super_klazz('3ª Série + Pré-Vestibular Biomédicas','Ilha do Governador')
      p ['Pré-Vestibular Biomédicas','Ilha do Governador'].join ' - '
      create_super_klazz('Pré-Vestibular Biomédicas','Ilha do Governador')
    end
  end

  task create_attendance_list: :environment do
    p 'Creating attendance list'

    folder = '/home/charlie/Desktop/attendance'
    SuperKlazz.includes(:campus, product_year: :product).all.each do |super_klazz|
      uri = "#{super_klazz.campus.name}_#{super_klazz.product_year.product.name}.csv"
      uri.gsub!(/\//, '-')

      CSV.open("#{folder}/" + uri, "wb") do |csv|
        super_klazz.enrolled_students.each do |student|
          csv << [student.ra, student.name]
        end
      end

      # prefix = '9' + campus.code + product.code
      # uri = "#{campus.name}_#{product.name}_temporary.csv"
      # uri.gsub!(/\//, '-')
      # CSV.open("#{desktop}/" + uri, "wb") do |csv|
      #   80.times do |i|
      #     temporary_ra = prefix + "%02d" % i
      #     csv << [temporary_ra]
      #   end
      # end
    end
  end

  task create_attendance_report: :environment do
    lists = 
      {
        'Pré-Vestibular' => ['Pré-Vestibular Manhã', '3ª Série + Pré-Vestibular Manhã', 'Pré-Vestibular Biomédicas', '3ª Série + Pré-Vestibular Biomédicas', 'Pré-Vestibular Noite'],
        'ESPCEX' => ['ESPCEX', '3ª Série + ESPCEX'],
        'AFA/EAAr/EFOMM' => ['AFA/EAAr/EFOMM'],
        'AFA/EN/EFOMM' => ['AFA/EN/EFOMM', '3ª Série + AFA/EN/EFOMM'],
        'AFA/ESPCEX' => ['AFA/ESPCEX', '3ª Série + AFA/ESPCEX'],
        '2ª Série Militar' => ['2ª Série Militar'],
        '1ª Série Militar' => ['1ª Série Militar'],
        '9º Ano Militar' => ['CN/EPCAR', '9º Ano Militar'],
        '9º Ano Forte' => ['9º Ano Forte'],
        'IME-ITA' => ['IME-ITA']
      }
    CSV.open("/home/deployer/results/attendance_report_#{Date.today}.csv", "wb") do |csv|
      line = ['Exam date']
      lists.each_pair do |name, products|
        line << name
      end
      csv << line
      ExamExecution.all.map(&:datetime).map(&:to_date).uniq.sort!.each do |date|
        valid_ids = CardProcessing.where(exam_date: date).map(&:id)
        line = [date.to_s]
        lists.each_pair do |name, products|
          total = 0
          products.each do |product|
            sks = SuperKlazz.where(product_year_id: ProductYear.find_by_name(product + ' - 2013')).map(&:id)
            ees = ExamExecution.where(super_klazz_id: sks).where("datetime > '#{date}' and datetime < '#{date + 1}'")
            total += StudentExam.where(card_processing_id: valid_ids, status: 'Valid', exam_execution_id: ees).size
          end
          line << total.to_s
        end
        csv << line
      end
    end
    `iconv -f utf-8 -t windows-1252 "/home/deployer/results/attendance_report_#{Date.today}.csv" >   "/home/deployer/results/attendance_report_#{Date.today}_ansi.csv"`
    p 'Use the following command on the local machine:'
    p "scp deployer@elitesim.sistemaeliterio.com.br:/home/deployer/results/attendance_report_#{Date.today}_ansi.csv /Users/pauloacmelo/Dropbox/3PiR/Clients/Elite/EliteApp/Resultados/"
  end

  task create_attendance_report_by_campus: :environment do
    lists = 
      {
        'Pré-Vestibular' => ['Pré-Vestibular Manhã', '3ª Série + Pré-Vestibular Manhã', 'Pré-Vestibular Biomédicas', '3ª Série + Pré-Vestibular Biomédicas', 'Pré-Vestibular Noite'],
        'ESPCEX' => ['ESPCEX', '3ª Série + ESPCEX'],
        'AFA/EAAr/EFOMM' => ['AFA/EAAr/EFOMM'],
        'AFA/EN/EFOMM' => ['AFA/EN/EFOMM', '3ª Série + AFA/EN/EFOMM'],
        'AFA/ESPCEX' => ['AFA/ESPCEX', '3ª Série + AFA/ESPCEX'],
        '2ª Série Militar' => ['2ª Série Militar'],
        '1ª Série Militar' => ['1ª Série Militar'],
        '9º Ano Militar' => ['CN/EPCAR', '9º Ano Militar'],
        '9º Ano Forte' => ['9º Ano Forte'],
        'IME-ITA' => ['IME-ITA']
      }
    CSV.open("/home/deployer/results/attendance_report_by_campus_#{Date.today}.csv", "wb") do |csv|
      line = ['Exam date']
      lists.each_pair do |list_name, products|
        Campus.all.each do |campus|
          next if SuperKlazz.where(campus_id: campus.id, product_year_id: products.map{|product_name| ProductYear.find_by_name(product_name + ' - 2013')}.map(&:id)).size == 0
          line << list_name + ' - ' + campus.name
        end
      end
      csv << line
      ExamExecution.all.map(&:datetime).map(&:to_date).uniq.sort!.each do |date|
        valid_ids = CardProcessing.where(exam_date: date).map(&:id)
        line = [date.to_s]
        lists.each_pair do |list_name, products|
          Campus.all.each do |product|
            sks = SuperKlazz.where(campus_id: campus.id, product_year_id: products.map{|product_name| ProductYear.find_by_name(product_name + ' - 2013')}.map(&:id))
            next if sks.size == 0
            ees = ExamExecution.where(super_klazz_id: sks).where("datetime > '#{date}' and datetime < '#{date + 1}'")
            total = StudentExam.where(card_processing_id: valid_ids, status: 'Valid', exam_execution_id: ees).size
            line << total.to_s
          end
        end
        csv << line
      end
    end
    `iconv -f utf-8 -t windows-1252 "/home/deployer/results/attendance_report_by_campus_#{Date.today}.csv" >   "/home/deployer/results/attendance_report_by_campus_#{Date.today}_ansi.csv"`
    p 'Use the following command on the local machine:'
    p "scp deployer@elitesim.sistemaeliterio.com.br:/home/deployer/results/attendance_report_by_campus_#{Date.today}_ansi.csv /Users/pauloacmelo/Dropbox/3PiR/Clients/Elite/EliteApp/Resultados/"    
  end

  task create_exam_results_by_klazz: :environment do 
    p 'Creating exam results'
    result_date = ENV['DATE'] #'2013-04-06'
    klazz_id = ENV['KLAZZ'].to_i
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)    
    count = 1
    total = StudentExam.where(status: 'Valid', card_processing_id: valid_card_processing_ids).size
    CSV.open("/home/deployer/results/exam_results_#{result_date}.csv", "wb") do |csv|
      StudentExam.includes(
        :student, 
        exam_answers: :exam_question, 
        exam_execution: { super_klazz: [:campus, product_year: :product]}
      ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).find_each do |student_exam|
        p student_exam.id.to_s + '(' + count.to_s + ' of ' + total.to_s + ')'
        count += 1
        csv << [
          student_exam.student.ra, 
          student_exam.student.name, 
          student_exam.exam_execution.super_klazz.product_year.product.name,
          student_exam.exam_execution.super_klazz.campus.name,
          student_exam.get_exam_answers.join(''),
          student_exam.string_of_answers
        ]
      end
    end
  end

  task check_number_of_errors: :environment do
    result_date = ENV['DATE']

    p 'Checking exam results for day ' + result_date.to_s
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    errors = StudentExam.where(card_processing_id: valid_card_processing_ids).select {|se| se.status != 'Valid' || se.student_id.nil? || se.exam_execution_id.nil?}

    if errors.size > 0
      p "There are still #{errors} errors. Check the following Student Exams: "
      errors.each {|se| p se.id};
    else
      p 'Ok, no errors.'
    end
  end

  task check_number_of_questions: :environment do
    result_date = ENV['DATE']
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    warnings = []
    StudentExam.includes(
    :student,
    exam_answers: :exam_question,
    exam_execution: { super_klazz: [:campus, product_year: :product]}
    ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).find_each do |student_exam|
      p student_exam.id
      last = student_exam.string_of_answers.rindex(/[ABCDE]/)
      if last.nil?
        last = -1
      end
      if (last + 1 - student_exam.exam_execution.exam.exam_questions.size).abs > 3
      warnings << student_exam
      end
    end

    if warnings.length > 0
      p 'Please check the following Student Exams: ';
      p warnings.map{|se| "http://elitesim.sistemaeliterio.com.br/student_exams/" + se.id.to_s + " - " + se.exam_execution.exam_cycle.product_year.name};
    else
      p 'No warnings. Moving on.';
    end    
  end

  task create_enrollments_list: :environment do
    date = Date.today
    CSV.open("/home/deployer/results/enrollments_#{date}.csv", "wb") do |csv|
      Student.includes(enrollments: { super_klazz: [:campus, product_year: :product]}).find_each do |student|
        if student.enrollments.size == 0
          # do nothing
        elsif student.enrollments.size == 1
          p [student.ra, student.name, student.enrollments.first.super_klazz.product_year.product.name, student.enrollments.first.super_klazz.campus.name].map(&:to_s).join(' - ')
          csv << [student.ra, student.name, student.enrollments.first.super_klazz.product_year.product.name, student.enrollments.first.super_klazz.campus.name]
        else
          real_enrollments = student.enrollments.select{|enr| enr.super_klazz.exam_executions.map(&:student_exams).size > 0}
          real_enrollments.each do |enr|
            csv << [student.ra, student.name, enr.super_klazz.product_year.product.name, enr.super_klazz.campus.name]
            p [student.ra, student.name, enr.super_klazz.product_year.product.name, enr.super_klazz.campus.name].map(&:to_s).join(' - ')
          end
        end
      end
    end
    p  "/home/deployer/results/enrollments_#{date}.csv" 
  end  

  task create_exam_results: :environment do 
    p 'Creating exam results'
    result_date = ENV['DATE'] #'2013-04-06'
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    valid_card_processing_ids.delete(234)
    count = 1
    total = StudentExam.where(status: 'Valid', card_processing_id: valid_card_processing_ids).size
    CSV.open("/home/deployer/results/exam_results_#{result_date}.csv", "wb") do |csv|
      StudentExam.includes(
        :student, 
        exam_answers: :exam_question, 
        exam_execution: { super_klazz: [:campus, product_year: :product]}
      ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).find_each do |student_exam|
        p student_exam.id.to_s + '(' + count.to_s + ' of ' + total.to_s + ')'
        count += 1
        csv << [
          student_exam.student.try(:ra) || "Conferir student exam #{student_exam.id}",
          student_exam.student.try(:name) || '',
          student_exam.exam_execution.try(:super_klazz).try(:product_year).try(:product).try(:name) || '',
          student_exam.exam_execution.try(:super_klazz).try(:campus).try(:name) || '',
          student_exam.get_exam_answers.join(''),
          student_exam.string_of_answers
        ]
      end
    end
  end

  task create_students_list: :environment do 
    p 'Getting Students'

    CSV.open("/home/elite/output/students_#{DateTime.now.to_s}.csv", "wb") do |csv|
      Student.find_each  do |st|
        csv << [
          st.id,
          st.ra,
          st.name,
          st.email,
          st.cpf,
          st.rg,
          st.rg_expeditor,
          st.gender,
          st.date_of_birth,
          st.number_of_children,
          st.mother_name,
          st.father_name,
          st.telephone,
          st.cellphone,
          st.previous_school
        ]
      end
    end
  end

  task test_student_exams: :environment do
    result_date = '2013-04-06'
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    warnings = []
    StudentExam.includes(
    :student,
    exam_answers: :exam_question,
    exam_execution: { super_klazz: [:campus, product_year: :product]}
    ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).each do |student_exam|
      p student_exam.id
      last = student_exam.string_of_answers.rindex(/[ABCDE]/)
      if last.nil?
        last = -1
      end
      if (last + 1 - student_exam.exam_execution.exam.exam_questions.size).abs > 3
      warnings << student_exam
      end
    end

    if warnings.length > 0
      p 'Please check the following Student Exams: ';
      pp warnings.map{|se| "http://elitesim.sistemaeliterio.com.br/student_exams/" + se.id.to_s + " - " + se.exam_execution.exam_cycle.product_year.name};
    else
      p 'No warnings. Moving on.';
    end
  end

  task check_student_exams: :environment do
    result_date = '2013-04-06'

    p 'Creating exam results for ' + result_date.to_s
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    errors = StudentExam.where(card_processing_id: valid_card_processing_ids).select {|se| se.status != 'Valid'}.size

    if errors > 0
    p 'There are still #{errors} errors. Press any key to continue.'
    answer = gets.chomp
    else
    p 'Ok, no errors. Moving on.'
    end    
  end

  task create_separated_exam_results: :environment do
    result_date = '2013-03-23'

    p 'Creating exam results for ' + result_date.to_s
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    errors = StudentExam.where(card_processing_id: valid_card_processing_ids).select {|se| se.status != 'Valid'}.size

    if errors > 0
    p 'There are still #{errors} errors. Press any key to continue.'
    else
    p 'Ok, no errors. Moving on.'
    end

    warnings = []
    StudentExam.includes(
    :student,
    exam_answers: :exam_question,
    exam_execution: { super_klazz: [:campus, product_year: :product]}
    ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).each do |student_exam|
      p student_exam.id
      last = student_exam.string_of_answers.rindex(/[ABCDE]/)
      if last.nil?
        last = -1
      end
      if (last + 1 - student_exam.exam_execution.exam.exam_questions.size).abs > 3
      warnings << student_exam
      end
    end

    if warnings.length > 0
      p 'Please check the following Student Exams: ' + warnings.map(&:id).join(', ')
    else
      p 'No warnings. Moving on.'
    end

    lists = {"Pré-Vestibular" => [], "9º Ano Forte - 2013"=> [], "9º Ano Militar - 2013"=> [], "1ª Série Militar - 2013"=> [], "2ª Série Militar - 2013"=> [], "AFA/EAAr/EFOMM - 2013"=> [], "AFA/ESPCEX - 2013"=> [], "IME-ITA - 2013"=> [], "AFA/EN/EFOMM - 2013"=> []}
    translation = {"Pré-Vestibular Manhã - 2013" => "Pré-Vestibular", "9º Ano Forte - 2013" => "9º Ano Forte - 2013", "Pré-Vestibular Noite - 2013" => "Pré-Vestibular", "9º Ano Militar - 2013" => "9º Ano Militar - 2013", "1ª Série Militar - 2013" => "1ª Série Militar - 2013", "2ª Série Militar - 2013" => "2ª Série Militar - 2013", "AFA/EAAr/EFOMM - 2013" => "AFA/EAAr/EFOMM - 2013", "AFA/ESPCEX - 2013" => "AFA/ESPCEX - 2013", "Pré-Vestibular Biomédicas - 2013" => "Pré-Vestibular", "3ª Série + Pré-Vestibular Manhã - 2013" => "Pré-Vestibular", "IME-ITA - 2013" => "IME-ITA - 2013", "3ª Série + IME-ITA - 2013" => "IME-ITA - 2013", "AFA/EN/EFOMM - 2013" => "AFA/EN/EFOMM - 2013", "3ª Série + AFA/ESPCEX - 2013" => "AFA/ESPCEX - 2013", "3ª Série + Pré-Vestibular Biomédicas - 2013" => "Pré-Vestibular"}

    StudentExam.includes(
      :student,
      exam_answers: :exam_question,
      exam_execution: { super_klazz: [:campus, product_year: :product]}
    ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).each do |student_exam|
      lists[translation[student_exam.exam_execution.exam_cycle.product_year.name]] << [
        student_exam.student.ra,
        student_exam.student.name,
        student_exam.exam_execution.super_klazz.product_year.product.name,
        student_exam.exam_execution.super_klazz.campus.name,
        student_exam.get_exam_answers.join(''),
        student_exam.string_of_answers
      ]
    end

    Dir.mkdir("/home/deployer/results/exam_results_#{result_date}/")
    lists.keys.sort.each do |key|
      puts "Building #{key} file..."
      CSV.open("/home/deployer/results/exam_results_#{result_date}/#{key}.csv", "wb") do |csv|
        lists[key].each do |item|
          csv << item
        end
      end
    end

    pp 'Run the following command to convert: iconv -f utf-8 -t windows-1252 /home/deployer/results/exam_results_2013-03-23.csv > /home/deployer/results/exam_results_2013-03-23_ansi.csv'
    pp 'Convert all files to windows-1252 and run the following command on local machine:\n scp deployer@elitesim.sistemaeliterio.com.br:/home/deployer/results/exam_results_#{result_date}_ansi.csv ~/Elite/resultados/exam_results_#{result_date}_ansi.csv'

  end
end

def create_super_klazz product_name, campus_name
  product_year_id = ProductYear.find_by_name(product_name + ' - 2014').try(:id) || -1
  campus_id = Campus.find_by_name(campus_name).try(:id) || -1
  if(product_year_id == -1 || campus_id == -1)
    p "Erro #{product_name}, #{campus_name}"
    return
  end
  sk = SuperKlazz.new(
    product_year_id: product_year_id,
    campus_id: campus_id
  )
  sk.save
end

def print_campus_status_report(result_date)
  p "Processing status for #{result_date}..."
  campus_status = []
  CardProcessing.where(exam_date: result_date).each do |cp|
    status = {}
    status[:name] = cp.name
    status[:campus] = cp.campus.name
    status[:total] = cp.total_number_of_cards
    status[:total_errors] = cp.number_of_errors
    cp.student_exams.each do |se|
      if status.has_key? se.status
        status[se.status] += 1
      else
        status[se.status] = 1
      end
    end
    campus_status << status
  end
  print 'Generating file...'
  CSV.open("/home/deployer/results/status_#{result_date}.csv", "w") do |io|
    io << ['Filename', 'Campus', 'Total Cards', 'Total Errors', 'Being processed', 'Error', 'Student not found', 'Exam not found', 'Repeated student', 'Invalid answers', 'Valid']
    campus_status.each do |st|
      io << [st[:name], st[:campus], st[:total], st[:total_errors], st['Being processed'], st['Error'], st['Student not found'], st['Exam not found'], st['Repeated student'], st['Invalid answers'], st['Valid']]
    end
  end
  print "OK!\n"
  `iconv -f utf-8 -t windows-1252 "/home/deployer/results/status_#{result_date}.csv" >   "/home/deployer/results/status_#{result_date}_ansi.csv"`
  p "Run the following command on a local machine:"
  p "scp deployer@elitesim.sistemaeliterio.com.br:/home/deployer/results/status_#{result_date}_ansi.csv /Users/pauloacmelo/Dropbox/3PiR/Clients/Elite/EliteApp/Resultados/Simulados/#{result_date}"
end
