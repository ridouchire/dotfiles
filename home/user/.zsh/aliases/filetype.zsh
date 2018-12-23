if [ -f /usr/bin/emacs ]; then
    alias -s {txt,log,list}=emacs
fi

if [ -f /usr/bin/zathura ]; then
    alias -s {pdf,djvu}="nohup zathura"
fi

if [ -f /usr/bin/mpv ]; then
    alias -s {avi,mpeg,mpg,mov,m2v,flv}="nohup mpv"
    alias -s {ogg,mp3,wav,m3u,pls}="nohup mpv"
fi

if [ -f /usr/bin/gpicview ]; then
    alias -s {jpg,jpeg,png,gif,tif,tiff,bmp}="nohup gpicview"
fi
