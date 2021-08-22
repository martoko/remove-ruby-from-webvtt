require 'nokogiri'
require 'pry'

# Remove ruby/furigana from vtt subtitle
def remove_ruby(text)
  doc = Nokogiri::XML.fragment(text)
  doc.css('rp, rt').remove
  doc.inner_text
end

contents = ARGF.read
lines = contents.split(/\r?\n\r?\n/)
lines.map! do |line|
  return line if line == 'WEBVTT'

  timing, sub = line.split(/\r?\n/)
  [timing, remove_ruby(sub)].join "\r\n"
end
puts lines.join "\r\n\r\n"
