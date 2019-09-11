# Assignment 2 - *Set*

One-player game of Set

## User Stories

**Required**:

* [ ] Screen should have room for 24 Set Cards, face up
* [ ] Game should start with 12 cards
* [ ] Deal 3 More Cards button should replace selected cards if match or add 3 cards to game
* [ ] Deal 3 button should be disabled if deck no longer exists or cant fit more cards
* [ ] User should be able to seelect up to 3 cards at a time and deselect as well
* [ ] Indication of the 3 selected cards are a set or mismatch
* [ ] If 3 non-matching cards are selected and another card is selected, deselect last 3 and select current
* [ ] If 3 cards match, replace cards with new cards if deck exists, else hide from UI. No cards should be selected
* [ ] Use `NSAttributedString` to draw Square Triangle and Circle
* [ ] Use a method that takes a closure as an argument
* [ ] Use an `enum` as part of the game
* [ ] Add an `extension` to the game code
* [ ] Autolayout with stack views
* [ ] New Game and Scoring

**Extra**:

* [ ] Factor speed of play into score
* [ ] Penalize pressing Deal 3 More Cards if Set available in visible cards
* [ ] "Cheat" button to help user find Set
* [ ] "Play against timer" mode
