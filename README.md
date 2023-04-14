# This repository contains bash scripts

## Tasks
- [x] #739
- [ ] https://github.com/octo-org/octo-repo/issues/740
- [ ] Add delight to the experience when all tasks are complete :tada:

## References
* Refer: https://www.macs.hw.ac.uk/~hwloidl/Courses/LinuxIntro/x945.html  
* Refer for color and text improve : https://misc.flogisoft.com/bash/tip_colors_and_formatting  
* Logging: https://www.cubicrace.com/2016/03/efficient-logging-mechnism-in-shell.html


## Linux Useful Commands
```
# To make variable local inside function
> typeset  
> typeset -i x ##integer

> declare  
> declare -l lstr="ManoJ" #automatically convert into lowercase variable  
> -r for readonly  
  
#first goes into a and rest in b 
> read a b 

> seq 1 5  -- prints 1 2 3 4 5  
> {1..5}  -- prints 1 2 3 4 5  
  
> var=$(function_name) #to capture function output

> export -f function_name  #to export function  

> |& #it will send both stdout and stderr to next command  

> x=abc  
> abc=def  
> echo ${!x} #will print def

> a=${x:-dog} #a will set to value of x. If x is not set then a to dog but not x  
> a=${x:=dog} #will set a as well as x to dog 

> echo ${string:4} #will print all char from 5th position  
> echo ${string:4:3} #will print only 3 char from 4th posistion   

> ${p#var} #removes prefix var from p  
> ${p%var} #removes suffix var from p  

> coproc ./test.sh -- will run test.sh in background  
> $ echo bannaa >&"${COPROC[1]}"  
> $ cat <&"${COPROC[0]}"  
```  

## Linux Notes
* use GETOPT to unravel the arguments pass to script
