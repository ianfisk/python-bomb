# Build and create a new secret: WETTY_PW=????? docker build -t web-terminal --label wetty --secret id=student_pw,env=WETTY_PW .
# After the secret is created, docker build -t web-terminal --label wetty . is sufficient because the secret can't be changed.
# Run: docker run -p 3000:3000 web-terminal
# List container IDs: docker ps --filter label=wetty --format "{{.ID}}"
# Stop running container(s): docker stop $(docker ps --filter label=wetty --format "{{.ID}}")
# Remove all stopped container(s): docker rm $(docker ps -a --filter label=wetty --format "{{.ID}}")
# Get a shell in a container: docker exec -it <container> /bin/sh
# Load http://localhost:3000/wetty or http://<hostname>.local:3000/wetty (use `hostname` command)
# (This uses the Multicast DNS TLD https://unix.stackexchange.com/a/255713 and works on my Mac machine.)

# Docker secrets notes:
# - As long as the **same** secret ID is used (e.g., "student_pw"), the value
#   of the secret cannot be changed even if changing the env-variable value when
#   building the image.
# - Update the secret ID to one not previously used => you can change secret value.

FROM wettyoss/wetty:latest

RUN apk add python3
RUN python3 -m ensurepip
RUN pip3 install --no-cache uncompyle6

RUN chmod 750 /home/node
RUN --mount=type=secret,id=student_pw \
		STUDENT_PW=$(cat /run/secrets/student_pw) && \
		adduser --disabled-password -h /home/student -s /bin/sh student && \
		echo "student:$(echo $STUDENT_PW)" | chpasswd

COPY ./.profile /home/student/.profile

COPY ./pyc2bytecode.py /home/student/pyc2bytecode.py
COPY ./bomb.py /home/student/bomb.py
RUN python3 -m py_compile /home/student/bomb.py && \
		mv /home/student/__pycache__/bomb*.pyc /home/student/bomb.pyc && \
		rm -rf /home/student/bomb.py /home/student/__pycache__

# Expose the port Wetty will listen on (default is 3000)
EXPOSE 3000

# Start Wetty when the container runs
CMD ["wetty", "--port", "3000"]
