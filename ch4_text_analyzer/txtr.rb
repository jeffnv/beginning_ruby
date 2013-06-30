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
  
  def count_sentences
    self.to_s.split(/\.|\?|!/).count
  end
  
  def count_paragraphs
    self.to_s.split(/\n\n/).count
  end
  
  def avg_words_per_sentence
    count_words.to_f / count_sentences.to_f
  end
  
  def avg_sentence_per_pg
    count_sentences.to_f / count_paragraphs.to_f
  end
    
  def analyze
    puts "text has #{count_lines} lines."
    puts "text is #{count_all_symbols} symbols."
    puts "text has #{count_all_characters} characters (excluding white spaces)."
    puts "text has #{count_words} words."
    puts "text has #{count_sentences} sentences."
    puts "text has #{count_paragraphs} paragraphs."
    puts "text has an average of #{avg_words_per_sentence.round(2)} words per sentence."
    puts "text has an average of #{avg_sentence_per_pg.round(2)} sentences per paragraph."
  end
end

class AdvTxtr < Txtr
  STOP_WORDS_FILE = "stop_words.txt"
  
  def load_stop_words
    @stop_words = []
    if(File.exists?(STOP_WORDS_FILE))
      @stop_words = File.read(STOP_WORDS_FILE).split(',')
    end
  end
  
  def initialize(file)
    super
    load_stop_words
  end
  
  def count_interesting_words
    self.to_s.split.select{|i| !@stop_words.include?(i)}.count
  end
  
  def interesting_words_percentage
    count_interesting_words.to_f / count_words.to_f
  end
  
  def analyze
    super
    puts "text is #{(interesting_words_percentage * 100.to_f).round(2)}% interesting words."
  end
  
  def summarize
    sorted_sentences = self.to_s.gsub(/\s+/, ' ').strip.split(/\.|\?|!/).sort_by{|sentence| sentence.length}
    ideal_sentences =  sorted_sentences.slice(sorted_sentences.length / 3, (sorted_sentences.length / 3) + 1)
    ideal_sentences = ideal_sentences.select{|sentence| sentence =~ /is|are/}
    puts ideal_sentences.join('. ')
  end
end

file = ARGV[0] || "oliver.txt"

t = AdvTxtr.new(file)
t.analyze
t.summarize