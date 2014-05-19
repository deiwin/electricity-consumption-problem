# What is this?

I happened upon [an old blog post](http://blog.codeborne.com/2012/04/every-developer-wants-to-estimate-his.html) which
defines a problem where one has electricity consumption reports in the following form:

````
Example for January 2012:
 * 1 - 2kW (hour #1 is January 1, Sunday, 00:00 - 01:00 - NIGHT)
 * 2 - 3kW (hour #2 is January 1, Sunday, 01:00 - 02:00 - NIGHT)
 * 26 - 3kW (hour #26 is January 2, Monday, 01:00 - 02:00 - NIGHT)
 * 32 - 6kW (hour #32 is January 2, Monday, 07:00 - 08:00 - DAY)
 ...
 * 744 - 0kW (hour #744 is January 31, 23:00 - 24:00)
````

From these reports the total day and night consumptions should be calculated for the month. I was bored, so I went ahead
and implemented a solution.

# Okay, how does it work then?

See `spec/full_spec.rb` for examples.
