# Using the Roost API

Welcome to the Roost Microblog API, this doc will guide you through the use of our API.

All API access is over HTTP, and accessed from http://roost-microblog.herokuapp.com/api. All data is sent and received as JSON.

## Authentication

Authencation is done through HTTP Token Authentican. Each User will be provided a token on registred. Registration route is an unauthenticated route. To access tokens you will need to login or create a user.

### To Create a Rooster:

go to `/roosters` to create a user as a POST request  

The request body should be:
```json
{ "user": 
      {
        "username": "username"
        "password": "password"
      }
}
```
The response will be:
```json
{
    "id": 1XX,
    "username": "username",
    "password_digest": "digested password",
    "api_token": "User's Token",
    "created_at": "2018-09-08T18:48:06.022Z",
    "updated_at": "2018-09-08T18:48:06.022Z"
}
```
-Username validates on uniquesness  
-Password has no validations  

### If User exist 

  Go to `/session` to login with username and password  
  On successful login the response will be the Rooster's api_token  

## Roosters

  Roosters can create Clucks, Follow Other Roosters, Favorite Clucks, and Repost Clucks  

### Getting Profile Info 

  Must be logged in and authenticated  
  To go to your Roost Profile, `GET /profile`   
  Response will be:  
  ```json
  {
    "links": {
        "self": "http://roost-microblog.herokuapp.com/api/users/(roosterid)",
        "list": "http://roost-microblog.herokuapp.com/api/users",
        "update": {
            "method": "PUT",
            "href": "http://roost-microblog.herokuapp.com/api/users/(roosterid)"
        },
        "delete": {
            "method": "DELETE",
            "href": "http://roost-microblog.herokuapp.com/api/users/(roosterid)"
        }
    },
    "data": {
        "id": "(roosterid)",
        "attributes": {
            "username": "username",
            "api_token": "Rooster's Token",
            "post": 0,
            "followers": 0
        }
    }
  }
  ```
  The JSON resonse shows you the endpaths to update or delete. Only owners of the Roosts profile can use though methods

  To go to all users, `GET /roosters`  
   The repsonse will be an abridged JSON response with just username and id  

### Following/Unfollowing another Rooster

  To follow a user, go to `POST /roosters/'rooster_id of rooster you want to follow'/followers`  
  To view who follows the Rooster `GET /roosters/'roosters id/followers`  
  To Block a Rooster `Delete /roosters/'roosters id/followers/follower_id`  

  To view who the Rooster follows `GET /roosters/'roosters id/follows`  
  To see the show page for the person they follow `GET /roosters/'roosters id/follows/follows-id`  

## Clucks

  At Roost, Clucks are post and you can create, delete, favorite and repost Clucks.  

### Post a Cluck

To post a cluck, go to `POST /cluck`  
  
The request body should be:  
```json
  {
    "body": "Content of your Cluck"  
  }
```
  Clucks validate on length, must be more then 2 characters and less then 280  

The repsonse will be:  
```json
  {
    "links": {
        "self": "http://roost-microblog.herokuapp.com/api/users/(roosterid)/posts/(cluckid))",
        "list": "http://roost-microblog.herokuapp.com/api/users/(roosterid)/posts",
        "delete": {
            "method": "DELETE",
            "href": "http://roost-microblog.herokuapp.com/api/users/(roosterid)/posts/(cluckid)"
        }
    },
    "data": {
        "user_id": RoosterId,
        "username": "(rooster-username",
        "attributes": {
            "id": CluckId,
            "body": "Content of your Cluck",
            "favorites_count": 0
        }
    }
  }
```
  The delete end point is in the above response  

### Favoriting a Cluck

  To have a Rooster favorite a cluck use:  
  `POST /roosters/:rooster_id/clucks/:cluck_id/favorites`  
  The response will be:  
  ```json
  {
    "data": {
        "type": "favorites",
        "id": favoritesID,
        "attributes": {
            "user_id": Rooster ID,
            "username": "Rooster Username"
        },
        "relationships": {
            "post": {
                "data": {
                    "id": Cluck ID,
                    "body": "Cluck Body COntent"
                },
                "links": {
                    "self": "/api/roosters/RoosterID"
                }
            }
        },
        "links": {
            "self": "/api/roosters/roosterID/clucks/cluckID/favorites",
            "list": "/api/roosters/roosterID/clucks/cluckID/favorites",
            "delete": {
                "method": "DELETE",
                "href": "/api/roosters/roosterID/clucks/cluckID/favorites"
            }
        }
    }
  }
  ```
  To unfavorite a post use:  
  `DELETE /roosters/:rooster_id/clucks/:cluck_id/favorites`  

### Repost a Cluck

  To Repost a Cluck use:  
  `POST /roosters/:rooster_id/clucks/cluck_id`  

  The response will be:  
  ```json
  {
    "links": {
        "self": "http://roost-microblog.herokuapp.com/api/roosters/rooster_id/clucks/cluck_id",
        "list": "http://roost-microblog.herokuapp.com/api/roosters/rooster_id/clucks",
        "delete": {
            "method": "DELETE",
            "href": "http://roost-microblog.herokuapp.com/api/roosters/rooster_id/clucks/cluck_id"
        }
    },
    "data": {
        "user_id": rooster_id,
        "username": "username",
        "attributes": {
            "id": cluck_id,
            "body": "REPOST of CLUCK CONTER",
            "favorites_count": 0
        }
    }
  }
  ```