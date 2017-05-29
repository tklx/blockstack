## update changelog, create signed tag and push to github

```
contrib/generate-changelog > CHANGELOG.tmp
mv CHANGELOG.tmp CHANGELOG.md
$EDITOR CHANGELOG.md # verify version is correct and tweak 
VERSION=$(head -1 CHANGELOG.md | awk '{print $2}')
git add CHANGELOG.md
git commit -m "changelog: updated for $VERSION release"
git tag -s -m "$VERSION release" $VERSION
git push github
git push github --tags
```

## create new github release

- https://github.com/tklx/blockstack/releases/new
- select $VERSION tag
- set description as $VERSION
- copy/paste entry from CHANGELOG.md and tweak
- mark pre-release if relevant
- publish

## update dockerhub full description (until automated)

- https://hub.docker.com/r/tklx/blockstack/
- remove main header
- join lines in README.md (dockerhub doesn't handle line breaks correctly)
- copy/paste into full description.

