#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# snow_dark scheme by nightsense (https://github.com/nightsense/snow)

color00="28/2e/36" # Base 00 - Black
color01="d4/7b/7d" # Base 08 - Red
color02="64/a3/69" # Base 0B - Green
color03="ad/91/51" # Base 0A - Yellow
color04="61/98/d6" # Base 0D - Blue
color05="ba/81/bf" # Base 0E - Magenta
color06="00/a4/ac" # Base 0C - Cyan
color07="9f/ad/c2" # Base 05 - White
color08="30/38/45" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="de/e3/eb" # Base 07 - Bright White
color_foreground="9f/ad/c2" # Base 05
color_background="28/2e/36" # Base 00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf 'Ptmux;]4;%d;rgb:%s\\' $@; }
  put_template_var() { printf 'Ptmux;]%d;rgb:%s\\' $@; }
  put_template_custom() { printf 'Ptmux;]%s%s\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf 'P]4;%d;rgb:%s\' $@; }
  put_template_var() { printf 'P]%d;rgb:%s\' $@; }
  put_template_custom() { printf 'P]%s%s\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed "s/\///g"); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf ']4;%d;rgb:%s\' $@; }
  put_template_var() { printf ']%d;rgb:%s\' $@; }
  put_template_custom() { printf ']%s%s\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg #9fadc2 # foreground
  put_template_custom Ph #282e36 # background
  put_template_custom Pi #9fadc2 # bold color
  put_template_custom Pj #6198d6 # selection color
  put_template_custom Pk #282e36 # selected text color
  put_template_custom Pl #9fadc2 # cursor
  put_template_custom Pm #282e36 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color_foreground
unset color_background
