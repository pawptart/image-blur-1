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

  def blur(dist)

    blur_coords = Array.new

    @array.each_with_index do |row, y_index|      # find all the 1s in the array
      row.each_with_index do |cell, x_index|      # push all the coordinates to a new array (blur_coords)
        if cell == 1
          blur_coords << [y_index, x_index]
        end
      end
    end

    image_max_y_index = @array.length - 1         # get the maximum indices of the image array
    image_max_x_index = @array[0].length - 1      # minimums are 0,0

    blur_coords.each do |coord|                   # get the max square area to blur
      y_index = coord[0]
      x_index = coord[1]  

      if y_index - dist < 0                       # set min Y index
        min_y = 0
      else
        min_y = y_index - dist
      end

      if y_index + dist > image_max_y_index       # set max Y index
        max_y = image_max_y_index
      else
        max_y = y_index + dist
      end

      if x_index - dist < 0                       # set min X index
        min_x = 0
      else
        min_x = x_index - dist
      end

      if x_index + dist > image_max_x_index       # set max X index
        max_x = image_max_x_index
      else
        max_x = x_index + dist
      end

      def calc_distance(check_x, check_y, x_index, y_index)   # calculate radial distance from origin
        return Math.sqrt( ( (check_x - x_index) ** 2 ) + ( (check_y - y_index) ** 2) )
      end

      check_x = min_x                                         # set starting point for search
      check_y = min_y

      while check_y <= max_y                                                # while in searchable area
        if calc_distance(check_x, check_y, x_index, y_index) <= dist        # check if the distance between the pt
          @array[check_y][check_x] = 1                                      # and origin is less than the
        end                                                                 # specified distance, & add a pixel
                                                                    
        check_x += 1                                             # move 1 unit to the right

        if check_x > max_x                                       # check if we've hit our max row search size
          check_x = min_x                                        # reset our x position
          check_y += 1                                           # move down to next row
        end

      end

    end

    output_image                                                 # Output result when finished
  end

end

image = Image.new([
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 1, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 1],
])

puts 'Original:'
image.output_image
puts "\nBlurred!"
image.blur(3)