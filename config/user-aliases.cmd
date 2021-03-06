;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof

;= aliases
ralias=@doskey /macrofile="%CMDER_ROOT%\config\user-aliases.cmd"
aliases=subl %CMDER_ROOT%\config\user-aliases.cmd
unalias=alias /d $1
;=aliash=alias

;= Shell
clear=cls
ls=gs ls -p --show-control-chars -F --color %CD%\ $*
ll=gs ls -pl  --show-control-chars -F --color %CD%\ $*
la=gs ls -pla  --show-control-chars -F --color %CD%\ $*
l=gs ls -pla  --show-control-chars -F --color %CD%\ $*
;=spath=spath
upath=spath -u
;=lib=
..=cd..
;=cd..=cd..
cd=cd /d $*
cdh=cd /d %HOME%
pwd=cd
ph=pushd $*
pp=popd $*
e.=explorer .
;=setv=set
h=type %CMDER_ROOT%\config\.history
clsh=echo.>%CMDER_ROOT%\config\.history
tit=cmd /c RenameTab "$*"

;= git
gl =git log --pretty=oneline --color --abbrev-commit --graph --decorate --all
gll=git log --pretty=oneline --color --abbrev-commit --graph --decorate --first-parent
gst=git status $*
gdt=git difftool $*
gh=type %HOME%\.gitconfig
gv=git --version

;= Sublime Text
sub="%CMDER_ROOT%\vendor\SublimeText\sublime_text.exe" $1 -new_console:s50V
subld=subl -n %CD%
pkg=cd /d %TOOLS%\SublimeText3\Data\Packages
pkgu=cd /d %TOOLS%\SublimeText3\Data\Packages\User

;= Network
ip=ipconfig
ipa=ipconfig /all
rp=route print
eth=netsh interface show interface
port=netstat -bano | findstr :$1
task=tasklist /fi "pid eq $1"

;= Tools
checksum=fciv.exe -both $*
vsclean=%TOOLS%\System\VSCleanRecent.reg
work=subl %TOOLS%\System\w.cmd
srv=wmic process call create "php -S localhost:8090 -t %cd%" & start http://localhost:8090
hdl=Seraph

;= npm
npmi=npm install --save $*
npmid=npm install --save-dev $*
npmu=npm uninstall --save $*
npmud=npm uninstall --save-dev $*

;= Gulp
gp=gulp $*

;= Composer
cpr=composer $*
cpru=composer update
cpr_=composer require $*
cprd=composer require --dev $*
cprr=composer remove $*
cprrd=composer remove --dev $*

;= docker
d=docker $*
dr=docker run $*
drn=docker run --name $*
dri=docker run -it $*
dh=docker $* --help
dhw=docker run hello-world
duber=docker run -dit --name uber --volume /var/shared/default:/var/shared ubuntu /bin/bash
dbh=docker exec -it $* /bin/bash
dps=docker ps
dpsa=docker ps -a
dpse=docker ps --filter status=exited
dpsl=docker ps -lq
dl=docker logs -f $*
di=docker images
dp=docker pull $*
ddt=docker diff $*
dci=docker commit $*
ds=@set image_name=%TOOLS%\Docker\Image\$1.tar $T docker save -o %image_name:/=-% $1
dload=docker load -i %TOOLS%\Docker\Image\$1.tar
drm=docker rm -f $*
drme=@FOR /f "tokens=*" %i IN ('docker ps --filter status^=exited --quiet') DO @docker rm %i
drmi=docker rmi $*
drmid=@FOR /f "tokens=*" %i IN ('docker images -f "dangling=true" -q') DO @docker rmi %i
dinf=docker info
dv=docker version

;= docker-machine
dm=docker-machine $*
denv=@FOR /f "tokens=*" %i IN ('docker-machine env %DOCKER_MACHINE_NAME%') DO @%i
dmcreate=docker-machine create --driver virtualbox %DOCKER_MACHINE_NAME%
dmcrt=docker-machine regenerate-certs %DOCKER_MACHINE_NAME%
dmrm=docker-machine rm %DOCKER_MACHINE_NAME%
dmls=docker-machine ls $*

dmstart=docker-machine start %DOCKER_MACHINE_NAME%
dmstop=docker-machine stop %DOCKER_MACHINE_NAME%
dmstatus=docker-machine status %DOCKER_MACHINE_NAME%

dmip=docker-machine ip %DOCKER_MACHINE_NAME%
dmsh=docker-machine ssh %DOCKER_MACHINE_NAME%
dsh=@FOR /f "tokens=*" %i IN ('docker-machine ip %DOCKER_MACHINE_NAME%') DO @ssh docker@%i -i %HOME%\.ssh\id_docker_%DOCKER_MACHINE_NAME%_rsa
dmv=docker-machine version
dmh=docker-machine $* --help

;= docker env
dtit=cmd /c RenameTab "%DOCKER_MACHINE_NAME%"
dvm=set DOCKER_MACHINE_NAME^=$1 && cmd /c RenameTab "$1" && @FOR /f "tokens=*" %i IN ('docker-machine env $1') DO @%i
ddefault=set DOCKER_MACHINE_NAME^=default && cmd /c RenameTab "default" && @FOR /f "tokens=*" %i IN ('docker-machine env default') DO @%i
dprod=set DOCKER_MACHINE_NAME^=production && cmd /c RenameTab "production" && @FOR /f "tokens=*" %i IN ('docker-machine env production') DO @%i

;= boot2docker
btdinit=pushd %TOOLS%\Docker && bash -c './boot2docker.sh --create-vm' && popd && @FOR /f "tokens=*" %i IN ('docker-machine env %DOCKER_MACHINE_NAME%') DO @%i
btd=pushd %TOOLS%\Docker && bash -c ./boot2docker.sh && popd && @FOR /f "tokens=*" %i IN ('docker-machine env %DOCKER_MACHINE_NAME%') DO @%i
btdre=pushd %TOOLS%\Docker && bash -c './boot2docker.sh --sync' && docker-machine stop %DOCKER_MACHINE_NAME% && bash -c ./boot2docker.sh && popd && @FOR /f "tokens=*" %i IN ('docker-machine env %DOCKER_MACHINE_NAME%') DO @%i
btdload=pushd %TOOLS%\Docker && bash -c './boot2docker.sh --load-images' && popd
btdbck=pushd %TOOLS%\Docker && bash -c './boot2docker.sh --backup-images' && popd
btdsync=pushd %TOOLS%\Docker && bash -c './boot2docker.sh --sync' && popd
btdcrt=pushd %TOOLS%\Docker && bash -c './boot2docker.sh --regen-certs' && popd

;= IIS
slist=tasklist /FI "IMAGENAME eq w3wp.exe"
skill=taskkill /F /FI "IMAGENAME eq w3wp.exe"
tfs_clean=tfpt uu /noget /r *
