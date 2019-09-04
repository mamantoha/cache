require "zlib"

module Cache
  module DataCompressor
    extend self

    def deflate(data : String) : String
      io = IO::Memory.new

      Zlib::Writer.open(io) do |writer|
        writer.print(data)
      end

      # base64-encode the compressed data to make it printable
      Base64.encode(io.to_s)
    end

    def inflate(data : String) : String
      encoded_data = Base64.decode_string(data)

      io = IO::Memory.new(encoded_data.to_slice)

      Zlib::Reader.open(io) do |reader|
        reader.gets_to_end
      end
    end
  end
end
