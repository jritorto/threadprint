#!/usr/bin/env ruby
require 'date'
require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'word_wrapper'
doc = Nokogiri::XML(STDIN.read)
doc.css('message').reverse_each do |mess|
  puts

  jt = mess.css('date').inner_text
  puts(Time.at(jt.to_i/1000).localtime)

  if mess.css('type').inner_text == "2"
    puts("A: ")
  else
    puts("K: ")
  end

  b = URI::decode_www_form_component(mess.css('body').inner_text)
  puts(WordWrapper::MinimumRaggedness.new(45, b).wrap)
end
