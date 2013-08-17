#Exome Variant Database
Rails application for storing and parsing clinical exome VCF files.
Gene annotations can be retrieved via Biomart integration from Ensembl dataset.

##Features

- [x] VCF file upload and parsing.
- [x] Serialised storage of hashed values into postgreSQL Hstore field.
- [x] Integration with Biomart (hsapiens_gene_ensembl, omim), other datasets can also be interrogated.
- [x] Pagination,Search and sorting functionality for Variants, using Ransack and Kaminari.
- [x] Batch update of Gene/Disorder annotation using Sidekick / redis workers.
- [ ] Relationships between Samples to reflect parent-offspring by Closure trees.
