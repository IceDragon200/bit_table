require 'spec_helper'
require 'stringio'
require 'bit_table'

describe BitTable do
  context '#[]' do
    it 'reads from the stream' do
      stream = StringIO.new("\x01\x03")
      table = described_class.new(stream)

      expect(table.size).to eq(16)
      expect(table.bytesize).to eq(2)
      # first block
      expect(table[0]).to eq(1)
      expect(table[1]).to eq(0)
      # second block
      expect(table[8]).to eq(1)
      expect(table[9]).to eq(1)
      # non-existant third block
      expect(table[16]).to eq(0)
      expect(table[17]).to eq(0)
      expect(table[18]).to eq(0)
    end
  end

  context '#[]=' do
    it 'writes to the stream' do
      stream = StringIO.new("\x01\x03")
      table = described_class.new(stream)

      expect(table.size).to eq(16)
      expect(table.bytesize).to eq(2)

      # first block
      expect(table[0]).to eq(1)
      table[0] = 0
      expect(table[0]).to eq(0)
      expect(table[1]).to eq(0)
      table[1] = 3
      expect(table[1]).to eq(1)

      # non-existant block
      table[16] = 1
      expect(table.size).to eq(24)
      expect(table[16]).to eq(1)
    end
  end
end
