c="↵"

function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

function return_code {
        if [ $? -eq 0 ]; then echo -n ""; else  echo -n "${(l:COLUMNS:: :)?}"; fi
}

PROMPT='$ZSH_THEME_ERROR_CODE'
RPS1="${rc}"

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
ZSH_THEME_ERROR_CODE="%$(return_code)"
