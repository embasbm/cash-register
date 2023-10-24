## Notes
### Running in local
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

# Technical Evaluation Amenitiz Problem to Solve

You are the developer in charge of building a cash register. 

This app will be able to add products to a cart and compute the total price.

## Objective

Build an application responding to these needs. 

By application, we mean:
- ~~It has a UI, where the user is able to add products to a cart and compute the total price (it can be a simple CLI)~~
- It is usable while remaining as simple as possible
- It is readable
- It is maintainable
- It is easily extendable

## Technical requirements

- Use any of those languages you are comfortable (Ruby, Python, Go, .Net Core)
- Covered by tests
- Following TDD methodology

## Description

### Assumptions 

**Products Registered**
| Product Code | Name | Price |  
|--|--|--|
| GR1 |  Green Tea | 3.11€ |
| SR1 |  Strawberries | 5.00 € |
| CF1 |  Coffee | 11.23 € |

**Special conditions**

- The CEO is a big fan of buy-one-get-one-free offers and green tea. 
He wants us to add a  rule to do this.

- The COO, though, likes low prices and wants people buying strawberries to get a price  discount for bulk purchases. 
If you buy 3 or more strawberries, the price should drop to 4.50€.

- The VP of Engineering is a coffee addict. 
If you buy 3 or more coffees, the price of all coffees should drop to 2/3 of the original price.

Our check-out can scan items in any order, and because the CEO and COO change their minds  often, it needs to be flexible regarding our pricing rules.

**Test data**
| Basket | Total price expected |  
|--|--|
| GR1,GR1 |  3.11€ |
| SR1,SR1,GR1,SR1 |  16.61€ |
| GR1,CF1,SR1,CF1,CF1 |  30.57€ |


**Deliverable**

The codebase in a shared folder we can access to

**Things we are going to look into or ask about**

- Best practices  
- Commit history  
- Code structure and flow  
- Facility To make some changes to the code
- A proper readme with good explanation
