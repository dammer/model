require 'test_helper'

describe Hanami::Model::Sql::Types::Schema::Float do
  let(:described_class) { Hanami::Model::Sql::Types::Schema::Float }
  let(:input) do
    Class.new do
      def to_f
        3.14
      end
    end.new
  end

  it 'returns nil for nil' do
    input = nil
    described_class[input].must_equal input
  end

  it 'coerces object that respond to #to_f' do
    described_class[input].must_equal input.to_f
  end

  it 'coerces string representing int' do
    input = '1'
    described_class[input].must_equal input.to_f
  end

  it 'coerces Hanami string representing int' do
    input = Hanami::Utils::String.new('1')
    described_class[input].must_equal input.to_f
  end

  it 'coerces string representing float' do
    input = '3.14'
    described_class[input].must_equal input.to_f
  end

  it 'coerces Hanami string representing float' do
    input = Hanami::Utils::String.new('3.14')
    described_class[input].must_equal input.to_f
  end

  it 'raises error for meaningless string' do
    input     = 'foo'
    exception = lambda do
      described_class[input]
    end.must_raise(ArgumentError)

    exception.message.must_equal "invalid value for Float(): #{input.inspect}"
  end

  it 'raises error for symbol' do
    input     = :house_11
    exception = lambda do
      described_class[input]
    end.must_raise(ArgumentError)

    exception.message.must_equal "invalid value for Float(): #{input.inspect}"
  end

  it 'coerces integer' do
    input = 23
    described_class[input].must_equal input.to_f
  end

  it 'coerces float' do
    input = 3.14
    described_class[input].must_equal input.to_f
  end

  it 'coerces bigdecimal' do
    input = BigDecimal.new(3.14, 10)
    described_class[input].must_equal input.to_f
  end

  it 'raises error for date' do
    input     = Date.today
    exception = lambda do
      described_class[input]
    end.must_raise(ArgumentError)

    exception.message.must_equal "invalid value for Float(): #{input.inspect}"
  end

  it 'raises error for datetime' do
    input     = DateTime.new
    exception = lambda do
      described_class[input]
    end.must_raise(ArgumentError)

    exception.message.must_equal "invalid value for Float(): #{input.inspect}"
  end

  it 'raises error for time' do
    input     = Time.now
    exception = lambda do
      described_class[input]
    end.must_raise(ArgumentError)

    exception.message.must_equal "invalid value for Float(): #{input.inspect}"
  end

  it 'raises error for array' do
    input     = []
    exception = lambda do
      described_class[input]
    end.must_raise(ArgumentError)

    exception.message.must_equal "invalid value for Float(): #{input.inspect}"
  end

  it 'raises error for hash' do
    input     = {}
    exception = lambda do
      described_class[input]
    end.must_raise(ArgumentError)

    exception.message.must_equal "invalid value for Float(): #{input.inspect}"
  end
end
