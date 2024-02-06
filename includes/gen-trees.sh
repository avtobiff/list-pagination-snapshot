echo "Generating tree diagrams..."

pyang -f tree --tree-line-length 69 ../ietf-list-pagination-snapshot@*.yang \
    > tree-ietf-list-pagination-snapshot.txt
