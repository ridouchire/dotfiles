portage_mask() {
    if [ $1 ] ; then
        echo "$1" >> /etc/portage/package.mask
    else
        echo "Invalig argument"
    fi
}

portage_unmask() {
    if [ $1 ] ; then
        echo "$1" >> /etc/portage/package.unmask
    else
        echo "Invalig argument"
    fi
}
