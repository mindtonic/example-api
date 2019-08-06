# EXAMPLE Api

## Notes

###### Ruby version
2.6.2

###### Rails version
5.2.3

###### Current API version
1

###### Running Locally
Type `rails server` into the Terminal. The site will appear at `http://localhost:3000`.

###### Test Suite
Tests are built in Rspec, to run the suite type `rspec spec`.

###### Database Seeds
Running `rake db:seed` will prepopulate the database with an ApiKey and a few
pieces of content for local testing.

---

# API Specifications

### Versioning

The API is versioned by defining the version in the URL as defined below.

*Current API version: 1*

### Authentication

All requests must be validated with an ApiKey made up of a key and a secret.
If the ApiKey has an ip address assigned to it, all requests will be validated
against the ip address. If the addresses do not match, the request will be rejected.
All keys and secrets must be unique, but it is possible to assign more than one
public_token to an IP Address. It is also possible to deactivate a public_token
by setting `active` to false.

All API Requests are expected to have the key and secret passed through the
request headers. For this reason, it is crucial that the application be SSL
encrypted in production. Rails is set to force_ssl so this should not be an
issue.

The headers should be formatted in this manner:

| Key  | Value |
| --- | --- |
| X-Api-Key | Value of the API Token Key |
| X-Api-Secret | Value of the API Token Secret |

The IP Address will be autodetected from the request.

All requests that require a primary key to request an object will utilize a
`public_token` UUID. This public_token should be auto generated whenever a new
object is created. This is a security requirement allowing the `public_token`
to be regenerated without affecting the id or primary key of the object. The
`public_token` will be a part of the url itself per the specifications below.

### Pagination

When an endpoint is paginated, it will include the pagination information in the
response.

To request a specific page, append the url with the `?page=` attribute.

**Example**

    /v1/boards?page=4

**Response 200**

        {
            "pagination": {
                "count": 100,
                "limit_value": 25,
                "total_pages": 4,
                "current_page": 2,
                "next_page": 3,
                "prev_page": 1,
                "first_page?": false,
                "last_page?": false,
                "out_of_range?": false
            }
        }

### Common Error Responses

The following responses can be expected on most endpoints unless otherwise
mentioned in the specifications below.

**Response 401**

        {
            "error": "Not Authorized"
        }

**Response 403**

        {
            "error": "Forbidden Request"
        }

**Response 404**

        {
            "error": "Invalid Public Token"
        }

---

# Object Schema

## Board

        {
            public_token: "708a35c6-be5c-4f5e-ec69-230b682b8cc7",
            tags: ["VLC", "DMA040.4.1"],
            name: "Agent's Commission - Simulation",
            description: "Best description text ever.",
            id: 58319
        }

| Attribute  | Data Type  | Example  | Description  |
| --- | --- | --- | --- |
| public_token | UUID | 708a35c6-be5c-4f5e-ec69-230b682b8cc7 | A UUID for public requests |     
| name | String | Agent's Commission - Simulation | The name of the board |        
| description | String | Best description text ever. | A description of the board |                   

---

# API Endpoint Specifications

## Status

The Status endpoint is purely for security testing. It could also be used as a
checkpoint for external applications to insure that the API is running as expected.

| Endpoint  | Method  | Controller  | Action  |
| --- | --- | --- | --- |
| `/` | GET | HomeController | index |
| `/status` | GET | HomeController | index |

**Response 200**

        {
            "app": "Example API",
            "status": "Happy",
            "environment": "staging",
            "time": "2019-06-20T17:46:20.072-04:00"
        }

## All Boards

Looks up the board using the `token` and returns the content
stream of that board in a single list

| Endpoint | Method | Controller | Action | Paged |
| --- | --- | --- | --- | --- |
| `/v1/boards` | GET | BoardsController | index | true |

**Response 200**

        {
            "pagination": {
                "count": 1,
                "limit_value": 25,
                "total_pages": 1,
                "current_page": 1,
                "next_page": null,
                "prev_page": null,
                "first_page?": true,
                "last_page?": true,
                "out_of_range?": false
            },
            "boards": [{
                "name": "MyString",
                "description": "MyText",
                "public_token": "c49b74b7-fa52-428e-b06c-f6aab2c9ec78"
            }]
        }

## Board Lookup

Looks up the board using the `token` and returns the content
stream of that board in a single list

| Endpoint | Method | Controller | Action |
| --- | --- | --- | --- |
| `/v1/boards/:public_token` | GET | BoardsController | show |

**Response 200**

        {
            "board": {
                "name": "MyString",
                "description": "MyText",
                "public_token": "2515f89f-070b-449f-b330-f6eeb3fd14e0"
            },
            "saved_boards": [{
                "name": "MyString",
                "description": "MyText",
                "public_token": "2b255faf-a38c-46e0-9510-e308f57d5ba5"
            }]
        }

## Create Save

Pin the content defined by the `saveable_token` to the board defined by the `token`.

| Endpoint | Method | Controller | Action |
| --- | --- | --- | --- |
| `/v1/boards/:public_token/save/:saveable_token` | POST | SavesController | create |

**Response 200**

        {
            "board": {
                "name": "MyString",
                "description": "MyText",
                "public_token": "2515f89f-070b-449f-b330-f6eeb3fd14e0"
            },
            "saved_boards": [{
                "name": "MyString",
                "description": "MyText",
                "public_token": "2b255faf-a38c-46e0-9510-e308f57d5ba5"
            }]
        }

## Remove Save

Remove the content defined by the `content_id` to the board defined by the `token`.

| Endpoint | Method | Controller | Action |
| --- | --- | --- | --- |
| `/v1/boards/:public_token/save/:content_id` | DELETE | SavesController | destroy |

**Response 200**

        {
            "board": {
                "name": "MyString",
                "description": "MyText",
                "public_token": "2515f89f-070b-449f-b330-f6eeb3fd14e0"
            },
            "saved_boards": [{
                "name": "MyString",
                "description": "MyText",
                "public_token": "2b255faf-a38c-46e0-9510-e308f57d5ba5"
            }]
        }

Last Updated: 7 August, 2019
