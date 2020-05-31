-- MAP LIST ELEMENTS --

-- Map elements of the list:
-- var numbers = new [] { 1, 2, 3 ,4 };
-- numbers.Select(n => "Number " + n.ToString())
nums = [ "Number " ++ show n | n <- [1..4] ]


-- Filter elements:
-- var numbers = new [] { 1, 2, 3 ,4 };
-- numbers.Where(n => n % 2 == 0)
evens = [ n | n <- [1..4], (mod n 2) == 0 ]


-- Join arrays:
-- var zoo = new [] { new { Type = "Lion", Count = "5" }, new { Type = "Owl", Count = "3" } };
-- var animals = new [] {new { Name = "Leo", AnimalType = "Lion" }, new { Name = "Yoll", AnimalType = "Owl" }};
-- animals.Join(zoo, a => a.AnimalType, z => z.Type, (a, z) => a.Name + " is one of " + z.Count + " " + z.Type + "s")
-- { "Leo is one of the 5 Lions", "Yoll is one of the 3 Owls" }
data Animal = Animal { animalType::String, name::String }
data Statistic = Statistic { statType::String, amount::String }

zoo = [ Statistic { statType="Lion", amount="5" }, Statistic { statType="Owl", amount="3" } ]
animals = [ Animal { animalType="Lion", name="Leo" }, Animal { animalType="Owl", name="Yoll" } ]

report = [ name a ++ " is on of " ++ amount z ++ " " ++ statType z ++ "s" 
            | a <- animals, z <- zoo, animalType a == statType z ]
