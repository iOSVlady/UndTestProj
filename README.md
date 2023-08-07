# UndTestProj

MyFriends Test Application
https://github.com/iOSVlady/UndTestProj/assets/46273878/2e40f259-45a4-46ef-9d62-60336f39130c

Screen 1 - List of users(friends)

• Each row contains a photo and first/last name.
• Add button is placed in the navigation bar, on tap it opens Screen 2.
• Table view is always presented in edit mode with the possibility to delete friends.
• On delete action the application removes user from friends (from the current list) but keeps it in the database with some flag that this user is not a friend anymore.

Screen 2 - Add screen:

• Screen with a list of random users that is loaded from the server. Tap on row should add a user to friends list (Screen 1).
• UITableView has infinite scroll on this screen

Other conditions:
• API: https://randomuser.me
• Application stores all friends in a local database.



