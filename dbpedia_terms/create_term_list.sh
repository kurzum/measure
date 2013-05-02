#!/bin/sh

rapper -g data/dbpedia_3.8.owl | grep 'ns#type' | grep 'Property>' | cut -f1 -d '>'  | sed 's/.*\///g;s/ /_/g' | > properties.raw
bzcat data/mappingbased_properties_en.ttl.bz2 | cut -f2 -d '>'  | sed 's/.*\///g;s/ /_/g' | uniq >>  properties.raw
bzcat data/infobox_properties_en.ttl.bz2 | cut -f2 -d '>'  | sed 's/.*\///g;s/ /_/g'  | uniq >>  properties.raw
bzcat data/mappingbased_properties_en.ttl.bz2 | cut -f2 -d '>' | sed 's/.*\///g;s/ /_/g'  | uniq >>  properties.raw

bzcat data/infobox_properties_en.ttl.bz2 | cut -f1 -d '>'  | sed 's/.*\///g;s/ /_/g'  | uniq >  entities.raw
bzcat data/disambiguations_unredirected_en.ttl.bz2 | cut -f1 -d '>'  | sed 's/.*\///g;s/ /_/g'  | uniq >>  entities.raw

rapper -g data/dbpedia_3.8.owl | grep 'ns#type' | grep 'Class>' | cut -f1 -d '>' | sed 's/.*\///g;s/ /_/g' > classes.raw
bzcat data/skos_categories_en.ttl.bz2 | cut -f1 -d '>'  | sed 's/.*\///g;s/ /_/g;s/Category://' | uniq  | uniq >>  classes.raw


cat properties.raw |  tr "[:upper:]" "[:lower:]" | sort -u > properties.final
cat entities.raw |  tr "[:upper:]" "[:lower:]" | sort -u > entities.final
cat classes.raw |  tr "[:upper:]" "[:lower:]" | sort -u > classes.final
exit 



exit
cd data 
wget http://downloads.dbpedia.org/3.8/en/skos_categories_en.ttl.bz2
wget http://downloads.dbpedia.org/3.8/dbpedia_3.8.owl

wget http://downloads.dbpedia.org/3.8/en/disambiguations_unredirected_en.ttl.bz2
wget http://downloads.dbpedia.org/3.8/en/mappingbased_properties_en.ttl.bz2
wget http://downloads.dbpedia.org/3.8/en/infobox_properties_en.ttl.bz2


