# Rank Everything

This is a Ruby On Rails 8 site that allows lists that can be ranked in multiple ways.  Ranking methods may include
voting, fiat insertion and comparison modes.

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
 * [X] RankedList Model
 * [ ] RankedItem Model
 * [ ] RankingMethod Model
 * [ ] Vote Model
 * [ ] determine voting method, vote model, history and statistics
 * [ ] Schema Finalized

## Views
I'm using TailwindCSS and DaisyUI for the views. Will work out working versions now, and will do another pass for
usability and beautification.

## Security
Rank Everything uses the Rails 8 authentication system, expanded to allow registrations.  It also uses Pundit for
authorization.  We use two modes for authorization.   One based on the user, and the other based on the team.  The
user mode provides guest, public, user, and admin access.  The team mode provides manager, editor, contributor, voter,
and member roles that are assigned to a user/team combination.

## RSpec testing
We are using RSpec for testing. I'm writing specs for models, roles, and policies, but pushing the request specs until
things there are more stable.