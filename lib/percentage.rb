require "bigdecimal"
require "bigdecimal/util"

class Percentage < Numeric
  def initialize(value = 0)
    value = 0.0              if value.nil? || value == false
    value = 1.0              if value == true
    value = value.to_r       if value.is_a?(String) && value["/"]
    value = value.to_f       if value.is_a?(Complex) || value.is_a?(Rational)
    value = value.to_i       if value.is_a?(String) && !value["."]
    if value.is_a?(Integer) || (value.is_a?(String) && value["%"])
      value = value.to_d / 100
    end
    value = value.value if value.is_a? self.class

    @value = value.to_d
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
  def to_string = "#{self}%"

  def format(**options)
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
  def self.from_fraction(value = 0)
    if value.is_a?(String) && !(value["/"] || value["%"] || value["."])
      value = value.to_i
    end

    value = value.to_d if value.is_a?(Integer)

    new value
  end

  def self.from_amount(value = 0)
    value = value.to_r  if value.is_a?(String) && value["/"]
    value = value.to_d  if value.is_a?(String)
    value /= 100 if value.is_a?(Numeric) && !value.integer?

    new value
  end
end
