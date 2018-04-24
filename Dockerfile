FROM debian:stretch

MAINTAINER Mark Hilton "nerd305@gmail.com"

RUN apt-get update && apt-get install -y git

RUN mkdir /root/.ssh/ && \
	mkdir /repository && \
	touch /root/.ssh/known_hosts && \
	ssh-keyscan -H github.com >> /root/.ssh/known_hosts && \
	ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts && \
	echo "\nStrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD init.sh /
RUN chmod +x /init.sh

# Clean up
RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/init.sh"]
