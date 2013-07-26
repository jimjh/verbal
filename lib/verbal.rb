# Ruby Verbal Expressions, based on the awesome JavaScript repo by @jehna.
#
# @see https://github.com/jehna/VerbalExpressions   Original idea
# @see https://github.com/jimjh/verbal              Main repository
class Verbal < Regexp

  # @example Create a new RegExp
  #   verbal = Verbal.new do
  #     start_of_line
  #     find 'x'
  #   end
  #   verbal =~ 'x' # => 0
  def initialize(&block)
    @prefixes = ''
    @source   = ''
    @suffixes = ''
    @modifiers = '' # TODO: Ruby Regexp option flags
    instance_eval(&block)
    super(@prefixes + @source + @suffixes, @modifiers)
  end

  # Matches an exact string.
  # @param [String] value     string to match
  # @example Replace all dots with the word "Stop".
  #   paragraph = "Lorem. Dolor."
  #   verbal    = Verbal.new do
  #     find '.'
  #   end
  #   paragraph.gsub(verbal, 'Stop') # => "Lorem Stop Dolor Stop"
  def find(value)
    append "(?:#{sanitize value})"
  end

  # Marks the expression to start at the beginning of a line.
  # @example Add a hyphen to the beginning of each line.
  #   lines = "first\nsecond\nthird"
  #   verbal = Verbal.new do
  #     start_of_line
  #   end
  #   lines.gsub(verbal, '- ') # => "- first\n- second\n- third"
  def start_of_line
    @prefixes = '^'
  end

  # Marks the expression to end at the last character of a line.
  # @example Add a hyphen to the end of each line.
  #   lines = "first\nsecond\nthird"
  #   verbal = Verbal.new do
  #     end_of_line
  #   end
  #   lines.gsub(verbal, '- ') # => "first- \nsecond- \nthird"
  def end_of_line
    @suffixes = '$'
  end

  # Marks the expression to start at the beginning of the string.
  # @example Matching the entire string
  #   verbal = Verbal.new do
  #     start_of_string
  #     find 'dinosaur'
  #     end_of_string
  #   end
  #   verbal.match('dinosaur')  # matches
  #   verbal.match('a dinosaur') # does not match
  def start_of_string
    @prefixes = @prefixes.prepend '\A'
  end

  # Marks the expression to start at the end of the string.
  # @example Matching the entire string
  #   verbal = Verbal.new do
  #     start_of_string
  #     find 'dinosaur'
  #     end_of_string
  #   end
  #   verbal.match('dinosaur')  # matches
  #   verbal.match('dinosaurs') # does not match
  def end_of_string
    @suffixes += '\z'
  end

  # Add a string to the expression that might appear once.
  # @param [String] value   the string to look for
  # @example Find http or https.
  #   Verbal.new do
  #     find 'http'
  #     maybe 's'
  #   end
  def maybe(value)
    append "(?:#{sanitize value})?"
  end

  # Matches any character any number of times.
  # @example Match the entire string.
  #   Verbal.new do
  #     anything
  #   end
  def anything
    append '(?:.*)'
  end

  # Matches any number of any character that is not in +value+.
  # @example Match everything except underscores.
  #   Verbal.new do
  #     anything_but '_'
  #   end
  # @param [String] value       characters to excluded
  def anything_but(value)
    append "(?:[^#{sanitize value}]*)"
  end

  # Adds a universal line break expression.
  # @example Converts all line breaks to unix-style with \<br\> tag.
  #   lorem = "Lorem.\r\nDolor\namet."
  #   verbal = Verbal.new do
  #     line_break
  #   end
  #   lorem.gsub(veral, "<br>\n") # => "Lorem.<br>\nDolor<br>\namet."
  def line_break
    append '(?:\n|(?:\r\n))'
  end
  alias_method :br, :line_break

  # Matches the tab character.
  # @example Find the tab character.
  #   "\n\t" =~ Verbal.new { tab | # => 1
  def tab
    append '\t'
  end

  # Matches a word, which is a continuous chunk of any alphanumeric character.
  # @example Split a sentence into words.
  #   s = "this is a sentence"
  #   s.scan Verbal.new { word } # => ["this", "is", "a", "sentence"]
  def word
    append '\w+'
  end

  # Matches any one of the characters in +value+.
  # @param [String] value     string of characters to match
  # @example Find one of 'abc' in 'xkcd'
  #   verbal = Verbal.new do
  #     any_of 'abc'
  #   end
  #   'xkcd'.scan verbal # => ['c']
  def any_of(value)
    append "[#{sanitize value}]"
  end
  alias_method :any, :any_of

  # Matches a character from the given range.
  # @param [Array] args    alternate starting and ending characters.
  # @example Find any character in the alphabet.
  #   verbal = Verbal.new do
  #     range 'a', 'z', 'A', 'Z'
  #   end
  def range(*args)
    value = "["
    args.each_slice(2) do |from, to|
      from = sanitize(from)
      to = sanitize(to)
      value += "#{from}-#{to}"
    end
    value += "]"
    append value
  end

  # Matches one or many of value.
  # @param [String|Regexp] value     string to match
  # @example Matching multiples of "xyz"
  #   verbal = Verbal.new { multiple 'xyz' }
  #   verbal.match('this is xyzxyz')[0] # => 'xyzxyz'
  # @example Matching multiples of /[xyz]/
  #   verbal = Verbal.new { multiple /[xyz]/ }
  #   verbal.match('abcxxyz')[0] # => 'xxyz'
  def multiple(value)
    append case value
    when Regexp then "(#{value.source})+"
    else "(#{sanitize value})+"
    end
  end

  # Adds a alternative expression to be matched.
  # @example Tests if the string begins with 'http://' or 'ftp://'
  #   link = 'ftp://ftp.google.com/';
  #   verbal = Verbal.new do
  #     find 'http'
  #     maybe 's'
  #     find '://'
  #     otherwise
  #     find 'ftp://'
  #   end
  #   link =~ verbal # => 0
  def otherwise(value = nil)
    @prefixes += "(?:"
    @suffixes = ")" + @suffixes
    append(")|(?:")
    find(value) if value
  end

  # Captures the nested regular expression.
  # @example Capture the title of the concert and performer
  #   verbal = Verbal.new do
  #     capture { anything }
  #     find /\sby\s/
  #     capture { anything }
  #   end
  #   data = verbal.match('this is it by michael jackson')
  #   data[1] # => 'this is it'
  #   data[2] # => 'michael jackson'
  def capture(&block)
    append "(#{Verbal.new(&block).source})"
  end

  private

    # Escapes +value+ so that it can be used in a regular expression.
    def sanitize(value)
      case value
      when Regexp then value.source
      else Regexp.escape value
      end
    end

    # Appends +value+ to the regex source.
    def append(value = '')
      @source += value
    end

end
