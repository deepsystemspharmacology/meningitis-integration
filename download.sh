#!/usr/bin/env bash
cd data
mkdir -p ontologies
cd ontologies

wget ftp://ftp.ebi.ac.uk/pub/databases/GO/goa/HUMAN/goa_human.gaf.gz -N -q
gunzip goa_human.gaf.gz -q -f

wget http://purl.obolibrary.org/obo/go/go-basic.obo

# if the above URL does not work, it should be possible to get the current basic-go with following Python script:
# from goatools.base import download_go_basic_obo
# download_go_basic_obo();

cd ..


wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/by_organism/HUMAN_9606_idmapping.dat.gz
zcat HUMAN_9606_idmapping.dat.gz | grep GeneID | cut -f 1,3 > uniprot_to_gene_id.tsv

cd hgnc
wget "https://www.genenames.org/cgi-bin/download/custom?col=gd_pub_ensembl_id&col=gd_pub_eg_id&status=Approved&hgnc_dbtag=on&order_by=gd_app_sym_sort&format=text&submit=submit" -O ensembl_gene_to_entrez.tsv
python clean_ensembl_entrez_mapping.py
cd ..
