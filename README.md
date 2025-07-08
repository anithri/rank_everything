# Rank Everything

This is a Ruby On Rails 8 site that allows lists that can be ranked in multiple ways.  Ranking methods may include
Voting, Fiat and Comparison.

We are using TailwindCSS, DaisyUI, Pundit, Rails 8 Authorization and Rspec among other libraries.

## Schema
* Session to manage login state
* User to allow authentication and Authorization 
  * Team to allow multiple users to collaborate on lists
    * TeamRoles - pending - gives a user a specific type of role for the team
    * RankedLists - pending - A list to be ranked
      * ListRoles - considering? - list specific roles but adds complexity
      * RankingMethod - pending - data for specific ranking methods 
      * RankedItem - pending - an individual item to be ranked
        * Vote - pending - a voting event
        * VoteHistory - considering - a history of votes
        * VoteStatistics - considering - voting statistics
     * RankHistory - considering - A history of the ranks of all items in list 
     * RankStatistics - considering - ranking statistics
I'm unsure how the RankingMethods will work, and it may need multiple methods

## TODO
 * [x] rails initialization and configuration
 * [x] rails customization and gem installs
 * [x] generate Authorization including registration
 * [x] User Model
 * [x] Team Model
 * [x] TeamRole Model
 * [ ] RankedList Model
 * [ ] ListRole Model
 * [ ] RankedItem Model
 * [ ] RankingMethod Model
 * [ ] Vote Model
 * [ ] determine voting method, vote model, history and statistics
 * [ ] Schema Finalized 