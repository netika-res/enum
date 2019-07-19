class Side < Enum::Base
  values({:left => 'my_left', :right => 'my_right'})
end

class NewSide < Side
  values({center: 'my_center'})
end

=begin
class Table
  extend Enum::Predicates

  attr_accessor :side

  enumerize :side, Side
end
=end

module Room
  class Side < Enum::Base
  	values({:left => 'my_left', :right => 'my_right'})
  end

  COLORS = Enum[{:yellow=>'jaune', :orange => 'oranje', :blue => 'bleu'}]
end
