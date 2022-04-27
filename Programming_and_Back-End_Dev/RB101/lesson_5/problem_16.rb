
sections = [8,4,4,4,12]
uuid = ""

def get_section(section, uuid)
  section.times do
    uuid << rand(16).to_s(16)
  end
  if section != 12
    uuid << "-"
  end
end

sections.each {|section| get_section(section, uuid)}
p uuid
