1.

```
sudo apt update
```
2.

nmv 설치 링크
https://github.com/nvm-sh/nvm

3.

node 설치
```
nvm install node
```
4. 
npm 설치
```
sudo apt install npm
```
5.
gitclone 하기위해서 ssh 생성

test 진행


+++ 세션 만료시 nvm 사라지는 문제
```
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```
