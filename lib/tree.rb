class Tree
  def initialize(array)
    @array = array
    set_root
  end

  def set_root
    if @array.size > 0
      start_index, end_index = 0, @array.size - 1
      @root = Node.new(@array[(start_index + end_index) / 2])
    end
  end
end
