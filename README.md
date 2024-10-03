# Earthify

A super simple utility app that calculates visibility of objects in the distance based on your input data.
---

## Formulas

#### Earth's Radius
The radius value is precalculated as the mean of the semi-major and semi-minor axes.
- Imperial: 3945 miles / 208,771,785 feet
- Metric: 6350.22 kilometers / 6,350,220 meters


#### Geometric Distance
Initial calculation of distance using the standard formula
```swift
// Standard equation for geometric distance
geometricDistance = sqrt(2 * observerHeight * earthRadius)
```

#### Adjusted Distances
For higher accuracy, refraction at the horizon and refraction of the atmosphere are both taken into account.
```swift
// Incorporating horizon refraction
adjustedDistance = geometricDistance / cos(horizonRefraction)

// Incorporating atmospheric refraction to provide a final distance to the horizon
	horizonDistance = adjustedDistance * (1 + atmosphericRefraction)
```

#### Drop Over Distance
For higher accuracy, the standard drop and the drop incorporating refraction are both taken into account.
```swift
// Initial drop using the standard equation as a conversion of either metric or imperial values based on user choice.
initialDrop = (convertedDistance * convertedDistance) / (2 * earthRadius)

// Incorporating refraction to arrive at final drop
	finalDrop = initialDrop * (convertedDistance / horizonDistance)
```

#### View Obstructed & View Visible
Basic calculations to reveal the amount of an object should be hidden from view and how much should be visible at the given distance.
```swift
// The amount of drop provides the amount that should be hidden from view
viewObstructed = finalDrop

// A simple subtraction provides the amount that should remain visible, using max(0.0) to prevent negative numbers.
viewVisible = max(0.0, objectHeight - viewObstructed)
```
---

## Screenshots
![Home view showing app icon.](/earthify_home_icon.png "Home Screen")
![New tab view.](/earthify_new_tab.png "New Tab")
![Saved observation list.](/earthify_saved_list.png "Observations Tab")
![Observation view.](/earthify_observation.png "Observation View")
![Suspended view.](/earthify_suspended.png "Suspended View")
---

## Video Demo
[Watch the demo video 😁](/earthify_demo.mp4)
