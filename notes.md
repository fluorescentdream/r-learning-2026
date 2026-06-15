# R learning notes

## june 14 - setup day

### git
- git status: shows current state of repo
- git add: stages changes
- git commit: saves snapshot locally
- git push: uploads to github

### setup done today
- installed git
- connected git to rstudio project
- created first repo structure
# - bro this shits hard


## june 15 - R variables and data types!

### variable types:
- integer: whole numbers (1, 100, -9)
- numeric: decimals (0.1, -0.09, 234.567)
- character: text ("a", "hello")
- logical: booleans (TRUE or FALSE)
- factor: categorical ("green", "blue", "purple")
- missing: logical type (NA)
- empty: NULL 

### data types: 
- vector: 1D collection of variables of the same type
- matrix: 2D collection of variables of the same type
- data frame: 2D collection of variables of MULTIPLE types

### text
myname <- "sigma"
class(myname) ---> use class() to see what data type it is!
[1] "character"

### numbers
integer1 <- as.integer(8)
print(integer1)
[1] 8
class(integer1)
[1] "integer"

numbers can be numeric which are decimals
numeric1 <- as.numeric(8.8)
print(numeric1)
[1] 8.8
class(numeric1)
[1] "numeric"

### logical 
use == to test for equality in R
class(TRUE)
[1] "logical"
numeric1 == 8.8
[1] TRUE

### vectors
1D data structures

1:10 
[1] 1 2 3 4 5 6 7 8 9 10

2*(1:10)
[1] 2 4 6 8 10 12 14 16 18 20

seq(0, 10, 2) ---> count by 2s from 1 to 10
[1] 0 2 4 6 8 10

myvector <- 1:10

2^myvector 
[1] 2 4 8 16 32 64 128 256 512 1024

b = c(3, 4, 5) ---> c is combine/concatenate into a single vector/list
b^2
[1] 9 16 25

### factors in R
a factor is used to store categorical data. instead of treating values as plain text, R recognizes them as categories.

creating a factor:
disorders <- c("anxiety", "autism", "depression", "ocd")
disorders <- as.factor(disorders)
class(disorders)

output:
[1] "factor"

factor levels:
levels are the unique categories stored in a factor. 

levels(disorders)

output:
[1] "anxiety" "autism" "depression" "ocd"

count the number of categories:

nlevels(disorders)

output:
[1] 4

why use factors?
without factors:
disorders <- c("anxiety", "autism", "anxiety", "ocd")
R sees these as text strings.

with factors:
disorders <- factor(disorders)
R understands that these values represent categories.
internally, R stores categories efficiently using integer codes.

but conceptually:
1 = anxiety
2 = autism
3 = ocd

while still displaying the category names.

unordered factors:
some categories have no natural ranking.
example:

cancer_type <- factor(
  c("breast", "lung", "colon")
)

there is no meaningful order: breast < lung < colon does not make sense.

ordered factors:
some categories have a natural ranking.

example:

responses <- c(
  "low",
  "high",
  "medium",
  "low"
)

myorderedfactor <- factor(
  responses,
  levels = c("low", "medium", "high"),
  ordered = TRUE
)

now R knows: low < medium < high

check levels:
levels(myorderedfactor)

output:
[1] "low" "medium" "high"

why ordering matters:

unordered factor:

myfactor <- factor(responses)
min(myfactor)

output:
Error: 'min' not meaningful for factors
R cannot determine the smallest category because no order exists.

ordered factor:

min(myorderedfactor)

output:
[1] low

because we explicitly defined: low < medium < high

### data frames!
a data frame is R's table structure. rows should represent instances or individual observations e.g. data points, patients, events, samples, etc. while
columns will represent different types of data associated with each data point or instance e.g. Name, ID, location, time, value…

creating a data frame:
bmc.data <- data.frame(
  fname = c("Alice", "Bob"),
  age = c(20, 45)
)

inspecting data:
- View(bmc.data) = view table
- nrow (bmc.data) = number of rows
- ncol(bmc. data) = number of cols
- dim(bmc.data) = dimensions
- returns: (rows, columns)

looking at data:
- head(bmc.data) = first 6 rows by default
- head(bmc.data, 3) = first 3 rows
- tail (bmc.data, 2) = last 2 rows

subsetting rows and columns:
- general format: dataframe[rows, columns]
- bmc.data[1:3, ] - first 3 rows
- bmc.data[, "age"] - column by name
- bmc.data[, c("fname", "age")] - multiple columns
- bmc.data[1:3, c(2,5)] - rows 1-3 and columns 2 AND 5, not 2-5

accessing a column:
- dataframe$column
- bmc.data$age - returns 20 45 15 12

filtering rows:
- general pattern - dataframe[condition, ]

which(): 
returns row numbers where condition is TRUE
- which(bmc.data$gender == "Female") returns: 1 3
- can be used for filtering: bmc.data[which(bmc.data$gender == "Female"), ]

but usually the direct logical version is simpler.

combining filtering and column selection:
return names of patients older than 16-
bmc.data[bmc.data$age > 16, ]$fname

alternative-
bmc.data[bmc.data$age > 16, "fname"]

adding rows:
- use rbind() - row bind
- bmc.data <- rbind(bmc.data, new.person)