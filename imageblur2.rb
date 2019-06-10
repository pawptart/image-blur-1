class Image
  attr_accessor :array

  def initialize(array)
    @array = array
  end

  def output_image
    @array.each do |row|
      puts row.join(' ')
    end
  end

  def blur

    blur_coords = Array.new

    @array.each_with_index do |row, y_index|      # find all the 1s in the array
      row.each_with_index do |cell, x_index|      # push all the coordinates to a new array (blur_coords)
        if cell == 1
          blur_coords << [y_index, x_index]
        end
      end
    end

    blur_coords.each do |coord|                  # for each coordinate
      y_index = coord[0]
      x_index = coord[1]

      if y_index - 1 >= 0                        # check if the coordinate exists in the array
        @array[y_index - 1][x_index] = 1          # and if it does, blur it!
      end
      if y_index + 1 < @array.length
        @array[y_index + 1][x_index] = 1
      end
      if x_index - 1 >= 0 
        @array[y_index][x_index - 1] = 1
      end
      if x_index + 1 < @array[1].length 
        @array[y_index][x_index + 1] = 1
      end

    end

    output_image
  end

end

image = Image.new([
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 1, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 1]
])

puts 'Original:'
image.output_image
puts "\nBlurred!"
image.blur
