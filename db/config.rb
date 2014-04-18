require 'sequel'

# Database
Sequel.extension :migration
DB = Sequel.connect(ENV['DATABASE_URL'] || "postgres://localhost/ustaad")

