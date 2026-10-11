\set ON_ERROR_STOP on
\echo === WEEK 04: dimensions (only adds or updates demo reference rows) ===
\timing on
BEGIN;

-- 40 realistic menu categories added to the 10 existing categories.
INSERT INTO food_delivery.category (name, description)
VALUES
 ('Pasta','Italian pasta dishes and sauces'),
 ('Noodles','Asian and Central Asian noodle dishes'),
 ('Soups','Freshly prepared hot soups'),
 ('Grill','Meat and vegetables from the grill'),
 ('Kebabs','Skewered meats and kebab dishes'),
 ('Steaks','Beef and other steak dishes'),
 ('Seafood','Fish and seafood mains'),
 ('Rice','Rice-based dishes and pilaf'),
 ('Dumplings','Dumplings and manti'),
 ('Baked Goods','Fresh bread and baked snacks'),
 ('Sandwiches','Sandwiches and toasties'),
 ('Wraps','Chicken and vegetable wraps'),
 ('Street Food','Popular takeaway street food'),
 ('Hot Appetizers','Hot snacks and starters'),
 ('Cold Appetizers','Cold starters and mezze'),
 ('Vegetarian','Meals without meat or fish'),
 ('Vegan','Plant-based dishes'),
 ('Healthy Bowls','Balanced grain and vegetable bowls'),
 ('Family Meals','Large portions for sharing'),
 ('Kids Menu','Meals designed for children'),
 ('Coffee','Coffee and espresso drinks'),
 ('Tea','Black, green and herbal tea'),
 ('Fresh Juices','Freshly squeezed juices'),
 ('Smoothies','Fruit and yogurt smoothies'),
 ('Milkshakes','Cold milk-based drinks'),
 ('Ice Cream','Ice cream and frozen desserts'),
 ('Cakes','Sliced cakes and celebration cakes'),
 ('Pastries','Baked sweet pastries'),
 ('Waffles','Sweet waffles and toppings'),
 ('Pancakes','Pancakes with sweet or savory fillings'),
 ('Omelettes','Egg dishes and omelettes'),
 ('Porridge','Oatmeal and breakfast porridge'),
 ('Falafel','Chickpea falafel meals'),
 ('Shawarma','Shawarma and doner wraps'),
 ('Ramen','Japanese ramen noodle soups'),
 ('Pho','Vietnamese noodle soups'),
 ('Tacos','Tacos with assorted fillings'),
 ('Burritos','Rice and bean burritos'),
 ('BBQ','Slow-cooked barbecue dishes'),
 ('Traditional Soups','Traditional regional soups')
ON CONFLICT (name) DO NOTHING;

-- Improve placeholder names from the original sample without altering their IDs.
-- Real customers/couriers with non-placeholder names remain unchanged.
UPDATE food_delivery.customer AS c
SET full_name =
 (ARRAY['Ayan','Arman','Aruzhan','Madina','Daniyar','Alina','Dias','Aigerim','Timur','Dana'])
    [((c.customer_id::int - 1) % 10) + 1] || ' ' ||
 (ARRAY['Sadykov','Omarov','Kassenov','Akhmetov','Tulegenov'])
    [((c.customer_id::int - 1) / 10) % 5 + 1]
WHERE c.full_name LIKE 'Customer %';

UPDATE food_delivery.courier AS c
SET full_name =
 (ARRAY['Ayan','Dias','Arman','Daulet','Miras','Timur','Nursultan','Alisher','Bekzat','Erlan'])
    [((c.courier_id::int - 1) % 10) + 1] || ' ' ||
 (ARRAY['Kassenov','Omarov','Sadykov','Akhmetov','Tulegenov'])
    [((c.courier_id::int - 1) / 10) % 5 + 1]
WHERE c.full_name LIKE 'Courier %';

-- Another 30 couriers: original data have 20.
INSERT INTO food_delivery.courier
    (full_name, phone, transport_type, rating, hire_date)
