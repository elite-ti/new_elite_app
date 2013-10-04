#!/usr/bin/env ruby

require 'fileutils'

this_path = File.dirname(File.expand_path(__FILE__))
bin_path = File.join(this_path, 'bin')
output = File.join(bin_path, 'run')

src_path = File.join(this_path, 'src')
files = "'" + ['type_a.c', 'lodepng.c'].map { |file| File.join(src_path, file) }.join("' '") + "'"

FileUtils.rm_rf(bin_path) 
FileUtils.mkdir(bin_path)
`gcc -std=c99 #{files} -lm -ltiff -o '#{output}'`
