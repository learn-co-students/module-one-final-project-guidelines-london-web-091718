require "pry"

categories=[{"color"=>"#f3c32c", "name"=>"Housing", "score_out_of_10"=>6.3950000000000005},
 {"color"=>"#f3d630", "name"=>"Cost of Living", "score_out_of_10"=>5.524},
 {"color"=>"#f4eb33", "name"=>"Startups", "score_out_of_10"=>9.084999999999999},
 {"color"=>"#d2ed31", "name"=>"Venture Capital", "score_out_of_10"=>7.757},
 {"color"=>"#7adc29", "name"=>"Travel Connectivity", "score_out_of_10"=>7.024999999999999},
 {"color"=>"#36cc24", "name"=>"Commute", "score_out_of_10"=>6.1960000000000015},
 {"color"=>"#19ad51", "name"=>"Business Freedom", "score_out_of_10"=>9.072333333333333},
 {"color"=>"#0d6999", "name"=>"Safety", "score_out_of_10"=>7.251500000000001},
 {"color"=>"#051fa5", "name"=>"Healthcare", "score_out_of_10"=>8.543333333333331},
 {"color"=>"#150e78", "name"=>"Education", "score_out_of_10"=>7.019000000000001},
 {"color"=>"#3d14a4", "name"=>"Environmental Quality", "score_out_of_10"=>6.771500000000001},
 {"color"=>"#5c14a1", "name"=>"Economy", "score_out_of_10"=>5.373500000000001},
 {"color"=>"#88149f", "name"=>"Taxation", "score_out_of_10"=>3.9034999999999997},
 {"color"=>"#b9117d", "name"=>"Internet Access", "score_out_of_10"=>4.677999999999999},
 {"color"=>"#d10d54", "name"=>"Leisure & Culture", "score_out_of_10"=>8.881},
 {"color"=>"#e70c26", "name"=>"Tolerance", "score_out_of_10"=>7.177499999999998},
 {"color"=>"#f1351b", "name"=>"Outdoors", "score_out_of_10"=>5.475000000000001}]


 def formatting_categories(categories)
   cats=Hash.new(0)
   categories.each do |c|
     key=c["name"]
     value=c["score_out_of_10"]
     cats[key]=value.to_s.to_i.to_s + " /10"
   end
   cats
 end

binding.pry


0
