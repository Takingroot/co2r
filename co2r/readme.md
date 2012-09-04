# co2r Data Models (Preliminary)

Product
-------
```
name
description
image (file)
unit_quantity
unit
unit_verbose
Organization
```

Footprint
---------
```
year
co2_per_unit
total_produced
total_offset
trees_planted
report (file)
Co2Source (many to many, store percent of production process)
Product
```

Co2Source
---------
```
name
description
```

Organization
------------
```
name
description
```

# Questions

- What are some example sources of Co2 for the production of products? Do they vary by product, not just in proportion but also in what types of activities produce carbon? What will the pie charts under Co2 sources look like?

- Is the carbon offset (in tons) always a fixed proportions of the amount of tree planted? What is the preferred way to measure?
- We know that x amount of trees were planted this year therefore x amount of tons were offset,
- We know that x tons of carbon was offset on a given year, therefore
x amount of trees were planted.
If there isn't a fixed proportion, then all this doesn't matter, we just store data for both trees and tons.