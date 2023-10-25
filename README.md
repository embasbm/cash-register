## Notes
### Running in local
You must have Ruby **"3.0.0"** and rails **"7.0.8"**. Git pull the repo and within the main folder, run these commands:
1. ```bundle```
2. ```rake db:setup```
3. ```bin/rails db:migrate```
4. ```rails assets:precompile```
5. ```rails s``` and check  http://127.0.0.1:3000/ for results
6. To run the specs/tests locally: 
    - ```rspec```, might need to run ```rake db:test:prepare``` before.


### Infrastructure choice
* Due the fact we applying for a RoR dev role, we have decided to implement the challente solution with Ruby On Rails application, which will handle all data model, logic and testing.
* **Test**: to get started and develop the product following the TDD methodology, we will add Rspec and related gems: factory_bot_rails, faker, to make life easier. We might not use some of them right now, but, honestly, we think it's no hassle to have them included.
Pack to make testing easier. Might not use some of them, but it's not hassle to have them within the dev+test environment part 
* **Back office**: for admin purposes we will use active admin, all this without having users and autentication setup, because we consider this is out of scope, even it would be the first next task to implement. This is merely for show/demo purposes, and to access it we can use: http://localhost:3000/admin.
    `- It has a UI, where the user is able to add products to a cart and compute the total price (it can be a simple CLI)`
    * User: admin@example.com
    * Password: password
* **Money type**: since we have some model that handles money/currency column, we are considering adding a new gem to hanlde money values (money-rails)
* **Devise**: It a very wel knowd library used generally to manage user authentications. This will be handy to later on associate *Cart* model to each user signed in while shopping/buying.

### Data model
 - **Product**:  We have defined a Product model to represent the products with attributes like code, name, and price. We using a library `money-rails` to manage the value of the column *price*. 
 - **Cart**: so far it a very simple table where we will store the final amount the customer has to pay, we are using Money Rails package for this value as well.
 - **LineItem**: this is an inner table/model to implement the association between Cart and Product while holding the amount of each product within a single cart
 - **AdminUser**: admin to manage back office: "admin@example.com" - "password"
 - **User**: user to do the shopping: "user@example.com" - "password"

### Briefe git log history

Summarized and taken in account only those having `feat` prefix.

Defined the cart model with basic fields and specs.
Ensured proper display of price values converted from cents to decimal amounts.
Added an "amount" field to the product to control stock.
Established a basic inner association between the cart and product.
Added basic templating for the product list.
Implemented user and admin user roles with basic unit tests.
Required system users to log in first to access the product index page.
Added a foreign key from the cart to the user through a migration.
Established an association to link the cart to the user.
Created a new action on the cart controller to add products to the cart.
Implemented a callback on save for the cart to calculate the total price.
Calculated the total price only when cart lines have changes.
Added a button to add products to the cart.
Added flash messages when a product is added to the cart.
Ensured that a product must not have a negative quantity.
Products out of stock are not displayed.
Added a customer message when no products are available.
Implemented basic styling for authentication templates.
Fetched products with available stock.
Displayed the total current cart amount.
Settled the cart's total price after adding a product.
Showed cart lines in a disclosed format.
Added functionality to reset the cart.
Maintained cart lines in order.
Introduced some basic styling.
Added an alert message for when the cart is emptied.
Implemented styling and flash messages with a 5-second duration.
Added an extra Green Tea only if the cart has no other products.
Migrated to have prices per line within the cart.
Introduced a new field and fixed specs.
Maintained cart lines in order.
Applied a Green Tea rule at the cart level.
Settled line prices at the line item level.
Moved basic instance methods to the product model.
Switched to using product codes instead of product names for logic.
Added a constant for Coffee discount percentage.
