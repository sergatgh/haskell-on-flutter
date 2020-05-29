-- ANALOGIES OF HASKELL LISTS FROM C# LANGUAGE --

-- Getting an array element by index:
-- var str = "Witty Lion";
-- str[4]
y = "Witty Lion" !! 4


-- Contains elements:
-- var array = new int[0];
-- array.Any()
noElements = null []


-- Count and Length:
-- var array = new [] {1,2,3};
-- array.Count()
count = length [1,2,3]


-- Insert in the beggining:
-- var list = "tick".ToList();
-- list.Insert(0, 'S');
stick = 'S' : "tick"


-- Concatanations:
-- var list = new [] {1,2,3}.ToList();
-- list.AddRange(new [] { 4, 5, 6 });
list = [1,2,3] ++ [4,5,6]
bingo = "bin" ++ "go"


-- First element:
-- var array = new [] {1,2,3};
-- var first = array.First();
one = head [1,2,3]
w = head "woman"


-- Last element:
-- var array = new [] {1,2,3};
-- var last = array.Last();
three = last [1,2,3]
n = last "man"


-- Skip first:
-- var array = new [] {1,2,3};
-- var tail = array.Skip(1);
skipFirst = tail [1,2,3] -- [2,3]


-- Skip several:
-- var array = new [] {1,2,3,4,5};
-- var tail = array.Skip(3);
skipSeveral = drop 3 [1,2,3,4,5] -- [4,5]


-- Skip last:
-- var array = new [] {1,2,3};
-- var initial = array.Take(array.Length - 1);
withoutLast = init [1,2,3]


-- Take first N:
-- var array = new [] {1,2,3,4,5};
-- var initial = array.Take(3);
firstN = take 3 [1,2,3,4,5]
app = take 3 "apples"
