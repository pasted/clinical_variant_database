#Clinical Variant Database
Rails application for storing and parsing clinical exome VCF files.
Gene annotations can be retrieved via Biomart integration from Ensembl dataset.

##Features

- [x] VCF file upload and parsing.
- [x] Serialised storage of hashed values into postgreSQL Hstore field.
- [x] Integration with Biomart (hsapiens_gene_ensembl, omim), other datasets can also be interrogated.
- [x] Integration with Provean (Protein Variation Effect Analyzer) via Mechanize
- [x] Pagination,Search and sorting functionality for Variants, using Ransack and Kaminari.
- [x] Batch update of Gene/Disorder annotation using Sidekick / redis workers.
- [ ] Relationships between Samples to reflect parent-offspring by Closure trees.

##Installation

Requires: 
 * [PostgreSQL](http://http://www.postgresql.org/)
 * [Redis](http://redis.io)
 * [Ruby 1.9.2 or newer](http://www.ruby-lang.org/en/)
 * [Rails 3.2](http://rubyonrails.org/)

Clone the repository to your web server's public directory, initiallizing Git if required;

```bash
	git init
	git clone https://github.com/pasted/clinical_variant_database.git
```

The **config/database.yml** file is not included in the repository, the template is included below(along with the increased number of 
database connections for use with Sidekiq / Redis). Modify to include your database username and password, then save in the config
directory.

```ruby

development:
  adapter: postgresql
  encoding: utf8
  reconnect: false
  database: evd_development
  pool: 25
  username: 
  password: 
  host: localhost

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: postgresql
  encoding: utf8
  reconnect: false
  database: evd_test
  pool: 25
  username: 
  password: 
  host: localhost

production:
  adapter: postgresql
  encoding: utf8
  reconnect: false
  database: evd_production
  pool: 25
  username: 
  password: 
  host: localhost

```
Then run the following commands in the app directory;
 
```bash
	bundle install
	rake db:create
	rake db:migrate
	rake db:seed
```
To start the application, first start up Redis by typing the following in the directory that you have installed redis.

```bash
	redis-server redis.conf
```
Then start Sidekiq in the application directory

```bash
 	 bundle exec sidekiq
```
More information on Sidekiq can be found on it's [homepage](http://sidekiq.org).
Finally if not using another webserver, such as Apache - start Rails webrick server (in the application directory)

```bash
	rails s
```
