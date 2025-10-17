#!/bin/bash

# VARs
h1=50 # tmux splitwindow percentage RIGHT WINDOW
h2=70 # tmux splitwindow percentage RIGHT WINDOW
v1=30 # tmux splitwindow percentage LOWER WINDOW

#### INIT-Windowset

# Open Speedometer
#tmux split-window -v -p $v1 "speedometer -b -r eth0 -t eth0"
#tmux split-window -v -p $v1 "speedometer -r eth0 -t eth0 -l -m 26214400"
tmux split-window -v -p $v1 "nload -z -i 10240 -o 10240 -u M eth0"

# Open TCPDUMP
tmux select-pane -t 1
tmux split-window -h -p $h2 "docker exec -it pxe-container bash tcpdump.sh"

# Open-SideWindow
tmux select-pane -t 0
tmux split-window -h -p $h1

# Select MainWindow
tmux select-pane -t 0

############################################################

ende()
{
    exit
}

############################################################

menue()
{
	echo "___________________________________________________________________________________________"
	echo "|                                                                                         |"
	echo "|                         PPPP         XX    XX        EEEEEEE                            |"
	echo "|                         PP PP         XX  XX         EE                                 |"
	echo "|                         PP  PP         XXXX          EE                                 |"
	echo "|                         PPPPP           XX           EEEEE                              |"
	echo "|                         PP             XXXX          EE                                 |"
	echo "|                         PP            XX  XX         EE                                 |"
	echo "|                         PP           XX    XX        EEEEEEE                            |"
	echo "|_________________________________________________________________________________________|"
	echo "|                                                                                         |"
	echo "|  id)    Install Docker                                                                  |"
	echo "|  ip)    Install other needed software (i.e. tcpdump, tmux...)                           |"
	echo "|                                                                                         |"
	echo "|  b)     Build the PXE-Image and startup the PXE-Container                               |"
	echo "|  s)     Setup the PXE-Server                                                            |"
	echo "|                                                                                         |"
	echo "|  r)     Start the existing PXE-Container                                                |"
	echo "|  x)     Stop the PXE-Container                                                          |"
	echo "|                                                                                         |"
	echo "|  e)     Edit 'p2-include-handle'-file                                                   |"
	echo "|  u)     Update the PXE-Server                                                           |"
	echo "|  f)     Fix permissions for samba-share                                                 |"
	echo "|                                                                                         |"
	echo "|  t)     Show TCPDUMP on port 67-69 of the PXE-Container                                 |"
	echo "|                                                                                         |"
	echo "|  p)     Run TAILS-Patch-Script. Tails has to be already downloaded an mounted!          |"
	echo "|         (see https://github.com/beta-tester/RPi-PXE-Server/issues/31)                   |"
	echo "|                                                                                         |"
	echo "|  D)     DELETE the existing PXE-Container and PXE-Iimage completely                     |"
	echo "|                                                                                         |"
	echo "|  EXIT   Exit this script, but PXE-Server is running, if started.                        |"
	echo "|                                                                                         |"
	echo "|_________________________________________________________________________________________|"
	echo ""
	read -p "Your choice: " menue_wahl

	case "$menue_wahl" in

		b)
			tmux select-pane -t 0.1
			tmux send-keys 'clear && mkdir -p samba srv && [ -d RPi-PXE-Server/.git ] || git clone https://github.com/beta-tester/RPi-PXE-Server.git && cp scripts/* RPi-PXE-Server && docker compose build --no-cache && docker compose up -d && docker exec -it pxe-container bash first_run.sh && tmux select-pane -t 0' C-m
			clear
			menue;;

			#############################################

		id)
			tmux select-pane -t 0.1
			tmux send-keys 'clear && bash ui/install_docker.sh && tmux select-pane -t 0' C-m
			clear
			menue
			;;

			#############################################

		ip)
                        tmux select-pane -t 0.1
			tmux send-keys 'clear && sudo apt-get update && sudo apt-get install -y speedometer tcpdump && tmux select-pane -t 0' C-m
                        clear
                        menue
                        ;;

                        #############################################


		s)
			tmux select-pane -t 0.1
			tmux send-keys 'clear && docker compose start && docker exec -it pxe-container bash setup.sh && docker compose stop && sudo systemctl restart rpcbind.service && docker compose start && docker exec -it pxe-container bash update.sh && tmux select-pane -t 0' C-m
			clear
			menue
			;;

			#############################################

		r)	tmux select-pane -t 0.1
			tmux send-keys 'clear && docker compose start && docker exec -it pxe-container bash update.sh && tmux select-pane -t 0' C-m
			clear
			menue
			;;

			#############################################

		e)	tmux select-pane -t 0.1
			tmux send-keys 'clear && nano RPi-PXE-Server/p2-include-handle && tmux select-pane -t 0' C-m
			clear
			menue
			;;

			#############################################

		u)	tmux select-pane -t 0.1
			tmux send-keys 'clear && docker exec -it pxe-container bash update.sh && tmux select-pane -t 0' C-m
			clear
			menue
			;;

			#############################################

		f)	tmux select-pane -t 0.1
			tmux send-keys 'clear && sudo chmod -R 0755 media/ && tmux select-pane -t 0' C-m
			clear
			menue
			;;

			#############################################

		x)	tmux select-pane -t 0.1
			tmux send-keys 'clear && docker compose stop' C-m
			tmux select-pane -t 0
			clear
			menue
			;;

			#############################################

#		t)	tmux select-pane -t 0.1
#			tmux send-keys 'clear && docker exec -it pxe-container bash tcpdump.sh' C-m
#			tmux select-pane -t 0
#			clear
#			menue
#			;;

			#############################################

		p)	tmux select-pane -t 0.1
			tmux send-keys 'clear && docker exec -it pxe-container bash tails-patch.sh' C-m
			tmux select-pane -t 0
			clear
			menue
			;;

			#############################################

		D)	tmux select-pane -t 0.1
			tmux send-keys 'clear && docker compose down && docker rmi pxe-image:latest' C-m
			tmux select-pane -t 0
			clear 
			menue
			;;

			#############################################

		EXIT)
			tmux kill-pane -t 3
			tmux kill-pane -t 2
			tmux kill-pane -t 1
			clear
			ende
			;;

			#############################################

		*)	echo ""
			echo "no possible choice, try again!"
			echo ""
			read -p "Continue with ENTER-KEY... " WEITER
			clear
			menue
			;;

			#############################################

	esac
}

clear
menue
