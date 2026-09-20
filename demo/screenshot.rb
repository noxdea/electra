# frozen_string_literal: true

require "fileutils"
require "electra"
require_relative "../examples/example_shaders"
require_relative "png_helper"

binary = Electra::ExampleShaders.triangle_fragment
width = 720
height = 400
rgba = Array.new(width * height) do |index|
  x = index % width
  y = index / width
  byte = binary[(x + y * 3) % binary.bytesize].ord
  [30 + (x * 80 / width), 36 + (byte % 90), 55 + (y * 80 / height), 255]
end.flatten
FileUtils.mkdir_p("docs/media")
DemoPNG.write("docs/media/screenshot.png", width, height, rgba.pack("C*"))
