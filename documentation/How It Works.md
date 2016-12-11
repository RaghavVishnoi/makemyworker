#App Flow Overview

##Buyer View
1. Buyer logs in
2. Buyer sets username and enables gps/notifications
3. Buyer chooses their city
3. Buyer browses through all available offers in their city
	- If GPS is enabled, then the offers are sorted by nearest first
	- Buyer can filter to see only specific neighborhoods if desired
4. Buyer taps on an offer to view more details
5. Buyer can choose to tap on "Request now" to initiate convo with seller
	- Alternative would be to choose "Ask a Question"
6. Once seller accepts the request, buyer receives acceptance message and offer has officially started
	- Alternative would be that seller declines the request
7. After accepted, when seller marks offer as completed, offer is officially complete and buyer is charged the offer price
	- Alternative 1 would be buyer cancels within 5 minutes, in which case buyer is not charged
	- Alternative 2 would be buyer cancels after 5 minutes, which case buyer is charged $5 cancellation charge
	- Alternative 3 would be seller cancels at anytime, in which case no one is charged
8. Both buyer and seller receive rating popup screen which allows them to rate the other on a scale of 1-5 and leave a comment


##Seller View
1. Seller logs in
2. Seller sets username and enables gps/notifications
3. Seller chooses their city
4. Seller taps on "Offers" icon in navbar to view their current offers
	- New user would not see any offers here as they have never created any
	- If new seller, they will be asked to "Connect to Facebook" and an optional background check
		- Completing Facebook Connect will give them a Facebook Verification badge on their profile
		- Completing the background check will give them a BG Check verified badge on their profile
5. Seller taps on "Add new offer" to begin creating
6. Seller sets the title, price, and area in which it will be available. Then hits publish.
	- Title is maximum 80 characters
	- Price is always rounded up to nearest whole dollar
	- Area can be chosen to be any number of specific neighborhoods, or the entire city
7. The newly created offer is now live
	- This can be toggled using the on/off switch which turns it on or off from view of buyers

`See Buyer view for transaction process`

8. After an offer is completed, the payment is processed and transferred to the seller's account
9. Seller can view their current $$ holdings by opening their wallet in their settings and may withdraw from that amount at any time
	- Wallet will also show transaction history for the user
