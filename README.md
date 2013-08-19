#Exome Variant Database
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

```bash
	bundle install
	rake db:create
	rake db:migrate
	rake db:seed
```
