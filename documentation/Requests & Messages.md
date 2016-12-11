# Requests

Requests are created when a user asks a question or requests a gig.

## Database structure
- `id` - unique request id
- `gig_id` - related gig id
- `seller_id` - user who created the gig
- `buyer_id` - user who is requesting the gig
- `message_count` - number of messages related to this request
- `status` - current status of the request
- `flagged` - boolean for if an issue has been submitted or not
- `created_at` - timestamp
- `updated_at` - timestamp
- `deleted_at` - timestamp

#### Reminder: Request status' are VERY important
The request `status` possible options are:
`status = 1` Inquiry opened by Buyer
`status = 2` Requested by Buyer
`status = 3` Declined by Seller
`status = 4` Accepted by Seller
`status = 5` Cancelled by Seller
`status = 6` Cancelled by Buyer
`status = 7` Marked as Completed by Seller

When a request reaches a specific `status`, a message is automatically created as follows:
- 1 `{buyer_name} is interested in your offer.`
- 2 `{buyer_name} just requested your offer.`
- 3 `{seller_name} declined the request 😞`
- 4 `{seller_name} accepted your request 😄`
- 5 `{seller_name} cancelled the request. You will not be charged.`
- 6 `{buyer_name} cancelled the request.`
- 7 `{seller_name} completed your request.`

#### When to charge users for transactions
- A buyer is charged via Stripe for the gig's price when a request reaches the status `7`. The amount is transferred directly to the seller's account.
- A buyer is charged a $5 cancellation fee if he/she decides to cancel a request after 5 minutes since time of acceptance by the seller. If buyer cancels within the 5 minute time frame, he/she will not be charged anything.



## API Calls for Requests
All results should be relative to the authorized user.
1. [Create new request](#create-new-request)
2. [View request detail](#view-request-detail)
3. [List all incoming requests](#list-all-incoming-requests)
4. [List all outgoing requests](#list-all-outgoing-requests)
5. [Update Request Status](#update-request-status)
6. [Submit an issue](#submit-an-issue)

##### Create new request

```
POST /api/requests
```


##### View request detail

```
GET /api/requests/:id
```


##### List all incoming requests

```
GET /api/requests/incoming
```



##### List all outgoing requests

```
GET /api/requests/outgoing
```



##### Update request status

```
PATCH /api/requests/:id
```



##### Submit an issue

```
POST /api/requests/:id/issue
```


*********



# Messages

Once a request has been opened, the seller or the buyer have the ability to message each other at any time during the process as long as the request has a status of 1, 2, or 4.

## Database structure
- `id` - unique message id
- `request` - related request id
- `user_id` - user who created the message
- `content` - content of the message
- `type` - integer 0 indicates its an automated message from process (automated message when the status changes), 1 indicates its from buyer, or 2 indicates its from seller
- `created_at` - timestamp
- `updated_at` - timestamp
- `deleted_at` - timestamp

## API Calls for Requests
All results should be relative to the authorized user.
1. [Post new message in request](#post-new-message-in-request)
2. [List all messages in request](#list-all-messages-in-request)



##### Post new message in request

```
POST /api/requests/:id/messages
```



##### List all messages in request

```
GET /api/requests/:id/messages
```
