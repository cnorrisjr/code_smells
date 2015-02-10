# Introduction to Code Smells and Refactoring Techniques

![https://www.flickr.com/photos/mbshane/3165456548/](https://farm4.staticflickr.com/3131/3165456548_70fe4dc501.jpg)

## What is this code smell?

* This exercise focuses on case statements. Not sure what case
  statements are? Check it out
[here](http://sourcemaking.com/refactoring/shotgun-surgery)

## Let's get to the code

* We have several different types of accounts, all of which live under
  the account class

* All the tests pass, so why should we change anything?
   - We shouldn't! _unitl we have to add another bank account type_

* Pretend we're going to add another bank account type. Before we
  implement it, we're going to refactor the existing code

* Run tests with `bundle exec rake test`
