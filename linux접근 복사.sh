## Permission(접근권한) & Ownership ##

 -rw-r--r--. 1 root   root   0  2월  2 17:02 root_file
  ======   ========
  Permission   Ownership
  (접근권한)     (소유권) 


** Permission(접근 권한) **

- 리눅스는 사용자 계정에 따라 파일과 디렉터리의 접근 권한을 설정하여 허용된 계정만 해당 자원을
  사용할 수 있도록 제한하는 것이 가능하다.

 => Directory    :    d   r    w    x        r    w    x       r    w    x
 =>   File          :     -   r    w    x        r    w    x       r    w    x 
	                  -----------         ------------    ------------
		     4    2    1        4    2    1       4    2    1
	               Owner(소유자)   Group(그룹)    Other(기타)

 - 각 구간의 최소값 : 0  / 최대값 : 7

--------------------------------------------------------------------------------------
[ chmod ] : Permission 변경 명령어
 - 해당 파일/디렉터리 소유자와 root만 Permission을 변경할 수 있다.
 - chmod <Permission> <file/directory>
          -> Symbolic
          -> Numeric

1) Symbolic Method
 
  (+) : Permission 추가
  (-) : Permission 제거
  --------------------
  (u) : User-Owner(소유자)
  (g) : Group
  (o) : Other(나머지)
  (a) : All
  --------------------
  (r) : read(읽기)
  (w) : write(쓰기)
  (x) : execute(실행)

2) numeric method

-----------------------------------------------------------------------------------------------------------
<실습 1> /etc/ 디렉터리에 있는 inittab 파일을 (/home/mzc/)디렉터리에 복사 후 다음과 같이 변경
   1. numeric method 방법으로 변경  : rw- -w- -wx
   2. symbolic method 방법으로 변경 : -wx r-x rw-
   3. numeric method 방법으로 변경  : r-x -w- rw-

------------------------------------------------------------------------------------------------------------
** Directory와 File Permission 역할 차이점 **

1) Directory
 - 읽기(r) : 해당 디렉터리 내부 목록을 확인(ls), 디렉터리복사(cp)할 수 있는 권한.
 - 쓰기(w) : 해당 디렉터리 내부 파일을 생성(touch)/삭제(rm)/이동(mv) 등을 할 수 있는 권한.
 - 실행(x) : cd 명령어를 사용하여 해당 디렉터리 내부로 이동(cd)할 수 있는 권한.
                 디렉터리에 실행 권한이 없다면 해당 디렉터리 내부 파일들에 접근이 불가능.

2) File
 - 읽기(r) : 파일 열기와 내용 확인을 허용하는 권한.
 - 쓰기(w) : 해당 파일의 내용을 변경하는 것을 허용하는 권한. 
              (파일 생성/삭제/이동 등은 디렉터리의 쓰기 권한이 필요)
 - 실행(x) : 해당 파일이 실행 프로그램이거나 스크립트인 경우 실행할 수 있는 권한.


- Test 환경 구성 -

# mkdir -p /data/pertest/; cd /data/pertest/
# touch testfile
# echo "Permission Test" > testfile
# cd ..

# ls -l /data/pertest/
# ls -ld /data/pertest/

1) Other에 대해서 [/data/pertest/] 디렉터리 실행(x) 권한 제거

 # su - mzc
 $ ls -l /data/pertest/
 $ cd /data/pertest/
 $ cat testfile
  => 아직까지는 위의 명령어들이 정상적으로 처리된다.

 $ exit
 # chmod o-x /data/pertest/
 # ls -ld /data/pertest/
 # su - mzc

 $ ls -l /data/pertest/
 $ cd /data/pertest/
 $ cat /data/pertest/testfile

 => 디렉터리에 실행(x) 권한이 없는 경우 해당 디렉터리에서 정상적인 작업이 불가능하다.


2) Other에 대해서 [/data/pertest/] 디렉터리 실행(x) 권한만 부여

 # chmod o-r+x /data/pertest/
 # ls -ld /data/pertest/
 # su - mzc

 $ ls -l /data/pertest/
  ls: cannot open directory /data/pertest/: 허가 거부

 $ cd /data/pertest/
 $ ls
  ls: cannot open directory /data/pertest/: 허가 거부

 $ cat testfile
  Permission Test

 => 실행(x) 권한이 있기 때문에 이동이 가능하지만 디렉터리 목록을 확인하는 것이 불가능하다. 
    하지만 디렉터리 내부 파일명을 알고 있고 해당 파일에 대한 권한이 있다면 파일에 접근하는 것은
    가능하다.
 => 결과적으로 디렉터리 내부 파일들에 원활하게 접근하기 위해서는 해당 디렉터리에 대한 '읽기(r)'와
    '실행(x)' 권한이 필요하다.

