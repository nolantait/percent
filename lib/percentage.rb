require "bigdecimal"
require "bigdecimal/util"

class Percentage < Numeric
  def initialize(val = 0, options = {})
    val ||= 0.0
    val = 1.0            if val == true
    val = val.to_r       if val.is_a?(String) && val["/"]
    val = val.to_f       if val.is_a?(Complex) || val.is_a?(Rational)
    val = val.to_i       if val.is_a?(String) && !val["."]
    if val.is_a?(Integer) || (val.is_a?(String) && val["%"])
      val = val.to_d / 100
    end
    val = val.value if val.is_a? self.class

    @value = val.to_d
  end

  ###
  # Attributes
  ###
  def value
    @value ||= 0
  end

  ###
  # Convert percentage to different number formats
  ###
  def to_i = (value * 100).to_i
  def to_c = value.to_c
  def to_d = value.to_d
  def to_f = value.to_f
  def to_r = value.to_r

  ###
  # Convert percentage fraction to percent amount
  ###
  def to_complex = (value * 100).to_c
  def to_decimal = (value * 100).to_d
  def to_float = (value * 100).to_f
  def to_rational = (value * 100).to_r

  ###
  # String conversion methods
  ###
  def to_s = to_amount.to_s
  def to_str = to_f.to_s
  def to_string = to_s(+"%")

  def format(options = {})
    # set defaults; all other options default to false
    options[:percent_sign] = options.fetch :percent_sign, true

    if options[:as_decimal]
      return to_str
    elsif options[:rounded]
      string = to_float.round.to_s
    elsif options[:no_decimal]
      string = to_i.to_s
    elsif options[:no_decimal_if_whole]
      string = to_s
    else
      string = to_float.to_s
    end

    string += " " if options[:space_before_sign]
    string += "%" if options[:percent_sign]
    string
  end

  ###
  # Additional conversion methods
  ###
  def to_amount
    (int = to_i) == (float = to_float) ? int : float
  end

  def inspect
    "#<#{self.class.name}:#{object_id}, #{value.inspect}>"
  end

  ###
  # Comparisons
  ###
  def ==(other)
    eql?(other) || to_f == other
  end

  def eql?(other)
    self.class == other.class && value == other.value
  end

  def <=>(other)
    to_f <=> other.to_f
  end

  ###
  # Mathematical operations
  ###
  %i[+ - / *].each do |operator|
    define_method operator do |other|
      case other
      when Percentage
        new_value = value.public_send(operator, other.value)
        self.class.new new_value
      else
        value.to_f.public_send(operator, other)
      end
    end
  end

  ###
  # Additional initialization methods
  ###
  def self.from_fraction(val = 0, options = {})
    val = val.to_i if val.is_a?(String) && !(val["/"] || val["%"] || val["."])
    val = val.to_d if val.is_a?(Integer)

    new val, options
  end

  def self.from_amount(val = 0, options = {})
    val = val.to_r  if val.is_a?(String) && val["/"]
    val = val.to_d  if val.is_a?(String)
    val /= 100 if val.is_a?(Numeric) && !val.integer?

    new val, options
  end
end
