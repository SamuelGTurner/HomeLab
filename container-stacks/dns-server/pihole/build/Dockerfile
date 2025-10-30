FROM pihole/pihole:2025.10.3@sha256:7f2dff3f60615e1b9982824cab30e10d399bd1178691e13a96359ea50323db69

COPY setup.sh /usr/bin/setup.sh
RUN chmod +x /usr/bin/setup.sh

ENTRYPOINT [ "setup.sh" ]
