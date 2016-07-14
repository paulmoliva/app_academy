class Card
  attr_accessor :face_value, :visible

  def initialize(face_value)
    @face_value = face_value
    @visible = false
  end

  def display
    if visible
      print @face_value
    else
      print "X"
    end
  end

  def hide
    @visible = false
  end

  def reveal
    @visible = true
  end

  def to_s
    face_value.to_s
  end

  def ==(card)
    face_value == card.face_value
  end

end
