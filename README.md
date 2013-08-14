#Exome Variant Database
Rails application for storing and parsing clinical exome VCF files.
Gene annotations can be retrieved via Biomart integration from Ensembl dataset.

##Features

- [x] VCF file upload and parsing.
- [x] Integration with Biomart (hsapiens_gene_ensembl), other datasets can also be interrogated.
- [ ] Search functionality for Variants.
- [ ] Batch update of Gene annotation using Sidekick / redis workers.
- [ ] Relationships between Samples to reflect parent-offspring by Closure trees.
