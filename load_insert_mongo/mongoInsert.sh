mongoimport  --type csv --headerline -d test -c persons < persons.csv
mongoimport  --type csv -f _id,name -d test -c departments < departments.csv
