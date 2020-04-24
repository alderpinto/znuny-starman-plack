FROM alpine:edge AS builder

# Note before you start:
# First build a tar of the source code: tar -czf build/angora-src.tar.gz --exclude build lib/perl services gui

# Add the alpine testing repository, for starman package
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Install apline packages for perl
RUN apk add tar make gcc build-base gnupg perl perl-dev perl-app-cpanminus
RUN apk add perl-plack perl-mojolicious perl-starman@testing

# Remove packages we won't need at runtime
RUN apk del make gcc build-base gnupg perl perl-dev perl-app-cpanminus

# Flatten the image and leave behind stuff we don't need
FROM scratch

COPY --from=builder /bin /bin/
COPY --from=builder /etc /etc/
COPY --from=builder /lib /lib/
COPY --from=builder /sbin /sbin/
COPY --from=builder /usr /usr/

RUN mkdir /tmp

ADD app.psgi /

CMD ["starman", "/app.psgi"]
