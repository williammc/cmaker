
submodulepath=$1
git config -f .git/config --remove-section submodule.$submodulepath
git config -f .gitmodules --remove-section submodule.$submodulepath
echo "Remove directory from index"
git rm --cached $submodulepath
rm -rf $submodulepath
rm -rf .git/modules/$submodulepath
git add .gitmodules