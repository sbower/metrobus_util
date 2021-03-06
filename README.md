# Metrobus Utilities

This repository contains to sample applications that use the metrobus gem, https://github.com/sbower/metrobus.  The first is a simple CLI application that will accept a bus route, direction and stop.  The application will then provide the next departure time in minutes.  The second application is a crude web site that provides the same function.

If I had more time I would look at using the GTFS data provided here https://gisdata.mn.gov/dataset/us-mn-state-metc-trans-transit-schedule-google-fd to improve the application.  This data is updated weekly and would be easy to store in an RDBMS or no SQL database.  Combined with the routes listed which is generated daily I think you would be able to get away with only one hit to the rest service using the STOPID endpoint.  I would then look at brining redis into the mix to cache results, as the site states the departures are only updated every 30 seconds.  Also by caching the results we could provide a circuit breaker if the rest service were to go down.

