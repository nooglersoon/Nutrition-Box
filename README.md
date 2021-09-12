# Nutrition-Box

Nutrition Box is an iOS App that helps people identify the food around them through photos. 
Users can choose the source of their photos, namely through photo albums or take pictures directly. 
After the photo is selected or taken, the photo will be processed for detection using machine learning to tell the name of the food from the processed photo. 
After that, the user can find out the content of the food such as the total weight (in one unit), the number of calories, and the nutritional content in the food. 
Users can save the results of identification of food nutrients which will be stored in a report using a table.

## Technology used in this project:

1. UIKit
2. CoreML / Vision
3. Native iOS Networking
4. CoreData

## External resources that used in this project:

1. Inception V3 (https://developer.apple.com/machine-learning/models/) - CoreML Model to Identify the Photo Object
2. Edamam API (https://developer.edamam.com/edamam-docs-nutrition-api) - Nutritions Analysis API to analyze nutrition of the given food (parameters)

## Application Details

1. Build for iOS 14.5 and above
2. Build with XCode 12
3. Using Swift 5
