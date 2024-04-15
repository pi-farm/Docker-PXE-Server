#!/bin/bash

# VARs
h1=50 # tmux splitwindow percentage RIGHT WINDOW
h2=75 # tmux splitwindow percentage RIGHT WINDOW
v1=30 # tmux splitwindow percentage LOWER WINDOW

#### INIT-Windowset

# Open Speedometer
tmux split-window -v -p $v1 "speedometer -b -r eth0 -t eth0"

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
			tmux send-keys -t 1 C-z 'bash ui/build.sh' Enter
			tmux select-pane -t 0
			;;

			#############################################

		id)
			tmux select-pane -t 1
			tmux send-keys -t 1 C-z 'bash ui/install_docker.sh' Enter
			clear
			menue
			;;

			#############################################

		s)
			clear
			docker compose start
			docker exec -it pxe-container bash setup.sh
			docker compose stop
			sudo systemctl restart rpcbind.service
			docker compose start
			docker exec -it pxe-container bash update.sh
			clear
			echo "PXE-Server is running"
			echo ""
			menue
			;;

			#############################################

		r)	clear
			docker compose start
			docker exec -it pxe-container bash update.sh
			clear
			echo "PXE-Server started"
			echo ""
			menue
			;;

			#############################################

		e)	clear
			nano RPi-PXE-Server/p2-include-handle
			clear
			echo "Please update if you have changed the anything"
			echo ""
			menue
			;;

			#############################################

		u)	clear
			docker exec -it pxe-container bash update.sh
			clear
			echo "PXE-Server update finished"
			echo ""
			menue
			;;

			#############################################

		f)	clear
			sudo chmod -R 0755 media/
			clear
			echo "Permissions for Samba-Share fixed"
			echo ""
			menue
			;;

			#############################################

		x)	clear
			docker compose stop
			clear
			echo "PXE-Server stopped"
			echo ""
			menue
			;;

			#############################################

		t)	clear
			docker exec -it pxe-container bash tcpdump.sh
			clear
			echo "TCPDUMP stopped"
			echo""
			menue
			;;

			#############################################

		p)	clear
			docker exec -it pxe-container bash tails-patch.sh
			clear
			echo "Patch for Tails installed"
			echo ""
			menue
			;;

			#############################################

		D)	clear
			docker compose down
			docker rmi  pxe-image:latest
			echo "PXE-Server container and image deleted"
			echo ""
			clear 
			menue
			;;

			#############################################

		EXIT)
			#tmux send-keys -t 2 C-z 'c' Enter	
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
