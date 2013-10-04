require '../db/config'
require_relative './models/congressperson'

p Congressperson.select('title, firstname, lastname, state, party').where('state = ?', 'CA')