3) Other에 대해서 [/data/pertest/] 디렉터리 모든 권한을 부여.

 $ exit
 # chmod o+r /data/pertest/
 # su - mzc

 $ touch /data/pertest/mzc_file1
  => 디렉터리에 대한 '쓰기(w)' 권한이 없기 때문에 파일 생성에 실패한다.

 $ exit
 # chmod o+w /data/pertest/
 $ touch /data/pertest/mzc_file1
  => 디렉터리에 대한 '쓰기(w)' 권한이 생겼기 때문에 파일을 생성하는 것이 가능하다.

 $ touch /data/pertest/testfile
  => Root가 생성한 'testfile' 삭제도 가능하다. 디렉터리 내부에 파일을 생성, 삭제하는 권한은
     파일 자체의 권한이 아닌 디렉터리의 '쓰기(w)' 권한에 의해서 결정된다.   

4) 파일의 쓰기(w) 권한 테스트

 $ exit
 # echo "Test111" > /data/pertest/root_file1
 # echo "Test222" > /data/pertest/root_file2 
 # ls -l /data/pertest/
 # chmod o+w /data/pertest/root_file2
 # ls -l /data/pertest/root*
 -rw-r--r--. 1 root root 8  4월  7 17:29 /data/pertest/root_file1
 -rw-r--rw-. 1 root root 8  4월  7 17:29 /data/pertest/root_file2

 # su - mzc
 $ echo "mzc_Test" >> /data/pertest/root_file1
  -bash: /data/pertest/root_file1: 허가 거부

 $ echo "mzc_Test" >> /data/pertest/root_file2 

 => 파일의 '쓰기(w)' 권한은 파일의 수정 가능 권한이지 삭제 여부를 결정할 수 있는 권한이 아니다.
    파일의 삭제 권한은 해당 파일이 들어있는 디렉터리의 '쓰기(w)' 권한에 의해서 결정된다.

5) 디렉터리 '읽기(r)' 권한 부여시 복사(cp) 테스트.

 # su - mzc
 $ cp -r /data/pertest/ .
   => 디렉터리 읽기(r)권한과 실행(x) 권한이 있기 때문에 디렉터리 자체와 내부 파일들을 
      정상적으로 복사하는 것이 가능하다.

 $ rm -rf pertest
 $ exit

 # chmod o-r /data/pertest/
 # su - mzc
 $ cp -r /data/pertest/ .
   => 디렉터리 읽기(r)권한이 없기 때문에 디렉터리 복사가 실패되는 것을 확인할 수 있다.

---------------------------------------------------------------------------------------------------------
** 소유자 / 소유그룹 변경 **

# ls -ld /home/manager1/

drwx------. 5  manager1  MGR   144  2월  2 16:19 /home/manager1/
                     [소유자] :[소유그룹]

- 기본적으로 파일/디렉터리를 생성한 계정이 소유자가 되고, 해당 계정의 그룹이 소유그룹이 된다.
  이를 상황에 따라 관리자가 변경하는 것이 가능하다.

- 파일 소유권 변경은 root계정만 가능하다.

[chown] : 소유권 변경 명령어

 # mkdir /backup/; cd /backup/
 # cp /etc/inittab /etc/login.defs /boot/grub2/grub.cfg .
 # ls -l

1) 소유자(Owner)만 변경
 # chown mzc inittab
 # ls -l inittab

2) 소유자, 소유그룹 모두 변경
 # chown mzc:MGR grub.cfg
 # chown mzc1.Sales login.defs
 # chown manager1. inittab

3) 소유그룹 변경
 # chown .MGR inittab
  => 소유그룹은 [chgrp] 명령어를 사용하는 것도 가능하다.


 # echo "Test File" > /home/manager1/testfile
 # ls -l /home/manager1/
 # su - manager1

 $ cat testfile 
  est File

 $ echo "Test 2222" >> testfile
  -bash: testfile: 허가 거부

 $ exit
 # chown manager1. /home/manager1/testfile
 # ls -l /home/manager1
 # su - manager1 
 $ echo "Test 2222" >> testfile
 $ cat testfile 
  Test File
  Test 2222







