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
    %w[ Quentin’s_Drunken_Noodles Jonah’s_Loco_Moco Bryanna's_Banana_Pie Nikhil's_Curry_Surprise Simon’s_Wakano Kevin’s_Can_‘O’_Tuna Ben_H’s_Smoked_Salmon_Salad Will’s_Dining_Out_Delish Adam’s_Swedish_Gefilte_Fish Persa’s_Gluten_Free_Bacon_Pot_Pie Ben_L’s_Vegetarian_Fish_Soup Billy’_BBQ Bree’s_Crudite Brian’s_Buckwheat_Blini Darryl’s_Cheetos_and_Sandwich George’s_Burger Katrina’s_Hummus_salad Lauren’s_Candied_Candy Luke’s_String_Cheese Meeka’s_Sweet_‘N_Sassy Nathaniel’s_Nacho's Rolen’s_Pho Tyler’s_Nosh_Dip ]
  end

  def item_descriptions
    %w[ Gran_Biscotto_ham,_tomato,_greens,_provolone,_garlicky_mayo,_pesto,_grilled_challah_bread. Hand-carved_turkey,_Marie's_coleslaw,_Swiss_cheese,_Russian_dressing,_grilled_rye_bread. Gran_Biscotto_ham,_cheddar_cheese,_brown_sugar_cinnamon_apples_and_onions,_spicy_mustard,_grilled_branny_oat_bread. Housemade_Creswick_Farm_corned_beef,_spicy_mustard,_Russian_dressing,_grilled_charnushka_rye_bread. Spinach,_greens,_parsley,_cucumbers,_green_onion,_tomato,_homemade_crackers,_fresh_garlic,_sumac,_olive_oil. This_delicious_duo,_portabella_mushrooms_and_Swiss_cheese,_combines_for_one_great_tasting_burger._Served_with_chipotle_mayonnaise_and_crisp_onion_straws. Topped_with_blue_cheese_and_applewood_smoked_bacon,_this_burger_is_blackened_and_grilled._Served_with_chipotle_mayonnaise. Fire-grilled_lemon_garlic_shrimp_lemon_aioli_dipping_sauce. A_mix_of_fresh_organic_vegetables_and_and_herbed_dip. Smoked_salmon_creme_fraiche_and_salmon_roe. Served_on_a_bed_of_organic_greens_with_a_sour_cream_horseradish_sauce_and_homemade_potato_rolls. A_tower_of_grilled_vegetables_served_on_a_grilled_portabello_mushroom_stuffed_with_chevre,_artichoke_hearts,_sun-dried_tomatoes,_then_layered_with_grilled_yellow_squash,_grilled_zucchini,_grilled_red_pepper_and_topped_with_mozzarella_cheese,_all_served_on_a_bed_of_mashed_sweet_potatoes_drizzled_with_a_balsamic_reduction_sauce. Large_Portabello_Mushrooms_stuffed_with_succulent_crabmeat_and_topped_with_melted_Provolone_cheese. Applewood_smoked_bacon,_cauliflower,_compressed_winter_chicories,_honey_poached_cranberries_and_English_walnut_jus. Black_trumpet_mushroom_“Pain_Perdu,”_celery_branch_salad,_celery_root_and_“Sauce_Bordelaise”. Spiced_wine_glaze,_poached_french_prunes,_caramelized_sunchoke_cream,_red_russian_kale_and_black_pepper_shortbread. Globe_artichokes,_chanterelle_mushrooms,_bulb_onions,_glazed_carrots_and_“Bagna_Cauda”. Jacobsen_orchards_persimmon,_marcona_almonds,_cilantro_shoots,_toasted_brioche_and_persimmon_“Mostarda”. Crispy_garden_sunchokes,_broccolini_florets,_Meyer_lemon_and_sunflower_sprouts. Musquée_de_Provence_pumpkin_“Genoise,”_poached_cranberries,_mizuna_and_whipped_garden_honey. Flowering_quince_“Pâte_de_Fruit,”_sunchoke_purée,_petite_garden_lettuces,_preserved_black_winter_truffle_and_Sicilian_pistachio_vinaigrette. Compressed_bitter_lettuces,_Satsuma_Man_darins,_globe_artichokes,_Marcona_almonds_and_black_winter_truffle_“tapenade”. Buckwheat_“crêpe,”_Arkansas_blackapples,_toasted_oats,_Belgian_endive_and_black_winter_truffle_infused_garden_honey.]
  end

  def sample_prices
    [10.02, 1.04, 9.99, 0.99]
  end

end



