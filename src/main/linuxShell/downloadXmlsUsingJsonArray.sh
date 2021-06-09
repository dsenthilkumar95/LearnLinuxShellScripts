cd $1
cd Fox_Distribution
jq -c '.[].storageUrl' /Users/skumar236/Downloads/foxInput.json | while read i; do
    eval "curl -O -u FOXCORP_distro_ml:Kc4t9YM6dc4qh2GgoFA8D3K6 $i"
done