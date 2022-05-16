### Ubuntu에서 Visual Studio Code 한글 입력 안되는 현상 해결법

먼저 이미 설치되어 있는 snap 형식의 Visual Studio Code를 제거한다.

```
sudo snap remove code
````

다음 싸이트에서 .deb 형식의 Visual Studio Code를 직접 다운로드 받는다.

```
https://code.visualstudio.com/download
```

내려받은 .deb 파일을 다음과 같이 설치한다. 파일명은 Visual Studio Code 버전에 따라 다를 수 있다.

``` 
sudo dpkg -i code_1.40.2-1574694120_amd64.deb
```

설치 중에 의존 라이브러리가 없다는 메시지가 나오면, 다음을 한번 더 실행해 준다.

```
sudo apt -f install
```
