permission error

1. npm의 디렉터리 상태를 확인한다.

```
npm config get prefix

```

많은 경우 /uer/local일 것이다. 만약 /usr로 되어 있다면 option 2로 해결해야 한다.

2. npm의 디렉터리에 owner를 현재 사용자로 설정한다.

```
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
```
