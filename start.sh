#!/bin/bash

ende()
{
	exit
}
###################

menue()
{	echo "b)	Build and startup the docker-containers"
	echo "s)  	Setup the docker-containers"
	echo ""
	echo "r)  	Start the existing docker-containers"
	echo "x)  	Stop the docker-containers"
	echo "u)	Update the PXE-Server"
	echo ""
	echo "D)  	DELETE the existing docker-containers and docker images completely" 
	echo ""
	echo "EXIT 	Exit this script, but PXE-Server is running, if started"
	echo ""
	echo ""
	read -p "Your choice: " menue_wahl

	case "$menue_wahl" in
		b)
			clear
			mkdir samba srv
			git clone https://github.com/beta-tester/RPi-PXE-Server.git
			cp scripts/* RPi-PXE-Server
			docker-compose up -d
			docker exec -it pxe-container bash first_run.sh
			clear 
			echo "Please reboot!"
			exit
			;;
			#############################################

		s)
			clear
			docker-compose start
			docker exec -it pxe-container bash setup.sh
			docker-compose stop
			sudo systemctl restart rpcbind.service
			docker-compose start
			docker exec -it pxe-container bash update.sh
			clear
			echo "PXE-Server is running"
			echo ""
			menue
			;;
			#############################################

		r)	clear
			docker-compose start
			docker exec -it pxe-container bash update.sh
			clear
			echo "PXE-Server started"
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

		x)	clear
			docker-compose stop
			clear
			echo "PXE-Server stopped"
			echo ""
			menue
			;;
			#############################################

		D)	clear
			docker-compose down
			docker rmi  pxe-image:s6-test01
			echo "PXE-Server container and image deleted"
			echo ""
			clear 
			menue
			;;
			#############################################

		EXIT)	clear
			echo "Bye bye..."
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
