# Pet Finder

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Code Sprint 4 Gif
![petfoster4](https://user-images.githubusercontent.com/70172259/166341590-83628257-25cf-45ab-b30d-5578834c0030.gif)

## Code Sprint 3 Gif
![petfoster3](https://user-images.githubusercontent.com/70172259/165195747-6aa785f8-8797-4afc-bd6b-25bee21b4ba1.gif)


## Code Sprint 2 Gif 
![petfoster2](https://user-images.githubusercontent.com/70172259/163904530-cdf8c8f7-053f-462b-8d8a-abeced2f8ce2.gif)


## Code Sprint #1 Gif
![petpart1](https://user-images.githubusercontent.com/70172259/162851643-fc1f5c70-1dc2-4204-a18b-b15a630fa998.gif)


## Overview
### Description
A pet foster app where users can find and post listings for pets in need of a foster home 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:**
    - Social Networking / Lifestyle
- **Mobile:**
    - Camera for taking picture of Pet.
    - Location to get address for where the pet can be picked-up
- **Story:**
    - The value is making pet adoption easier and fun
- **Market:**
    - Pet owners, people who'd like to adopt a pet.
    - People who enjoy animals
- **Habit:**
    - Can be used constantly if a user has many pets, or is a breeder of pets
- **Scope:**
    - Shouldn't be very challenging to meet the MVP by the end of the course

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [x] User can Login
* [x] User can Sign Up
* [X] User can post a listing for a pet, with a photo and other info
* [X] User can select cell for more information
* [X] User can adopt pet from detailed view
* [X] User can search for keywords (species, breed, age)
* [X] User can post comments on a listing

**Optional Nice-to-have Stories AKA Stretch goals**

* [ ] Infinite Scrolling
* [ ] User can sort listings by location via dropdown selection 
* [X] Refresh Listings
* [ ] Add location of listing via map 

### 2. Screen Archetypes

* Login
   * User can login to the app
* Register
   * User can create an account for the app
* Stream
    * View listings
* Create
    * Post listing
* Detail
    * Viewed detailed information about a listing
* Settings
    * User can set filters for the listing view 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Stream (View Pet Listings)
* Create (Post New Pet Listing)

**Flow Navigation** (Screen to Screen)

* Login
    * Stream
* Register
    * Stream
* Stream
   * Settings
   * Create
   * Detail

## Wireframes
![](https://i.imgur.com/qfnFtCw.jpg)

### [BONUS] Digital Wireframes & Mockups
![](https://i.imgur.com/TusPJBP.png)


### [BONUS] Interactive Prototype

## Schema 
### Models

#### Listing
| Property    | Type             | Description                                  |
| ----------- | ---------------- | -------------------------------------------- |
| age         | Int              | The pet's age (in years)                     |
| description | String           | Description for misc info                    |
| species     | String           | The pet's species                            |
| name        | String           | Name of pet                                  |
| owner       | Pointer to User  | Reference to the user who posted the listing |
| comments    | List of Comments | Comments posted to the listing               |
| claimedBy   | Pointer to User  | The user who adopted the pet                 |
| datePosted            |    DateTime              |    The time of the post                                          |
| image       | File             | Picture of pet supplied by user              |

#### Comment

| Property | Type               | Description                           |
| -------- | ------------------ | ------------------------------------- |
| listing  | Pointer to Listing | The listing the comment was posted to |
| text     | String             | The contents of the comment           |
| datePosted         |         DateTime           |      The time the comment was posted                                 |
| author   | Pointer to User    | The author of the comment             |



### Networking
#### List of network requests by screen
- Listing Stream View
    - (Read/GET) Query all pet listings
    `let query = PFQuery(className:"Listing")
query.order(byDescending: "datePosted")
query.findObjectsInBackground { (listings: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let listings = listings {
      print("Successfully retrieved \(listings.count) listings.")
  // TODO: Do something with listings...
   }
}`
- Listing Detail View
    - (Create/POST) Add a comment to the listing
 
```
let comment = PFObject(className: "comments")
        comment["text"] = text
        comment["listing"] = selectedListing
        comment["author"] = PFUser.current()
```

    selectedListing.add(comment, forKey: "comments")

    selectedListing.saveInBackground{( success, error ) in
        if success {
            print("Comment saving Success!")
        } else {
            print("Error saving comment")
        }
    }

- (Update/PUT) Adopt the pet
```
class Pet: SKScene {

   var name: String?
   var age : Int!
   var species = String?
   var claimedBy = String?

   init(claimedBy: String) {
    super.init()
    self.claimedBy = claimedBy
   }

   required init(coder aDecoder: NSCoder) {
     super.init()
   }

}

func callFunctionOutsideClass(){
}
```


- (Read/GET) Display the listing's comments



```
let query =PFQuery(className:"Comments")
        query.order(byDescending: "datePosted")query.findObjectsInBackground { (comments: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let comments = comments {
          print("Successfully retrieved \(comments.count) comments.")
      // TODO: Do something with comments...
       }
    }
```


- Create Post Screen
    - (Create/POST) Create a new listing
    
        ```let listing = PFObject(className: "listings")
        
        listing["owner"] = PFUser.current()!
        post["description"] = descField.text!
        // ... get other values
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        listing["image"] = file
