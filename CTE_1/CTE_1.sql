
-- Select all data from the recipe table.
select * from recipe;

-- Select all columns from the table ingredient table.
select * from ingredient;

-- Select all data from the recipe_ingredients table.
select * from recipe_ingredients;

-- Select name and type of ingredient to obtain the following types: vegetable, fruit or sweets.
select name, type from ingredient
where type in ("vegetable", "fruit", "sweets");

-- Find all recipes, but select only name, rating, and cook_time for recipe. 
-- Sort records in order of descending rating, with names of equally rated recipes in alphabetical (ascending) order.
select 
name, 
rating,
cook_time
from recipe
ORDER BY rating DESC, name ASC;

-- For each ingredient type, find the number of ingredients. Name the columns type and number_of_ingredients.
SELECT
  type,
  COUNT(id) AS number_of_ingredients
FROM ingredient
GROUP BY type;

-- The preparation of recipes takes some time. Find the shortest and longest cooking times. 
-- In the result table, display the shortest cooking time (name column as min_time), 
-- and the longest cooking time (name column as max_time).
select 
min(cook_time) AS min_time,
max(cook_time) AS max_time
from recipe;

-- How many recipes are assigned to each preference rating?
-- Only select ratings with the number of recipes higher than 1. Name the columns rating and number_of_recipes.
SELECT
  rating,
  COUNT(id) AS number_of_recipes
FROM recipe
GROUP BY rating
HAVING COUNT(id) > 1;

-- Each recipe contains a different number of ingredients. Find the number of ingredients in each recipe. 
-- Select only those recipes which have fewer than 5 ingredients. Display the recipe name and number of ingredients 
-- (name the column number_of_ingredients).

SELECT
  r.name,
  COUNT(ri.ingredient_id) AS number_of_ingredients
FROM recipe_ingredients AS ri
JOIN recipe AS r
  ON ri.recipe_id = r.id
GROUP BY r.name
HAVING COUNT(ri.ingredient_id) < 5;


-- A lot of people don't have much time to cook. 
-- Get the recipes which have cooking times below average for all recipes in the recipe table. 
-- Return the names and cooking times for those recipes.
SELECT 
    name, cook_time
FROM
    recipe
WHERE
    cook_time < (SELECT 
            AVG(cook_time)
        FROM
            recipe);



-- A lot of people like sweets very much. We're willing to bet you do, too! 
-- Which recipes include sweets? Get names of recipes which include at least one ingredient of type 'sweets', 
-- but whose ingredient name is not 'sugar'.

SELECT DISTINCT
  r.name
FROM recipe AS r
JOIN recipe_ingredients AS ri
  ON ri.recipe_id = r.id
JOIN ingredient AS i
  ON ri.ingredient_id = i.id
WHERE i.type = 'sweets'
  AND i.id = ANY (
  SELECT
    ii.id 
  FROM ingredient AS ii
  WHERE ii.name !='sugar'
);




