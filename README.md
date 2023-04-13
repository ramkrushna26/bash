## This repository contains bash scripts ##


* Refer: https://www.macs.hw.ac.uk/~hwloidl/Courses/LinuxIntro/x945.html  
* Refer for color and text improve : https://misc.flogisoft.com/bash/tip_colors_and_formatting  

* to make variable local inside function  
> typeset  

* #interger
> typeset -i x 

> declare  
> declare -l lstr="ManoJ" #automatically convert into lowercase variable  
> -r for readonly  

* first goes into a and rest in b 
> read a b 

> seq 1 5  -- prints 1 2 3 4 5  
> {1..5}  -- prints 1 2 3 4 5  

* to capture function output  
> var=$(function_name)

* to export function  
> export -f function_name  

* it will send both stdout and stderr to next command  
> |& 

* will print def
> x=abc  
> abc=def  
> echo ${!x} -   

* a will set to value of x. If x is not set then a to dog but not x  
> a=${x:-dog}

> a=${x:=dog} #will set a as well as x to dog  

> echo ${string:4} #will print all char from 5th position  
> echo ${string:4:3} #will print only 3 char from 4th posistion   

> ${p#var} #removes prefix var from p  
> ${p%var} #removes suffix var from p  

> coproc ./test.sh -- will run test.sh in background  
> $ echo bannaa >&"${COPROC[1]}"  
> $ cat <&"${COPROC[0]}"  
  
  
* use GETOPT to unravel the arguments pass to script  
