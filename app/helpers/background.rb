def render_background
  outputs.solids << { x: 0, y: 0, w: 1280, h: 720, r: 132, g: 222, b: 2, a: 200 }
  if !state.background_rendered
    outputs[:background_tiles].w = @width
    outputs[:background_tiles].h = @height
    outputs[:background_tiles].solids << 100.map do 
      { x: @width.randomize(:ratio),
        y: @height.randomize(:ratio),
        w: 3 + 3.randomize(:ratio), h: 3 + 3.randomize(:ratio), r: 83, g: 139, b: 1, a: 228 }
    end
    state.background_rendered = true
  end

  if state.background_rendered
    outputs[:camera].sprites << { x: 0, y: 0, w: outputs[:camera].w, h: outputs[:camera].h, path: :background_tiles } 
  end
end


def generate_clouds
  10.map do
    x = (rand grid.w) * -1
    y = (rand grid.h) * -1
    Cloud.new(x: x, y: y)
  end
end