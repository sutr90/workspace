export PATH="$PATH:/d/tmp/mergator:/c/Users/fric/apps"
mvnver(){
	mvn versions:set -DnewVersion=$1 -DgenerateBackupPoms=false
}

gco() {
	winpty bash $HOME/gco.sh $1
}

gci() {
	if [[ $# -eq 0 ]] ; then
		git commit --no-edit
	else
		git commit -m "$1"
	fi
}

gfp() {
	git fetch
	git pull
}

gst() {
	git status
}

clean-log() {
	cp $1 "$1.bak"
	ORIGLINES=$(wc -l < $1)
	egrep -v "$2" $1 > /tmp/clean.tmp
	cp /tmp/clean.tmp $1.clean
	rm /tmp/clean.tmp
	mv $1.clean $1
	NEWLINES=$(wc -l < $1)
	echo "Removed  $(($ORIGLINES - $NEWLINES)) lines"
}

clean-log-prod() {
	cp $1 "$1.bak"
	ORIGLINES=$(wc -l < $1)
	egrep -v "o\.s\.t|vpv|VPV|Vpv|SQL|EntityAndIndexChangesService|ProcesService|SqlBuilder" $1 > /tmp/clean.tmp
	mv /tmp/clean.tmp $1
	NEWLINES=$(wc -l < $1)
	echo "Removed  $(($ORIGLINES - $NEWLINES)) lines"
}

git-interactive-change-branch() {
  local branches branch
  branches=$(git branch) &&
    branch=$(echo "$branches" | fzf +s +m) &&
    git checkout $(echo "$branch" | sed "s/.* //")
}

git-interactive-checkout-commit() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
}

alias gicb=git-interactive-change-branch
alias gicc=git-interactive-checkout-commit

pdf-decode() {
	java -jar /c/Users/fric/apps/pdfbox/pdfbox-app-2.0.17.jar WriteDecodedDoc $1 $2
}

mvndep() {
	mvn -B dependency:tree
}

tagcommit() {
	git rev-list -1 $1
}

alias jq=/c/Users/fric/apps/jq-win64.exe
