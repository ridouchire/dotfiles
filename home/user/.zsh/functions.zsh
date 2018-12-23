chpwd() {
    print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

ccd() {
    cd $1 && ls
}

rnd() {
    name=$1
    vared -c -p 'Переименовать в: ' name
    command mv $1
    cd $1
}

mkd() {
    mkdir $1
    cd $1
}

unpack() {
    if [ -f $1 ] ; then
	case $1 in
	    *.tar.bz2)   tar xjf $1        ;;
	    *.tar.gz)    tar xzf $1     ;;
	    *.bz2)       bunzip2 $1       ;;
	    *.rar)       unrar x $1     ;;
	    *.gz)        gunzip $1     ;;
	    *.tar)       tar xf $1        ;;
	    *.tbz2)      tar xjf $1      ;;
	    *.tgz)       tar xzf $1       ;;
	    *.zip)       unzip $1     ;;
	    *.Z)         uncompress $1  ;;
	    *.7z)        7z x $1    ;;
	    *)           echo "$fg_bold[red]Ошибка:$reset_color Невозможно распаковать '$1'..." ;;
	esac
    else
	echo "$fg_bold[red]Ошибка:$reset_color '$1' - неподдерживаемый тип файла"
    fi
}

pack() {
    if [ $1 ] ; then
	case $1 in
	    tbz)    tar cjvf $2.tar.bz2 $2      ;;
	    tgz)    tar czvf $2.tar.gz  $2    ;;
	    tar)   tar cpvf $2.tar  $2       ;;
	    bz2) bzip $2 ;;
	    gz)  gzip -c -9 -n $2 > $2.gz ;;
	    zip)    zip -r $2.zip $2   ;;
	    7z)     7z a $2.7z $2    ;;
	    *)      echo "$fg_bold[red]Ошибка:$reset_color '$1' не может быть упакован через pack()" ;;
	esac
    else
	echo "$fg_bold[red]Ошибка:$reset_color '$1' - неподдерживаемый тип файла"
	echo "$fg_bold[white]Использование:$reset_color pack type_archive filename"
    fi
}
