AtlatlMapKitDemo
================

I took this assignment as a way to get to know custom callout buttons on a Map View.

Here's the requirements from the assignment:
--------------

Prototype a Map in iOS using map and/or location API's.
- Find my location
- Use a custom icon

See attached spreadsheet for addresses:
- Plot the location of the 5 people
- Show a photo of each on the map
- Tap on the photo to open a window with more contact detail
- Close the window to return to the map

And the implementation details:
--------------

I've used MapKit in a number of different apps, but the requirements here were to display a photo of each of the five people on the map (which meant custom callouts, which I've never had a need 
to do before).  I leveraged some open source code to display a button containing images in the callout, and also a function to zoom the map into a region containing all the annotation (pin) 
points.  Since the geolocation object can only handle one address resolution at a time, I use notifications to push the progress of resolving addresses along from person to person.

This app is done as a Universal App, meaning it runs and looks proper on both an iPhone screen and on an iPad screen.


