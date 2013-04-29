#!/bin/sh

curl http://mappings.dbpedia.org/server/ontology/dbpedia.owl > dbpedia.owl
rapper -i rdfxml -o ntriples dbpedia.owl > dbpedia.nt

echo "Nr of classes"
grep -E '<http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2002/07/owl#Class> .' dbpedia.nt | wc -l

echo "Nr of datatypeproperties"
grep -E '<http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2002/07/owl#DatatypeProperty> .' dbpedia.nt | wc -l

echo "Nr of objectproperties"
grep -E '<http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2002/07/owl#ObjectProperty> .' dbpedia.nt | wc -l

echo "Nr of FunctionalProperties"
grep FunctionalProperty dbpedia.nt| wc -l

echo "usage of properties"
cut -f2 -d '>' dbpedia.nt | sed 's/<//;s/>//' | awk '{count[$1]++}END{for(j in count) print "<" j ">" "\t"count[j]}' 


grep '^<' -v  dbpedia.nt

grep '#equivalentClass' dbpedia.nt
