# Blazer guide

## Context
The data in the Register service is stored in a PostgreSQL relational database.
We retrieve and manipulate data in PostgreSQL using Structured Query Language
(SQL).

You can run SQL commands against the Register database directly (without going
through the Register application). This is useful for generally finding out
information, for support or analytics purposes.

Basic SQL is straightforward. It's also one of the most durable and useful IT
skills you can learn.

Blazer is a Web interface that lets you run SQL queries directly against the
Register database.

## Getting started with Blazer

- You will need a system administrator login for Register
- Head to `/system-admin/blazer`
- Hit _New Query_ and write some SQL...

You can also: 

- Save queries for later use.
- Download data in CSV format.
- Filter to show your own or viewed queries.
- Create graphs!
- Magic columns

## Relational data and the Register data schema

Relational database organise data in tables (formally known as relations). Each
table has a fixed number of columns and variable number of rows.

e.g. a `users` table with three columns:

```
┌────┬────────────┬───────────┐
│ id │ first_name │ last_name │
├────┼────────────┼───────────┤
│  1 │ Agatha     │ Baker     │
│  2 │ Annie      │ Bell      │
│  3 │ Damian     │ Campbell  │
│  4 │ Denise     │ Theominis │
│  5 │ Emma       │ Smith     │
└────┴────────────┴───────────┘
```

Register contains about 70 tables and some tables have many columns. However most of the action focuses on a small number of core tables:

- `trainees` - stores a row for each trainee record.
- `providers` - 

If you want to explore the schema take a look at the schema tab. This lists all
70 tables so you need to have some idea about what you are looking for.

### Primary keys
Relational tables (usually) have a _primary key_ column which serves as a
unique identifier for rows in that table. In Register all of the tables has a
numeric `id` primary key column.

### Foreign keys
Relational tables are often linked. For example, rows in the `trainees` table
are linked to the `providers` table to represent the ownership of each trainee
record.

## SQL quickstart



## Example

### What proportion of trainees are doing school-based training?
### Which are the 10 biggest providers?
```
select providers.code, providers.name, trainees.provider_id, count(*) as trainee_count
from trainees 
inner join providers on providers.id = trainees.provider_id
group by providers.code, providers.name, trainees.provider_id
order by trainee_count desc
limit 10;
```

or without the smart column...

```
select trainees.provider_id, count(*) as trainee_count
from trainees 
group by trainees.provider_id
order by trainee_count desc
limit 10;
```

### Which schools offer the most placements?
```
select schools.name, count(*) as placement_count
from placements
inner join schools on schools.id = placements.school_id
group by schools.name
order by placement_count desc
limit 20;
```

### What proportion of HESA trainees have a TRN assigned?
This needs work because of `recruitment_cycle_year`...
```
select case when trn is null then 'No' else 'Yes' end as trn_allocated, count(*)
from trainees
where record_source = 'hesa_collection' and recruitment_cycle_year = 2023
group by trn_allocated;
```

### What's the distribution of degree grades for trainees in this cycle compared to last cycle?
### List of provider emails, categorised by type (HEI or SCITT)?
### List of active providers on Register
### How to remove duplicates from email lists?