SELECT
    (ARRAY['Ayan','Arman','Dias','Nursultan','Alisher','Daulet','Miras','Timur','Erlan','Bekzat'])[((g.n - 1) % 10) + 1] || ' ' ||
    (ARRAY['Sadykov','Omarov','Tulegenov','Akhmetov','Nurgaliyev','Kassenov','Iskakov','Rakhimov','Abayev','Serikov'])[((g.n - 1) / 10) + 1],
    '+770799' || lpad(g.n::text, 5, '0'),
    (ARRAY['bicycle','scooter','motorcycle','car','walking'])[((g.n - 1) % 5) + 1],
    (4.0 + (g.n % 10) * 0.1)::numeric(2,1),
    date '2026-02-01' + g.n
FROM generate_series(1,30) AS g(n)
WHERE NOT EXISTS (
  SELECT 1 FROM food_delivery.courier c
  WHERE c.phone = '+770799' || lpad(g.n::text, 5, '0')
);

-- 40 sample restaurants in Almaty: names/addresses are illustrative, not real listings.
WITH source AS (
  SELECT n,
      (ARRAY['Alatau Grill','Aport Cafe','Nomad Noodles','Orda Kitchen',
             'Zheti Kazyna','Tasty Bowl','Baiterek Bistro','Sary Arka BBQ',
             'Silk Road Pasta','Green Garden'])[((n - 1) % 10) + 1]
      || ' - ' ||
      (ARRAY['Almaly','Bostandyk','Auezov','Medeu'])[((n - 1) / 10) + 1] AS restaurant_name
  FROM generate_series(1,40) AS g(n)
)
INSERT INTO food_delivery.restaurant (name, address, phone, rating)
SELECT restaurant_name,
       'Almaty, Abay Ave, ' || (100 + n)::text,
       '+7707888' || lpad(n::text,4,'0'),
       (4.0 + (n % 10) * 0.1)::numeric(2,1)
FROM source
WHERE true
ON CONFLICT (name, address) DO UPDATE
   SET phone = EXCLUDED.phone,
       rating = EXCLUDED.rating;

-- Two dishes per new restaurant (80), keeping names unique within each restaurant.
WITH source AS (
 SELECT r.restaurant_id, (right(r.phone,4)::int - 1) % 10 + 1 AS kind, v.variant
 FROM food_delivery.restaurant r
 CROSS JOIN generate_series(1,2) AS v(variant)
 WHERE r.phone LIKE '+7707888%'
), menu AS (
 SELECT restaurant_id, variant, kind,
  CASE WHEN variant = 1 THEN
   (ARRAY['Grilled Chicken','Classic Lagman','Beef Burger','Margherita Pizza',
          'Beshbarmak','Chicken Bowl','Salmon Sushi','Beef Steak',
          'Pasta Alfredo','Vegetable Salad'])[kind]
  ELSE
   (ARRAY['Grill Set','Spicy Noodles','Cheeseburger','Pepperoni Pizza',
          'Baursaks','Salmon Bowl','California Roll','BBQ Ribs',
          'Pasta Pesto','Vegetable Soup'])[kind]
  END AS dish_name
 FROM source
)
INSERT INTO food_delivery.dish (restaurant_id, name, description, price, is_available)
SELECT restaurant_id, dish_name,
       'Freshly prepared ' || dish_name || ' for food delivery',
       (1400 + 175 * kind + 250 * variant)::numeric(10,2),
       true
FROM menu
WHERE true
ON CONFLICT (restaurant_id, name) DO UPDATE
 SET description = EXCLUDED.description,
     price = EXCLUDED.price,
     is_available = EXCLUDED.is_available;

-- Categorize both new dishes from each restaurant.
WITH links AS (
 SELECT d.dish_id,
 (ARRAY['Grill','Noodles','Burgers','Pizza','Kazakh Cuisine',
        'Healthy Bowls','Sushi','Steaks','Pasta','Salads'])[
          ((right(r.phone,4)::int - 1) % 10) + 1
        ] AS category_name
 FROM food_delivery.dish d
 JOIN food_delivery.restaurant r ON r.restaurant_id = d.restaurant_id
 WHERE r.phone LIKE '+7707888%'
)
INSERT INTO food_delivery.dish_category (dish_id, category_id, is_primary)
SELECT l.dish_id, c.category_id, true
FROM links l
JOIN food_delivery.category c ON c.name = l.category_name
WHERE true
ON CONFLICT (dish_id,category_id) DO NOTHING;

COMMIT;
\echo === Dimensions finished ===
