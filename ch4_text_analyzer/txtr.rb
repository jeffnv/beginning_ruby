class Txtr
  
  def initialize(file)
    puts "Analyzing '#{file}'..."
    if(File.exists?(file))
      @lines = File.readlines(file)
    else
      puts "#{file} doesn't exist!"
    end
  end
  
  def to_s
    @lines.join('')
  end
  
  def count_lines
    @lines.count
  end
  
  def count_all_symbols
    self.to_s.length
  end
  
  def count_all_characters
    self.to_s.gsub(/\s+/, '').length
  end
  
  def count_words
    #self.to_s.scan(/\w+/).count
    self.to_s.split.length
  end
    
  def analyze
    puts "text has #{count_lines} lines."
    puts "text is #{count_all_symbols} symbols."
    puts "text has #{count_all_characters} characters (excluding white spaces)."
    puts "text has #{count_words} words."
    #puts "text is #{lines.join('\n').scan(/\w+/).join('').length} characters without whitespaces"
    #puts "text is #{lines.join('\n').gsub(/\s+/,'').length} characters without whitespaces (gsub)"
  end
end

t = Txtr.new("oliver.txt")
Txtr.new("oliver.txt").analyze