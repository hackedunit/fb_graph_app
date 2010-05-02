# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fb_graph_session',
  :secret      => '475c94cf4addbc66b58d0304d8f0a552c734b093ffa860d41e3a2abd2c938156b9f4ab1f7fc6b4d30ae573c2c2533efa84750d14af7e8875bc92967a965fd9cf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
