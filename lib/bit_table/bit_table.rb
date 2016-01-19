class BitTable
  module Version
    MAJOR, MINOR, TEENY, PATCH = 1, 0, 0, nil
    STRING = [MAJOR, MINOR, TEENY, PATCH].compact.join('.').freeze
  end
  VERSION = Version::STRING

  attr_reader :target

  # @param [#seek, #tell, #write, #rewind, #readbyte] target
  # @param [Hash<Symbol, Object>] options
  #   @option :options [Boolean] auto_resize
  #     This affects the read and write behaviours, while true
  #     the table will resize the stream to fit contents on write
  #     and will ignore out of bounds values while reading
  def initialize(target, **options)
    @target = target
    @auto_resize = options.fetch(:auto_resize, true)
  end

  # @return [Integer] size
  private def stream_size
    @target.seek 0, IO::SEEK_END
    @target.tell
  end

  private def calc_bit_index(index)
    block_index = (index / 8)
    sub_index = index % 8
    return block_index, sub_index
  end

  private def seek_bit_index(index)
    b, s = calc_bit_index index
    @target.seek b, IO::SEEK_SET
    return b, s
  end

  private def in_bounds?(index)
    b, s = calc_bit_index index
    b < stream_size
  end

  private def check_bounds(index)
    if in_bounds?(index)
      true
    else
      @auto_resize ? false :
        raise(IndexError, "index is out of bounds #{index}")
    end
  end

  private def check_resize(index)
    if @auto_resize
      b, s = calc_bit_index index
      @target.write("\0") until b < stream_size
      @target.rewind
    else
      raise IndexError, "index is out of bounds #{index}"
    end
  end

  private def cast_bit(obj)
    case obj
    when true       then 1
    when false, nil then 0
    when Integer    then obj & 1
    else
      raise TypeError, "expected Boolean, Integer or nil"
    end
  end

  # Returns the size of the table in bits
  #
  # @return [Integer]
  def size
    stream_size * 8
  end

  # Returns the size of the stream in bytes
  #
  # @return [Integer]
  def bytesize
    stream_size
  end

  # @param [Integer] index
  # @return [Integer] value
  def [](index)
    return 0 unless check_bounds(index)
    _, s = seek_bit_index index
    (@target.readbyte >> s) & 1
  end

  # @param [Integer] index
  # @param [Boolean, Integer, nil] value
  def []=(index, value)
    check_resize index
    seek_bit_index index
    byte = @target.readbyte
    b, s = seek_bit_index index
    bit = 1 << s
    mask = 0xF ^ bit
    result = (byte & mask) | (cast_bit(value) << s)
    @target.write result.chr
  end
end
