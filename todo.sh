#!/bin/bash

arg1="$1"
arg2="$2"

#if user doesnt pass in a command
if [[ -z "$arg1" ]] ; then
 echo "Add a command to './todo.sh' before running(add, list, del, clear)."
 exit 0
fi

#If user enters command in wrong order
commands=("add" "list" "del" "clear")
found=false

for cmds in "${commands[@]}"; do
    if [[ "$arg1" == "$cmds" ]]; then
        found=true
        break
    fi
done

if [[ "$found" = false ]]; then
    echo "The fisrt argument should be either add, list, del, clear"
    exit 1
fi


add() {
        
    if [[ "$arg1" == "add" ]]; then
         if [[ -z "$arg2" ]]; then
                echo "Add a second argument before running eg ./quiz add 'Pray'."
                exit 1
            fi

        if grep -i "$arg2" "tasks.txt" ; then
            echo "Task $arg2 already exist amongst your list of tasks"
            exit 1
        else
            echo "$arg2 - $(date)" >> "tasks.txt"
            echo -e "\e[32mTask $arg2 succesfully added to List\e[0m"    
        fi
    fi   
}

list() {
    if [[ "$arg1" == "list" ]]; then
        cat -n "tasks.txt"  #-n: display with line numbers
    fi
}

delete() {
    if [[ "$arg1" == "del" ]]; then
         #checking if arg2 is a num
        if [[ "$arg2" =~ ^[0-9]+$ ]]; then
            if sed -n "${arg2}p" tasks.txt | grep -q .; then
                sed -i "${arg2}d" tasks.txt
                echo -e "\e[32mYou removed task number $arg2 from your list of tasks\e[0m"
            else
                echo -e "\e[31mTask number $arg2 doesn't exist amongst list of task\e[0m"
                exit 1
            fi
        fi
    fi
}

toclear() {
    if [[ "$arg1" == "clear" ]]; then
        clear
    fi
}

add
list
delete
toclear
