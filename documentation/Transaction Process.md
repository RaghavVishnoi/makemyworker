Requests are created when a user asks a question or requests a gig. They have a `status` indicating where in the transaction process they are:
[block:parameters]
{
  "data": {
    "h-0": "Status",
    "h-1": "Indicator",
    "0-0": "1",
    "0-1": "Inquiry opened by Buyer",
    "1-1": "Requested by Buyer",
    "2-1": "Requested by Buyer",
    "3-1": "Accepted by Seller",
    "4-1": "Cancelled by Seller",
    "5-1": "Cancelled by Buyer",
    "6-1": "Marked as Completed by Seller",
    "1-0": "2",
    "2-0": "3",
    "3-0": "4",
    "4-0": "5",
    "5-0": "6",
    "6-0": "7"
  },
  "cols": 2,
  "rows": 7
}
[/block]
# Buyer "Asks a question" to seller

1. Buyer sees and taps a gig on homescreen
2. Buyer taps on "Ask a question" and types the question he'd like to ask and submits. `This creates status 1`
3. Seller receives message in inbox saying "{buyer_name} has an inquiry about {gig_title}."





# Seller accepts a gig request
1. Buyer sees and taps a gig on homescreen
2. Buyer taps on request now `This creates status 2`
3. Seller receives message in inbox saying "{buyer_name} has requested {gig_title}. Would you like to accept?"
4. Seller presses Accept `This creates status 4`
5. Buyer receives message saying, "{seller_name} has accepted the request!"
6. Seller taps "Mark as completed" when the gig is completed. `This creates status 7`
7. Buyer receives message saying "{seller_name"} has completed the request!"



# Seller declines a gig request
1. Buyer sees and taps a gig on homescreen
2. Buyer taps on request now `This creates status 2`
3. Seller receives message in inbox saying "{buyer_name} has requested {gig_title}. Would you like to accept?"
4. Seller presses Decline `This creates status 3`
5. Buyer receives message saying, "{seller_name} has declined the request!"



# Gig in which buyer cancels
## Buyer has the opportunity to cancel within the first 5 minutes of making the request
1. Buyer sees and taps a gig on homescreen
2. Buyer taps on request now `This creates status 2`
3. Seller receives message in inbox saying "{buyer_name} has requested {gig_title}. Would you like to accept?"
4. Seller presses Accept `This creates status 4`
5. Buyer receives message saying, "{seller_name} has accepted the request!"
6. Buyer presses 3 dots icon at top right and presses cancel and confirms cancellation in under 5 minutes `This creates status 6`
7. Seller receives message saying the buyer cancelled

### If buyer tries to cancel after 5 minutes, he will get popup message saying "Are you sure? There will be a $5 cancellation charge if you cancel after 5 minutes of request?"



# Gig in which seller cancels
## Seller can cancel at anytime if they are unable to complete a gig.
1. Buyer sees and taps a gig on homescreen
2. Buyer taps on request now `This creates status 2`
3. Seller receives message in inbox saying "{buyer_name} has requested {gig_title}. Would you like to accept?"
4. Seller presses Accept `This creates status 4`
5. Buyer receives message saying, "{seller_name} has accepted the request!"
6. Seller presses 3 dots icon at top right and presses cancel and confirms cancellation `This creates status 5`
7. Buyer receives message saying the seller cancelled
