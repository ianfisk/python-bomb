# Defuse this Python Bomb

This repo provides a Linux docker container accessible to students over the web (and thus on Chromebooks) via Wetty. From there, students can use the command line to defuse the _bomb_ program.

## Building

1. Download the Python dissambler pyc2bytecode from its [git repo](https://github.com/knight0x07/pyc2bytecode). Students can use this program to disassemble the compiled "bomb" and determine the correct input to defuse it.
1. Build the image:
	```
	WETTY_PW=<your student pw> docker build -t web-terminal --label wetty --secret id=student_pw,env=WETTY_PW .
	```
1. Run the container:
	```
	docker run -p 3000:3000 web-terminal .
	```
1. Load `http://localhost:3000/wetty`, log in to the instance, and have fun trying to defuse the bomb.
	- Students on the same network can load your page using a `.local` domain URL:
		- Find your hostname using the `hostname` command.
		- Load the URL: `http://<hostname>.local:3000/wetty`

1. When you're done, you can tear down the container with:
	```
	docker stop $(docker ps --filter label=wetty --format "{{.ID}}")
	```

1. And finally, you can clean up old containers with:
	```
	docker rm $(docker ps -a --filter label=wetty --format "{{.ID}}")
	```
