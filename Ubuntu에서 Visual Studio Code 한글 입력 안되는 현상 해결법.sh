Ubuntu에서 Visual Studio Code 한글 입력 안되는 현상 해결법
Ubuntu 19.10에서 Visual Studio Code 사용 중 한영 전환키를 누르고 한글을 입력하려 했더니, 한글 입력이 안되고 영어만 계속 입력되는 현상을 발견했다. 그래서 인터넷을 검색해 봤더니 snap 형식의 Visual Studio Code를 설치한 경우에, Ubuntu의 입력기인 IBus와 충돌해서 일어나는 현상이라고 한다. 그런데 .deb 형식의 Visual Studio Code를 설치한 경우에는 그런 문제가 없다는 사실을 알게 되어, 설치해 봤더니 한글 입력이 정상적으로 이루어지는 것을 확인했다. 그래서 같은 문제를 겪는 사람들을 위해 이 해결법을 공유하고자 한다.

먼저 이미 설치되어 있는 snap 형식의 Visual Studio Code를 제거한다.

$ sudo snap remove code
다음 싸이트에서 .deb 형식의 Visual Studio Code를 직접 다운로드 받는다.

https://code.visualstudio.com/download

내려받은 .deb 파일을 다음과 같이 설치한다. 파일명은 Visual Studio Code 버전에 따라 다를 수 있다.

$ sudo dpkg -i code_1.40.2-1574694120_amd64.deb
설치 중에 의존 라이브러리가 없다는 메시지가 나오면, 다음을 한번 더 실행해 준다.

$ sudo apt -f install
