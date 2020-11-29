#!/bin/sh

echo "Deleting old publication"
rm -rf public

echo "Checking out gh-pages branch into public"
git clone https://github.com/PGiatasti/pgiatasti.github.io -b gh-pages public

echo "Removing existing files"
cd public
rm -rf $(ls | grep -v CNAME | grep -v '.git')

echo "Generating site"
cd ..
hugo || exit 1

cd public
echo "Updating gh-pages branch"
git add --all && git commit -m "Publishing to gh-pages" && git push origin gh-pages || exit 1

cd ..
rm -rf public
git add --all && git commit -m "Publishing to main" && git push origin main || exit 1
