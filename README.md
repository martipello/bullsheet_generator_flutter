# bullsheet_generator

A new Flutter project.

## Getting Started

Bullsheet Generator scrapes common job finding websites and compiles a list of jobs you could have potentially applied for.

Gov UK has a search option the query looks like this
$baseUrl/search?adv=1&qor=sales%20assistant&w=ws100hx&d=10&pp=50&sb=date&sd=down
This is a search for a sales assistant within 10 miles of the postcode
spaces are encoded to %20
Job Title = qor=sales%20assistant
PostCode = w=ws100hx
Radius = d=10
Items per page = pp=50
sb=date&sd=down appear to be sort by and sort direction

Total Jobs has a search option the query looks like this
$baseUrl/jobs/sales-assistant/in-ws10-0hx?radius=10
This is a search for a sales assistant within 10 miles of the postcode
spaces are not encoded and are replaced with a - fields are self-explanatory other than the "in" query on the postcode.

Indeed tries to change the location when the radius is changed for instance
searching for the postcode is fine but then changing the radius changes the location to the city the postcode is in
however searching directly in the url seems to work
This is a search for a sales assistant within 10 miles of the postcode
$baseUrl/jobs?q=Sales%20Assistant&l=WS10%200HX&radius=10&vjk=9eb2e6b6e6a119d5
spaces are encoded to %20
Job Title = q=Sales%20Assistant
PostCode = l=WS10%200HX
Radius = radius=10
vjk = no idea removing doesn't seem to affect the query
