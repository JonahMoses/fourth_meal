class BuildSeedItems
  include Sidekiq::Worker

  def perform(restaurant_id)
    20.times do |r|
      name = item_names.sample + " #{restaurant_id}, #{r}"
      description = item_descriptions.sample
      price = sample_prices.sample
      item = Item.create!(title: name, description: description, price: price, active: true, restaurant_id: restaurant_id )
    end
  end

  def item_names
    [ "Quentin’s Drunken Noodles", 
      "Jonah’s Loco Moco", 
      "Bryana's Banana Pie", 
      "Nikhil's Curry Surprise", 
      "Simon’s Wakano", 
      "Kevin’s Can ‘O’ Tuna", 
      "Ben H’s Smoked Salmon Salad", 
      "Will’s Dining Out Delish", 
      "Adam’s Swedish Gefilte Fish", 
      "Persa’s Gluten Free Bacon Pot Pie", 
      "Ben L’s Vegetarian Fish Soup", 
      "Billy’ BBQ", 
      "Bree’s Crudite", 
      "Brian’s Buckwheat Blini", 
      "Darryl’s Cheetos and Sandwich", 
      "George’s Burger", 
      "Katrina’s Hummus salad", 
      "Lauren’s Candied Candy", 
      "Luke’s String Cheese", 
      "Meeka’s Sweet ‘N Sassy", 
      "Nathaniel’s Nacho's", 
      "Rolen’s Pho", 
      "Tyler’s Nosh Dip "
    ]
  end

  def item_descriptions
    [ "Gran Biscotto ham, tomato, greens, provolone, garlicky mayo, pesto, grilled challah bread.", 
      "Hand-carved turkey, Marie's coleslaw, Swiss cheese, Russian dressing, grilled rye bread.", 
      "Gran Biscotto ham, cheddar cheese, brown sugar cinnamon apples and onions, spicy mustard, grilled branny oat bread.", 
      "Housemade Creswick Farm corned beef, spicy mustard, Russian dressing, grilled charnushka rye bread.", 
      "Spinach, greens, parsley, cucumbers, green onion, tomato, homemade crackers, fresh garlic, sumac, olive oil.", 
      "This delicious duo, portabella mushrooms and Swiss cheese, combines for one great tasting burger.", 
      "Served with chipotle mayonnaise and crisp onion straws.", 
      "Topped with blue cheese and applewood smoked bacon, this burger is blackened and grilled.", 
      "Served with chipotle mayonnaise.", 
      "Fire-grilled lemon garlic shrimp lemon aioli dipping sauce.", 
      "A mix of fresh organic vegetables and and herbed dip.", 
      "Smoked salmon creme fraiche and salmon roe.", 
      "Served on a bed of organic greens with a sour cream horseradish sauce and homemade potato rolls.", 
      "A tower of grilled vegetables served on a grilled portabello mushroom stuffed with chevre, artichoke hearts, sun-dried tomatoes, then layered with grilled yellow squash, grilled zucchini, grilled red pepper and topped with mozzarella cheese, all served on a bed of mashed sweet potatoes drizzled with a balsamic reduction sauce.", 
      "Large Portabello Mushrooms stuffed with succulent crabmeat and topped with melted Provolone cheese.", 
      "Applewood smoked bacon, cauliflower, compressed winter chicories, honey poached cranberries and English walnut jus.", 
      "Black trumpet mushroom 'Pain Perdu,' celery branch salad, celery root and 'Sauce Bordelaise'.", 
      "Spiced wine glaze, poached french prunes, caramelized sunchoke cream, red russian kale and black pepper shortbread.", 
      "Globe artichokes, chanterelle mushrooms, bulb onions, glazed carrots and 'Bagna Cauda'.", 
      "Jacobsen orchards persimmon, marcona almonds, cilantro shoots, toasted brioche and persimmon 'Mostarda'.", 
      "Crispy garden sunchokes, broccolini florets, Meyer lemon and sunflower sprouts.", 
      "Musquée de Provence pumpkin 'Genoise,' poached cranberries, mizuna and whipped garden honey.", 
      "Flowering quince 'Pâte de Fruit,' sunchoke purée, petite garden lettuces, preserved black winter truffle and Sicilian pistachio vinaigrette.", 
      "Compressed bitter lettuces, Satsuma Man darins, globe artichokes, Marcona almonds and black winter truffle 'tapenade'.", 
      "Buckwheat 'crêpe,' Arkansas blackapples, toasted oats, Belgian endive and black winter truffle infused garden honey."
    ]
  end

  def sample_prices
    [10.02, 1.04, 9.99, 0.99, 24.99, 19.99, 12.99, 4.99]
  end

end



