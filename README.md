# Jogo

This application is a basic jog tracker. Write hello to sign in.

# Technologies used: 
  * Swift 
  * Realm 
  * Alamofire 
  * SwiftyJSON
  * SwiftKeychainWrapper
  * MVVM
  
# MVVM 
There are key points, why I have chosen this architecural pattern 
  * Separation of user interface from application logic - this gives us simple modifiability
  * This pattern is popular among developers what makes my code understandable for majority of people
  * MVVM streamlines the process of resubmiting data on a screen by sending only the necessary data, thereby boosting performance. (Actualy, due to the fact I've learned about client-server requests while writing this project, I accidentally missed this point in MVVM, but if you will give me more time I will redesign the project)
    
  
# Features added: 
  * Loging a user through uuid
  * Page with a list of existing jogs
      * filtering a list of jogs
      * adding a jog
      * updating a jog
  * Page with a list of weeks with statistics
  * Page with info
  * Page with contacts
    * page to send feedback
