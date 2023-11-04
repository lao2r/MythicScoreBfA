git checkout -b update
git checkout update
git remote add origin https://github.com/lao2r/MythicScoreBfA.git
git add ./
git commit -m "Daily udate"
git push -u -f origin update:main
